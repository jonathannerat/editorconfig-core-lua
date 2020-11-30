package = "editorconfig-core-lua"
version = "dev-1"
source = {
	url = "https://github.com/jonathannerat/editorconfig-core-lua"
}
description = {
	summary = "EditorConfig Core implementation written in Lua",
	detailed = [[
		This is an implementation of the [editorconfig-spec](https://editorconfig-specification.readthedocs.io/en/latest/)
		written in Lua, which can be used as a module or library.
	]],
	license = "MIT"
}
dependencies = {
	"lua >= 5.1",
}
build = {
	type = "builtin",
	modules = {
		editorconfig = 'lua/editorconfig-core/lib.lua'
	}
}
