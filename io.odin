package sth9

import luajit "luajit"
import luaL_luajit "luajit/luaL"
import "core:os"
import "base:runtime"
import "core:strings"
import "core:fmt"
import rl "vendor:raylib"


// if file is dropped, return table of infos of dropped file
l_get_dropped_info :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    res_ := rl.IsFileDropped()
    dropped : rl.FilePathList
    defer rl.UnloadDroppedFiles(dropped)  
    filepath : cstring

    if res_ {

        dropped = rl.LoadDroppedFiles()
       
        filepath = dropped.paths[0]
        fd, err := os.open(string(filepath))
        alloc := runtime.default_allocator() 
        info_, err2 := os.fstat(fd, alloc)
        if err != nil{
           
            luaL_luajit.error(L, " Warning: could not read file %s", filepath)
            return 0
        }
        else
            {
   
                luajit.createtable(L,0,5)
                // get name
                newstr: cstring = strings.clone_to_cstring(info_.name)
                luajit.pushstring(L,  newstr)
                luajit.setfield(L,-2,"name")
                // get fullpath
                newstr = strings.clone_to_cstring(info_.fullpath)
                luajit.pushstring(L,  newstr)
                luajit.setfield(L,-2,"fullpath")
                // get size
                luajit.pushinteger(L, luajit.Integer(info_.size))
                luajit.setfield(L,-2,"size")
                // get access time
                luajit.pushinteger(L, luajit.Integer(info_.access_time._nsec))
                luajit.setfield(L,-2,"access_time")
                // get creation time
                luajit.pushinteger(L, luajit.Integer(info_.creation_time._nsec))
                luajit.setfield(L,-2,"creation_time")
                // get modification time
                luajit.pushinteger(L, luajit.Integer(info_.modification_time._nsec))
                luajit.setfield(L,-2,"modification_time")
                
                return 1
            }
    }else{
        return 0
    }

}

// returns bool if file was dropped
l_is_file_dropped :: proc "c" (L: luaL_luajit.State) -> i32{

    res_ := rl.IsFileDropped()
    dropped : rl.FilePathList
    filepath : cstring

    if res_ {
        dropped = rl.LoadDroppedFiles()
        filepath = dropped.paths[0]
    }

    

    luajit.pushboolean(L, i32(res_))
    return 1

}

/* 
glob returns the names of all files matching pattern or nil if there are no matching files The syntax of patterns is the same as "match". The pattern may describe hierarchical names such as /usr/ \* /bin (assuming '/' is a separator)
*/


/*
Gets the file extension from a path, including the dot.

The file extension is such that stem_path(path) + ext(path) = base(path).

Only the last dot is considered when splitting the file extension. See long_ext.

e.g.

'name.tar.gz' -> '.gz'
'name.txt'    -> '.txt'
*/


l_glob :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    name_:= luaL_luajit.checkstring(L,-1)
    pattern_ := strings.clone_from_cstring(name_)  
    
    matches, err := os.glob(pattern_)

    // put table on stack
    luajit.newtable(L)

    i:=1
    for match in matches {
        luajit.pushinteger(L,luajit.Integer(i)) // push index from 1
        luajit.pushstring(L, strings.clone_to_cstring(match)) // push match string
        luajit.settable(L,-3) // set table on stack
        i +=1
    }

   // return table on top of stack
    return 1
}

l_ext :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    name_:= luaL_luajit.checkstring(L,-1)
    ext_ := strings.clone_from_cstring(name_)  
    ext_ = os.ext(ext_)
    luajit.pushstring(L, strings.clone_to_cstring(ext_))

    return 1
}

/* 
Gets the parent directory path from a path.

e.g.

'/home/foo/bar.tar.gz' -> '/home/foo'
'path/to/name.tar.gz'  -> 'path/to'

Returns "." if the path is an empty string.
*/
l_dir :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    name_:= luaL_luajit.checkstring(L,-1)
    path_ := strings.clone_from_cstring(name_)  
    path_ = os.dir(path_)
    luajit.pushstring(L, strings.clone_to_cstring(path_))

    return 1
}

/* 
Gets the file name and extension from a path.

e.g.

'path/to/name.tar.gz' -> 'name.tar.gz'
'path/to/name.txt'    -> 'name.txt'
'path/to/name'        -> 'name'

Returns "." if the path is an empty string.
*/
l_base_file :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    name_:= luaL_luajit.checkstring(L,-1)
    path_ := strings.clone_from_cstring(name_)  
    path_ = os.base(path_)
    luajit.pushstring(L, strings.clone_to_cstring(path_))

    return 1
}




l_run_command :: proc "c" (L : ^luaL_luajit.State) -> i32 {
    // Create a pipe to capture stdout
    //comm_ := strings.
    ret_string : cstring
    context = runtime.default_context()
    command_:= luaL_luajit.checkstring(L^,-1)
    new_string := strings.clone_from_cstring(command_)

    command_struct_val : []string
    if ODIN_OS == .Windows{
        command_struct_val = {"cmd", "/C", new_string}
    }else{
        command_struct_val = { new_string}
    }

    state, stdout, stderr, err := os.process_exec({
		command = command_struct_val,
	}, context.allocator)
	defer delete(stdout)
	defer delete(stderr)

	if err == .Unsupported {
		fmt.println("process_exec unsupported")
		return 0
	}
    result := string(stdout)
    ret_string = strings.clone_to_cstring(result)
    fmt.println("result ", result)
    luajit.pushstring(L^, ret_string)
    return 1
}


l_read_file :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    input_ := luaL_luajit.checkstring(L,-1)
  alloc := runtime.default_allocator() 
    data, ok := os.read_entire_file_from_path(string(input_),alloc)

    assert(ok==os.ERROR_NONE, "Could not open file")
    defer delete(data)

    new_str := string(data)
    newstr: cstring = strings.clone_to_cstring(new_str)
    luajit.pushstring(L, newstr)
    return 1
}

l_write_file :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    input_ := luaL_luajit.checkstring(L,-1)
    new_str := string(input_)

    name_ := luaL_luajit.checkstring(L,-2)
    new_str_name := string(name_)

    transmute_input := transmute([]u8)new_str
    write := os.write_entire_file_from_string(new_str_name,string(transmute_input))

    // If error than do something
    if (write!=os.ERROR_NONE){
        luaL_luajit.error(L, "could not write file")
        return 0
    
    }else{
        return 0
    }

 
}

// checks if file exists, returns bool
l_exist_file :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    input_ := luaL_luajit.checkstring(L,-1)
    bool_file := os.exists(string(input_))

    luajit.pushboolean(L, i32(bool_file))
    return 1

}

// changes working directory
l_change_directory :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    input_ := luaL_luajit.checkstring(L,-1)

    err:= os.change_directory(string(input_))
    
    if err != nil{
        fmt.print(input_ )
        luaL_luajit.error(L, " %s dir was not changed to ", input_ )
    }
    return 0

}

// copies all in directory from src_ to dest_
l_copy_directory :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    src_ := luaL_luajit.checkstring(L,-1)
    dest_ := luaL_luajit.checkstring(L,-2)

    err:= os.copy_directory_all(string(dest_),string(src_))
    
    if err != nil{
        
        luaL_luajit.error(L, " %s directory was not copied into ", src_, dest_)
    }
    
    return 0
}

// copies file from src_ to dest_
l_copy_file :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    src_ := luaL_luajit.checkstring(L,-1)
    dest_ := luaL_luajit.checkstring(L,-2)

    err:= os.copy_file(string(dest_),string(src_))
    
    if err != nil{
        
        luaL_luajit.error(L, " file was not copied")
    }
    
    return 0
}

l_file_size :: proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    file_ := luaL_luajit.checkstring(L,-1)
    fd, err := os.open(string(file_))
    defer os.close(fd)
    if err != nil{
        
        luaL_luajit.error(L, " could not read file")
        return 0
    }
    else{
        size_, err2 := os.file_size(fd)

        if err2 != nil{
        
            luaL_luajit.error(L, " could not get filesize")
            return 0
        }
        else {

            luajit.pushnumber(L,luajit.Number(size_))
            return 1
        }

        
    }
    

}

// file_info
// returns file info as table

l_file_info ::  proc "c" (L: luaL_luajit.State) -> i32{

    context = runtime.default_context()
    file_ := luaL_luajit.checkstring(L,-1)
    fd, err := os.open(string(file_))
    defer os.close(fd)
    if err != nil{
        
        luaL_luajit.error(L, " could not read file")
        return 0
    }
    else{

      alloc := runtime.default_allocator() 
        info_, err := os.fstat(fd, alloc)
        if err != nil{
        
        luaL_luajit.error(L, " could not read file")
        return 0
    }
    else{
            luajit.createtable(L,0,5)
            newstr: cstring = strings.clone_to_cstring(info_.name)
            luajit.pushstring(L,  newstr)
            luajit.setfield(L,-2,"name")
            luajit.pushinteger(L, luajit.Integer(info_.size))
            luajit.setfield(L,-2,"size")
            luajit.pushinteger(L, luajit.Integer(info_.access_time._nsec))
            luajit.setfield(L,-2,"access time")
            luajit.pushinteger(L, luajit.Integer(info_.creation_time._nsec))
            luajit.setfield(L,-2,"creation time")
            luajit.pushinteger(L, luajit.Integer(info_.modification_time._nsec))
            luajit.setfield(L,-2,"modification time")
        }
    }

    return 1
}

