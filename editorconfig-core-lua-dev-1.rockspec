rockspec_format = "1.1"
package = "editorconfig-core-lua"
version = "dev-1"
source = {
   url = "https://github.com/jonathannerat/editorconfig-core-lua"
}
description = {
   summary = "io/en/latest/) written in Lua to be used in Neovim.",
   detailed = [[
This is an implementation of the [editorconfig spec](https://editorconfig-specification.readthedocs.io/en/latest/)
written in Lua to be used in Neovim.
]],
   homepage = "https://github.com/jonathannerat/editorconfig-core-lua",
   license = "MIT"
}
dependencies = {
   "lua ~> 5.1"
}
build = {
   type = "builtin",
   modules = {
      ["editorconfig-core"] = "src/editorconfig-core.lua",
      ["editorconfig-core/editorconfig"] = "src/editorconfig-core/editorconfig.lua",
      ["editorconfig-core/glob"] = "src/editorconfig-core/glob.lua",
      ["editorconfig-core/utils"] = "src/editorconfig-core/utils.lua",
      ["editorconfig-core/validate"] = "src/editorconfig-core/validate.lua",
   }
}
