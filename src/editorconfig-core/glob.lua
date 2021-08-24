local Glob

Glob = {
  __index = Glob,
}

function Glob:new(glob)
  local o = {
    rawglob = glob,
  }
  setmetatable(o, self)
  o.__index = o
  return o
end

return Glob
