package sth9
import rl "vendor:raylib"
import luajit "luajit"
import luajit_luaL "luajit/luaL"


l_check_collision_recs :: proc "c" (L: luajit.State) -> i32{

    // check collision of rectangles
    if luajit.istable(L,-1) && luajit.istable(L,-2){

        luajit.getfield(L, 1, "x")  // Push table.x onto stack
        x := f32(luajit_luaL.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, 1, "y")
        y := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
        luajit.getfield(L, 1, "w")
        w := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
        luajit.getfield(L, 1, "h")
        h := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)

        luajit.getfield(L, 2, "x")  // Push table.x onto stack
        x2 := f32(luajit_luaL.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, 2, "y")
        y2 := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
        luajit.getfield(L, 2, "w")
        w2 := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
        luajit.getfield(L, 2, "h")
        h2 := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)

        rec := rl.Rectangle{x,y,w,h}
        rec2 := rl.Rectangle{x2,y2,w2,h2}

        bool_collision:= rl.CheckCollisionRecs(rec,rec2)

        
        luajit.pushboolean(L,i32(bool_collision))
        return 1
    }
    else{
        luajit_luaL.error(L, "no rectangles for collision check")
        return 0
    }
   
}

l_check_collision_circles :: proc "c" (L: luajit.State) -> i32{

     // check collision of rectangles
    if luajit.istable(L,-1) && luajit.istable(L,-2){

        luajit.getfield(L, 1, "x")  // Push table.x onto stack
        x := f32(luajit_luaL.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, 1, "y")
        y := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
        luajit.getfield(L, 1, "r")
        r := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)

        luajit.getfield(L, 2, "x")  // Push table.x onto stack
        x1 := f32(luajit_luaL.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, 2, "y")
        y1 := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
        luajit.getfield(L, 2, "r")
        r1 := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)

        circ1 := rl.Vector2{x,y}
        circ2 := rl.Vector2{x1,y1}

        collision_circles := rl.CheckCollisionCircles(circ1,r,circ2,r1)
        luajit.pushboolean(L,i32(collision_circles))
        return 1

    }else{

        luajit_luaL.error(L, "no circles for collision check")
        return 0
    }
}

// collision circle line
l_check_collision_circle_line :: proc "c" (L: luajit.State) -> i32{

     // check collision of rectangles
    if luajit.istable(L,-1) && luajit.istable(L,-2) && luajit.istable(L,-3){

        // get points one and two
        luajit.getfield(L, 3, "x")  // Push table.x onto stack
        x1 := f32(luajit_luaL.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, 3, "y")
        y1 := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)

        luajit.getfield(L, 2, "x")  // Push table.x onto stack
        x2 := f32(luajit_luaL.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, 2, "y")
        y2 := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)

        // get circle

        luajit.getfield(L, 1, "x")  // Push table.x onto stack
        xc := f32(luajit_luaL.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, 1, "y")
        yc := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
        luajit.getfield(L, 1, "r")
        rc := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)

        p1:= rl.Vector2{x1,y1}
        p2:= rl.Vector2{x2,y2}
        center:= rl.Vector2 { xc, yc}

        bool_collision := rl.CheckCollisionCircleLine(center, rc, p1,p2)
        luajit.pushboolean(L,i32(bool_collision))
        return 1

    }else{

        luajit_luaL.error(L, "no circle line for collision check")
        return 0
    }
}

// collision circle rectangle
l_check_collision_circle_rec :: proc "c" (L: luajit.State) -> i32{

     // check circle and rectangle
    // check_collision_circle_rec( circ, rec)
    if luajit.istable(L,-1) && luajit.istable(L,-2){

        // get rectangle
        luajit.getfield(L, 2, "x")  // Push table.x onto stack
        x := f32(luajit_luaL.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, 2, "y")
        y := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
        luajit.getfield(L, 2, "w")
        w := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
        luajit.getfield(L, 2, "h")
        h := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)

        rec := rl.Rectangle{x,y,w,h}

     
        // get circle

        luajit.getfield(L, 1, "x")  // Push table.x onto stack
        xc := f32(luajit_luaL.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, 1, "y")
        yc := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
        luajit.getfield(L, 1, "r")
        rc := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)


        center:= rl.Vector2 { xc, yc}

        bool_collision_circle_rec := rl.CheckCollisionCircleRec(center, rc, rec)
        luajit.pushboolean(L,i32(bool_collision_circle_rec))
        return 1

    }else{

        luajit_luaL.error(L, "no circle rectangle for collision check")
        return 0
    }
}

// coliision point rectangle 
l_check_collision_point_rec :: proc "c" (L: luajit.State) -> i32{

     // check point and rectangle
    // check_collision_point_rec( point , rec)
    if luajit.istable(L,-1) && luajit.istable(L,-2){

        // get rectangle
        luajit.getfield(L, 2, "x")  // Push table.x onto stack
        x := f32(luajit_luaL.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, 2, "y")
        y := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
        luajit.getfield(L, 2, "w")
        w := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
        luajit.getfield(L, 2, "h")
        h := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)

        rec := rl.Rectangle{x,y,w,h}

        // get point
        luajit.getfield(L, 1, "x")  // Push table.x onto stack
        xp := f32(luajit_luaL.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, 1, "y")
        yp := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)

        point := rl.Vector2{xp,yp}

        bool_col := rl.CheckCollisionPointRec(point,rec)

        luajit.pushboolean(L,i32(bool_col))
        return 1

    }else{

        luajit_luaL.error(L, "no point rectangle for collision check")
        return 0
    }
    
}

// coliision point circle 
l_check_collision_point_circle :: proc "c" (L: luajit.State) -> i32{

     // check circle and rectangle
    // check_collision_point_circle( point, circ)
   
    if luajit.istable(L,-1) && luajit.istable(L,-2){

        // get circle
        luajit.getfield(L, 2, "x")  // Push table.x onto stack
        x := f32(luajit_luaL.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, 2, "y")
        y := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
        luajit.getfield(L, 2, "r")
        r := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)
            
     
        center_circ:= rl.Vector2{x,y}
     

        // get point
        luajit.getfield(L, 1, "x")  // Push table.x onto stack
        xp := f32(luajit_luaL.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, 1, "y")
        yp := f32(luajit_luaL.checknumber(L, -1))
        luajit.pop(L, 1)

        point := rl.Vector2{xp,yp}

        bool_col := rl.CheckCollisionPointCircle(point,center_circ,r)

        luajit.pushboolean(L,i32(bool_col))
        return 1

    }else{

        luajit_luaL.error(L, "no point rectangle for collision check")
        return 0
    }
    
}