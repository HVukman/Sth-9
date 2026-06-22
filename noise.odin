package sth9

import luajit "luajit"
import luaL_luajit "luajit/luaL"
import "base:runtime"
import "core:math/noise"

// https://pkg.odin-lang.org/core/math/noise/#noise_2d
// OpenSimplex2 noise algorithm.

/* 
2D Simplex noise, with Y pointing down the main diagonal. Might be better for a 2D sandbox style game, where Y is vertical. Probably slightly less optimal for heightmaps or continent maps, unless your map is centered around an equator. It's a subtle difference, but the option is here to make it an easy choice.
*/
l_noise2d_improve_x :: proc "c" (L: luaL_luajit.State) -> i32 {

     context = runtime.default_context()
     coord: [2]f64
     if luajit.istable(L,-2){

        luajit.getfield(L, 1, "x")  // Push table.x onto stack
        x := f64(luajit.tonumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
        
        luajit.getfield(L, 1, "y")
        y := f64(luajit.tonumber(L, -1))
        luajit.pop(L, 1)

        coord.xx = x
        coord.yy = y

     }

     seed:= i64(luaL_luajit.checknumber(L,-1))
     result_ := noise.noise_2d_improve_x(seed,coord)
     luajit.pushnumber(L,luajit.Number(result_))
     return 0
}

// 2D Simplex noise, standard lattice orientation.
l_noise2d :: proc "c" (L: luaL_luajit.State) -> i32 {

     context = runtime.default_context()
     coord: [2]f64
     if luajit.istable(L,-2){

        luajit.getfield(L, 1, "x")  // Push table.x onto stack
        x := f64(luajit.tonumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
        
        luajit.getfield(L, 1, "y")
        y := f64(luajit.tonumber(L, -1))
        luajit.pop(L, 1)

        coord.xx = x
        coord.yy = y

     }

     seed:= i64(luaL_luajit.checknumber(L,-1))
     result_ := noise.noise_2d(seed,coord)
     luajit.pushnumber(L,luajit.Number(result_))
     return 0
}