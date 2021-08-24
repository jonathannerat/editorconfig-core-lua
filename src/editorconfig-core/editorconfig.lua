local Glob = require 'editorconfig-core/glob'
local log = require('editorconfig-core/utils').log
local validate = require('editorconfig-core/validate').validate

local nop = function(_, _) end

local Section = {}

local EditorConfig = {
  __tostring = function(self)
    local str = ''
    if self.root then
      str = str .. 'root = true\n'
    end

    for _, s in ipairs(self.sections) do
      str = str .. string.format('[%s]\n', s.glob.rawglob)
      for k, v in pairs(s.props) do
        str = str .. string.format('%s = %s\n', k, v)
      end
    end

    str = string.sub(str, 1, -2)

    return str
  end,
  sections = {},
  root = false,
  handlers = {
    -- whitespace
    ['^%s*$'] = nop,
    -- comments
    ['^%s*[;#]'] = nop,
    -- key-value pair
    ['^%s*(%S+)%s*=%s*(%S+)%s*'] = function(ec, key, value)
      if string.lower(key) == 'root' and string.lower(value) == 'true' then
        if #ec.sections == 0 then
          ec.root = true
        else
          log.debug "can't set root option inside a section"
        end
      else
        local section = ec:last_section()
        if section then
          if not section:define(key, value) then
            log.debug('invalid key-value pair: %s = %s', key, value)
          end
        else
          log.debug('invalid option out of section: %s = %s', key, value)
        end
      end
    end,
    -- section
    ['^%s*%[(.*)%]%s*$'] = function(ec, glob)
      ec.sections[#ec.sections + 1] = Section:new(glob)
    end,
  },
}

function EditorConfig:new(path)
  local o = { path = path }
  setmetatable(o, EditorConfig)
  self.__index = self
  self = o

  local f, err = io.open(self.path, 'r')

  if not err then
    for line in f:lines() do
      local linematched = false
      for matcher, handler in pairs(EditorConfig.handlers) do
        local matches = { string.match(line, matcher) }
        if #matches > 0 then
          linematched = true
          handler(self, unpack(matches))
        end
      end

      if not linematched then
        log.debug("invalid line: %s", line)
        return nil
      end
    end
  else
    log.debug("can't open file: %s", err)
    return nil
  end

  return self
end

function EditorConfig:last_section()
  return self.sections[#self.sections]
end

function Section:new(glob)
  local o = {
    glob = Glob:new(glob) or error('Invalid glob pattern: %s', glob),
    props = {},
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Section:define(key, value)
  value = validate(key, value)

  if value then
    self.props[key] = value
    return true
  end
end

return EditorConfig
