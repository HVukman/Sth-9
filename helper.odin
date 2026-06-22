package sth9
import rl "vendor:raylib"
import luajit "luajit"
import luaL_luajit "luajit/luaL"
import "base:runtime"
import "core:fmt"
import "core:slice"
import "core:unicode"
import "core:strings"
import "core:math/rand"
import "core:math"
// internally for unicode
// Remove codepoint duplicates if requested
codepoints_remove_duplicates :: proc (codepoints: []rune) -> (deduplicated: []rune) {
	deduplicated = slice.clone(codepoints)
	slice.sort(deduplicated)
	return slice.unique(deduplicated)
}


l_round :: proc "c" (L: luaL_luajit.State) -> i32 {
  a := f64(luaL_luajit.checknumber(L,1))
  luajit.pushnumber(L,luajit.Number(math.round_f64(a)))
  return 1
}

// pareto distribution
// https://pkg.odin-lang.org/core/math/rand/#float32_pareto
l_pareto_dist :: proc "c" (L: luaL_luajit.State) -> i32 {
  context = runtime.default_context()
  alpha := f32(luaL_luajit.checknumber(L,1))
  beta := f32(luaL_luajit.checknumber(L,2))
  res := rand.float32_pareto(alpha,beta)
  luajit.pushnumber(L,luajit.Number(res))
  return 1
}

// normal distribution
// https://pkg.odin-lang.org/core/math/rand/#float32_normal
l_normal_dist :: proc "c" (L: luaL_luajit.State) -> i32 {
  context = runtime.default_context()
  mean := f64(luaL_luajit.checknumber(L,1))
  std := f64(luaL_luajit.checknumber(L,2))
  res := rand.float64_normal(mean,std)
  luajit.pushnumber(L,luajit.Number(res))
  return 1
}

// normal distribution
// https://pkg.odin-lang.org/core/math/rand/#float32_normal
l_gamma_dist :: proc "c" (L: luaL_luajit.State) -> i32 {
  context = runtime.default_context()
  alpha := f64(luaL_luajit.checknumber(L,1))
  beta := f64(luaL_luajit.checknumber(L,2))
  res := rand.float64_gamma(alpha,beta)
  luajit.pushnumber(L,luajit.Number(res))
  return 1
}

// checks if string is lowercase 
l_is_lower :: proc "c" (L: luaL_luajit.State) -> i32 {

  context = runtime.default_context()
  b_res : b32
  b_res = true
  cst_:= luaL_luajit.checkstring(L,1)
  str_:= string(cst_)

  for i in str_ {
            if unicode.is_upper(i){  
                b_res = false
                luajit.pushboolean(L,i32(b_res))
            }
  } 

  if !b_res{
      luajit.pushboolean(L,i32(b_res))
  }
  return 1
}

// checks if string is uppercase 
l_is_upper :: proc "c" (L: luaL_luajit.State) -> i32 {

  context = runtime.default_context()
  b_res : b32
  b_res = true
  cst_:= luaL_luajit.checkstring(L,1)
  str_:= string(cst_)

  for i in str_ {
            if unicode.is_lower(i){  
                b_res = false
                luajit.pushboolean(L,i32(b_res))
            }
  } 

  if !b_res{
      luajit.pushboolean(L,i32(b_res))
  }
  return 1
}

// make sign, clamp as helper
l_sign :: proc "c" (L: luaL_luajit.State) -> i32 {

  a := f64(luaL_luajit.checknumber(L,-1))

  if a<0 {
    luajit.pushnumber(L, -1)
  }else if a>0{
    luajit.pushnumber(L, 1)
  }else{
    luajit.pushnumber(L,0)
  }

  return 1
}
// ping pong number

l_ping_pong :: proc "c" (L: luaL_luajit.State) -> i32 {

  a := f64(luaL_luajit.checknumber(L,-1))

  if a!=0.0 {
    a = -1.0*a
    luajit.pushnumber(L, luajit.Number(a))
  }else
  {
    luajit.pushnumber(L, luajit.Number(a))
  }
  return 1
}

// clamp number
l_clamp :: proc "c" (L: luaL_luajit.State) -> i32 {

  a := f64(luaL_luajit.checknumber(L,1))
  min := f64(luaL_luajit.checknumber(L,2))
  max := f64(luaL_luajit.checknumber(L,3))

  if a<min {
      luajit.pushnumber(L, luajit.Number(min))
  }else if a>max{
      luajit.pushnumber(L, luajit.Number(max))
  }else{
      luajit.pushnumber(L, luajit.Number(a))
  }
  return 1
}

// looping over a table
l_loop_table:: proc "c" (L: luaL_luajit.State) -> i32 {

    // https://dav3.co/blog/looping-through-lua-table-in-c
    context = runtime.default_context()
    if (!luajit.istable(L, -1)) {
        fmt.println("Expected a table of vertices, got %s", luajit.type(L, -1) )
    return 1;
  }

  // Get the number of vertices we received.
  len := luajit.objlen(L, -1)

  // make array of length len
  vertices := make([]int, len) 
  actualIndex: int
  for index:= 0; index <= int(len); index+=1 {
    // Our actual index will be +1 because Lua 1 indexes tables.
    actualIndex = index + 1; 
    // Push our target index to the stack.
    luajit.pushinteger(L, luajit.Integer(actualIndex))
    // Get the table data at this index (and not get the table, which is what I thought this did.)
    luajit.gettable(L, -2); 
    // Check for the sentinel nil element.
    if (luajit.type(L, -1) == luajit.TTABLE){ break } 
    // Get it's value.
    vertices[index] = int(luaL_luajit.checknumber(L, -1))
    // Pop it off again.
    luajit.pop(L, 1);
  }
    return 1
}