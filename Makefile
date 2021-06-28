lint:
	luacheck --codes `find -name "*.lua"`
	lua-format --check `find -name "*.lua"`
