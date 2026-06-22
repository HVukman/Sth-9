#+ignore
// for now ignored
package sth9 

import "core:dynlib"
import "core:fmt"
import luajit "luajit"
import luaL_luajit "luajit/luaL"

load_then_unload_my_library :: proc() {
	LIBRARY_PATH :: "my_library.dll"
	library, ok := dynlib.load_library(LIBRARY_PATH)
	if ! ok {
		fmt.eprintln(dynlib.last_error())
		return
	}
	did_unload := dynlib.unload_library(library)
	if ! did_unload {
		fmt.eprintln(dynlib.last_error())
		return
	}
	fmt.println("The library %q was successfully unloaded", LIBRARY_PATH)
}