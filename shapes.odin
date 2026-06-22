package sth9

import luajit "luajit"
import luaL_luajit "luajit/luaL"
import "base:runtime"
import "core:fmt"
import rl "vendor:raylib"
import "core:c/libc"

get_color :: proc (i:int) -> rl.Color {
    new_col := COLOR_ARRAY
    if (0 <= i32(i) &&i32(i) < COLORS){
        return new_col[i]
    }else{
        return new_col[0]
    }
}

l_draw_ellipse :: proc "c"(L:luaL_luajit.State) -> i32 {

    // int centerX, int centerY, float radiusH, float radiusV, Color color)
     context = runtime.default_context()
    
    col_:= int(luajit.tointeger(L, -1))
    radiusV:= luajit.tonumber(L,-2)
    radiusH := luajit.tonumber(L,-3)

    if luajit.istable(L,-4){
            luajit.getfield(L, -4, "x")  // Push table.x onto stack
            x1 := i32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
            luajit.pop(L, 1)  
            
            luajit.getfield(L, -4, "y")
            y1 := i32(luaL_luajit.checknumber(L, -1))
            luajit.pop(L, 1)
            rl.DrawEllipse(x1,y1, f32(radiusH),f32(radiusV),get_color(col_) )
        }
        else{
            fmt.println("no table on stack?")
            luaL_luajit.error(L,"no table as first argument on stack")
        }

    return 0
}

l_draw_ellipse_lines :: proc "c"(L:luaL_luajit.State) -> i32 {

    // int centerX, int centerY, float radiusH, float radiusV, Color color)
     context = runtime.default_context()
   
    col_:= int(luajit.tointeger(L, -1))

    radiusV:= luajit.tonumber(L,-2)
    radiusH := luajit.tonumber(L,-3)

    if luajit.istable(L,-4){
            luajit.getfield(L, -4, "x")  // Push table.x onto stack
            x1 := i32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
            luajit.pop(L, 1)  
            
            luajit.getfield(L, -4, "y")
            y1 := i32(luaL_luajit.checknumber(L, -1))
            luajit.pop(L, 1)
            rl.DrawEllipseLines(x1,y1, f32(radiusH),f32(radiusV),get_color(col_) )
        }
        else{
            fmt.println("no table on stack?")
            luaL_luajit.error(L,"no table as first argument on stack")
        }

    return 0
}

l_draw_ring :: proc "c"(L:luaL_luajit.State) -> i32 {

    // draw ring function
    // (Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color)
     context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))

    segments:= luaL_luajit.checknumber(L,-2)
    endAngle:= luaL_luajit.checknumber(L,-3)
    startAngle:= luaL_luajit.checknumber(L,-4)
    outerRadius:= luaL_luajit.checknumber(L,-5)
    innerRadius:= luaL_luajit.checknumber(L,-6)

    if luajit.istable(L,-7){
            luajit.getfield(L, -7, "x")  // Push table.x onto stack
            x1 := f32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
            luajit.pop(L, 1)  
            
            luajit.getfield(L, -7, "y")
            y1 := f32(luaL_luajit.checknumber(L, -1))
            luajit.pop(L, 1)

           center:= rl.Vector2{x1,y1}
            
            rl.DrawRing(center,f32(innerRadius),f32(outerRadius),f32(startAngle),f32(endAngle),
            i32(segments),get_color(col_) )
        }
        else{
            fmt.println("no table on stack?")
            luaL_luajit.error(L,"no table as first argument on stack")
        }

    return 0
}

l_draw_ring_lines :: proc "c"(L:luaL_luajit.State) -> i32 {

    // draw ring function
    // (Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color)
    context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))

    segments:= luaL_luajit.checknumber(L,-2)
    endAngle:= luaL_luajit.checknumber(L,-3)
    startAngle:= luaL_luajit.checknumber(L,-4)
    outerRadius:= luaL_luajit.checknumber(L,-5)
    innerRadius:= luaL_luajit.checknumber(L,-6)

    if luajit.istable(L,-7){
            luajit.getfield(L, -7, "x")  // Push table.x onto stack
            x1 := f32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
            luajit.pop(L, 1)  
            
            luajit.getfield(L, -7, "y")
            y1 := f32(luaL_luajit.checknumber(L, -1))
            luajit.pop(L, 1)

           center:= rl.Vector2{x1,y1}
            
            rl.DrawRingLines(center,f32(innerRadius),f32(outerRadius),f32(startAngle),f32(endAngle),
            i32(segments),get_color(col_))
        }
        else{
            fmt.println("no table on stack?")
            luaL_luajit.error(L,"no table as first argument on stack")
        }

    return 0
}

// draw_text_pro(string, x, y, rotation, size, spacing, color)
l_draw_text_pro :: proc "c" (L:luaL_luajit.State) -> i32 {
 
      context = runtime.default_context()
      col_:= int(luajit.tointeger(L, -1))
      spacing := luaL_luajit.checknumber(L,-2)
      size:= luaL_luajit.checknumber(L, -3)   
      rotation := luaL_luajit.checknumber(L, -4)   
      arg_2 := luaL_luajit.checknumber(L, -5)
      arg_1 := luaL_luajit.checknumber(L, -6)
      text := luaL_luajit.checkstring(L, -7)
      position:= rl.Vector2{f32(arg_1),f32(arg_2)}
      origin := rl.Vector2{0,0}
      rl.DrawTextPro(font1,text,position,origin,
      f32(rotation),f32(size),f32(spacing),get_color(col_))
     
      return 0
}

// draw_text_ex(string, x,y,size, spacing, color)

l_draw_text_ex :: proc "c" (L:luaL_luajit.State) -> i32 {
 
      context = runtime.default_context()
      
      col_:= int(luajit.tointeger(L, -1))
      spacing := luaL_luajit.checknumber(L,-2)
      size:= luaL_luajit.checknumber(L, -3)   
      arg_2 := luaL_luajit.checknumber(L, -4)
      arg_1 := luaL_luajit.checknumber(L, -5)
     // textt := luaL_luajit.tostring(L,-4)
      text := luaL_luajit.checkstring(L, -6)
      position:= rl.Vector2{f32(arg_1),f32(arg_2)}
      rl.DrawTextEx(font1,text, position ,f32(size),f32(spacing),get_color(col_))
      return 0
}

// draw text on screen
// draw_text(string, x,y,size, color)
l_draw_text :: proc "c" (L:luaL_luajit.State) -> i32 {

      context = runtime.default_context()
      col_:= int(luajit.tointeger(L, -1))
      size:= luaL_luajit.checknumber(L, -2)   
      arg_2 := luaL_luajit.checknumber(L, -3)
      arg_1 := luaL_luajit.checknumber(L, -4)
      text := luaL_luajit.checkstring(L, -5)

     
      rl.DrawTextEx(font1, text, { f32(arg_1), f32(arg_2)}, f32(size), 1, get_color(col_))   

      return 0
    }

l_draw_pixel :: proc "c" (L:luaL_luajit.State) -> i32 {

      context = runtime.default_context()
      col_:= int(luajit.tointeger(L, -1))
      arg_2:= luaL_luajit.checknumber(L, -2)   
      arg_1 := luaL_luajit.checknumber(L, -3)
      rl.DrawPixel(i32(arg_1), i32(arg_2), get_color(col_))
      return 0
    }

l_draw_rectangle :: proc "c" (L:luaL_luajit.State) -> i32 {
    
    // call with draw_rectangle(rec,color)
    context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))

    if luajit.istable(L,-2){

        luajit.getfield(L, 1, "x")  // Push table.x onto stack
        x := i32(luajit.tonumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
        
        luajit.getfield(L, 1, "y")
        y := i32(luajit.tonumber(L, -1))
        luajit.pop(L, 1)
        
        luajit.getfield(L, 1, "w")
        w := i32(luajit.tonumber(L, -1))
        luajit.pop(L, 1)
        
        luajit.getfield(L, 1, "h")
        h := i32(luajit.tonumber(L, -1))
        luajit.pop(L, 1)
        rl.DrawRectangle(x,y,w,h,get_color(col_))

    }
    else{
        fmt.println("no table on stack?")
        luaL_luajit.error(L,"no table on stack for draw_rectangle")
    }
    return 0

}

// rectangle with rotation
l_draw_rectangle_pro :: proc "c" (L:luaL_luajit.State) -> i32 {
    
    // call with draw_rectangle_pro(rec,origin,rot,color)
    context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))

    // rotation
    rot:= luaL_luajit.checknumber(L,-2)

    // get point for origin
    if luajit.istable(L,-3){
            
            luajit.getfield(L, -3, "x")  // Push table.x onto stack
            p1 := luaL_luajit.checknumber(L,-1)
            luajit.pop(L, 1)

            luajit.getfield(L, -3, "y")  // Push table.y onto stack
            p2 := luaL_luajit.checknumber(L,-1)
            luajit.pop(L, 1)

        if luajit.istable(L,-4){

            luajit.getfield(L, -4, "x")  // Push table.x onto stack
            x := f32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
            luajit.pop(L, 1)  
            
            luajit.getfield(L, -4, "y")
            y := f32(luaL_luajit.checknumber(L, -1))
            luajit.pop(L, 1)
            
            luajit.getfield(L, -4, "w")
            w := f32(luaL_luajit.checknumber(L, -1))
            luajit.pop(L, 1)
            
            luajit.getfield(L, -4, "h")
            h := f32(luaL_luajit.checknumber(L, -1))
            luajit.pop(L, 1)

            origin := rl.Vector2{f32(p1),f32(p2)}
            rec := rl.Rectangle{x,y,w,h}

            rl.DrawRectanglePro(rec,origin,f32(rot),get_color(col_))

        }
    }
    else{
        fmt.println("no table on stack for draw_rectangle_pro")
        luaL_luajit.error(L,"no table on stack for draw_rectangle_pro")
    }
    return 0

}

// draw full color triangle

l_draw_triangle :: proc "c" (L:luaL_luajit.State) -> i32 {

    // draw_triangle (point1 , point2, point3 , color )
    context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))

    // get point 1,2,3 
    if luajit.istable(L,-2) && luajit.istable(L,-3) && luajit.istable(L,-4){

        luajit.getfield(L, -2, "x")  // Push table.x onto stack
        x1 := f32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, -2, "y")
        y1 := f32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)

        luajit.getfield(L, -3, "x")  
        x2 := f32(luaL_luajit.checknumber(L, -1)) 
        luajit.pop(L, 1)  
            
        luajit.getfield(L, -3, "y")
        y2 := f32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)

        luajit.getfield(L, -4, "x")  
        x3 := f32(luaL_luajit.checknumber(L, -1))  
        luajit.pop(L, 1)  
            
        luajit.getfield(L, -4, "y")
        y3 := f32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)

        p1:= rl.Vector2{x1,y1}
        p2:= rl.Vector2{x2,y2}
        p3:= rl.Vector2{x3,y3}

        rl.DrawTriangle(p1,p2,p3,get_color(col_))
    }
    return 0

}

// draw color triangle

l_draw_triangle_lines :: proc "c" (L:luaL_luajit.State) -> i32 {

    // draw_triangle_lines (point1 , point2, point3 , color )
    context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))

    // get point 1,2,3 
    if luajit.istable(L,-2) && luajit.istable(L,-3) && luajit.istable(L,-4){

        luajit.getfield(L, -2, "x")  // Push table.x onto stack
        x1 := f32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
            
        luajit.getfield(L, -2, "y")
        y1 := f32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)

        luajit.getfield(L, -3, "x")  
        x2 := f32(luaL_luajit.checknumber(L, -1)) 
        luajit.pop(L, 1)  
            
        luajit.getfield(L, -3, "y")
        y2 := f32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)

        luajit.getfield(L, -4, "x")  
        x3 := f32(luaL_luajit.checknumber(L, -1))  
        luajit.pop(L, 1)  
            
        luajit.getfield(L, -4, "y")
        y3 := f32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)

        p1:= rl.Vector2{x1,y1}
        p2:= rl.Vector2{x2,y2}
        p3:= rl.Vector2{x3,y3}

        rl.DrawTriangleLines(p1,p2,p3,get_color(col_))
    }
    return 0

}

// Draw full color circle
l_draw_circle :: proc "c" (L:luaL_luajit.State) -> i32 {
    
    // call with draw_circle(circle,color)
    context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))
    if luajit.istable(L,-2){

        luajit.getfield(L, 1, "x")  // Push table.x onto stack
        x := i32(luajit.tonumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
        
        luajit.getfield(L, 1, "y")
        y := i32(luajit.tonumber(L, -1))
        luajit.pop(L, 1)
        
        luajit.getfield(L, 1, "r")
        r := f32(luajit.tonumber(L, -1))
        luajit.pop(L, 1)
     
        rl.DrawCircle(x,y,r,get_color(col_))

    }
    else{
        fmt.println("no table on stack for draw_circle")
        luaL_luajit.error(L,"no table on stack for draw_circle")
    }
    return 0

}

// Draw circle outline
l_draw_circle_line :: proc "c" (L:luaL_luajit.State) -> i32 {
    
    // call with draw_circle_line(circle,color)
    context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))

    if luajit.istable(L,-2){

        luajit.getfield(L, 1, "x")  // Push table.x onto stack
        x := i32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
        
        luajit.getfield(L, 1, "y")
        y := i32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)
        
        luajit.getfield(L, 1, "r")
        r := f32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)
     
        rl.DrawCircleLines(x,y,r,get_color(col_))

    }
    else{
        fmt.println("no table on stack for draw_circle_line")
        luaL_luajit.error(L,"no table on stack for draw_circle_line")
    }
    return 0

}

l_draw_rectangle_lines :: proc "c" (L:luaL_luajit.State) -> i32 {
    
    // call with draw_rectangle_lines(rec,color)
    context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))

    line_thick:= luaL_luajit.checknumber(L,-2)

    if luajit.istable(L,-3){

        luajit.getfield(L, 1, "x")  // Push table.x onto stack
        x := i32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
        
        luajit.getfield(L, 1, "y")
        y := i32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)
        
        luajit.getfield(L, 1, "w")
        w := i32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)
        
        luajit.getfield(L, 1, "h")
        h := i32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)

        rect_rl := rl.Rectangle{f32(x),f32(y),f32(w),f32(h)}

        rl.DrawRectangleLinesEx(rect_rl,f32(line_thick),get_color(col_))

    }
    else{
        luaL_luajit.error(L,"no table on stack (draw_rectangle_lines)")
    }
    return 0

}

// draw line
l_draw_line :: proc "c" (L:luaL_luajit.State) -> i32 {
    
    // call with draw_rectangle(rec,color)
    context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))

    if luajit.istable(L,-2){

        luajit.getfield(L, -2, "x")  // Push table.x onto stack
        x2 := i32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
        
        luajit.getfield(L, -2, "y")
        y2 := i32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)
        
        if luajit.istable(L,-3){
            luajit.getfield(L, -3, "x")  // Push table.x onto stack
            x1 := i32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
            luajit.pop(L, 1)  
            
            luajit.getfield(L, -3, "y")
            y1 := i32(luaL_luajit.checknumber(L, -1))
            luajit.pop(L, 1)

            rl.DrawLine(x1,y1,x2,y2,get_color(col_))
        }
        else{
            fmt.println("no table on stack?")
            luaL_luajit.error(L,"no table as first argument on stack")
    }
        

    }
    else{

        luaL_luajit.error(L,"no table on stack (draw_line)")
    }
    return 0

}

// draw line with thickness
l_draw_line_thick :: proc "c" (L:luaL_luajit.State) -> i32 {
    
    // call with draw_rectangle(rec,color)
    context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))

    thick:= luaL_luajit.checknumber(L,-2)

    if luajit.istable(L,-3){

        luajit.getfield(L, -3, "x")  // Push table.x onto stack
        x2 := i32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
        
        luajit.getfield(L, -3, "y")
        y2 := i32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)
        
        if luajit.istable(L,-4){
            luajit.getfield(L, -4, "x")  // Push table.x onto stack
            x1 := i32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
            luajit.pop(L, 1)  
            
            luajit.getfield(L, -4, "y")
            y1 := i32(luaL_luajit.checknumber(L, -1))
            luajit.pop(L, 1)

            pos1 := rl.Vector2{f32(x1),f32(y2)}
            pos2 := rl.Vector2{f32(x2),f32(y2)}
            rl.DrawLineEx(pos1,pos2,f32(thick),get_color(col_) )
        }
        else{
            luaL_luajit.error(L,"no table as first argument on stack")
        }
        

    }
    else{
        luaL_luajit.error(L,"no table on stack for draw_line_thick")
    }
    return 0

}

// draw line bezier
l_draw_line_bezier :: proc "c" (L:luaL_luajit.State) -> i32 {
    
    // call with draw_rectangle(rec,color)
    context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))
    thick := f32(luaL_luajit.checknumber(L,-2))
    if luajit.istable(L,-3){

        luajit.getfield(L, -3, "x")  // Push table.x onto stack
        x2 := f32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
        luajit.pop(L, 1)  
        
        luajit.getfield(L, -3, "y")
        y2 := f32(luaL_luajit.checknumber(L, -1))
        luajit.pop(L, 1)
        
        if luajit.istable(L,-4){
            luajit.getfield(L, -4, "x")  // Push table.x onto stack
            x1 := f32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
            luajit.pop(L, 1)  
            
            luajit.getfield(L, -4, "y")
            y1 := f32(luaL_luajit.checknumber(L, -1))
            luajit.pop(L, 1)

            p1 := rl.Vector2{x1,y1}
            p2 := rl.Vector2{x2,y2}
            rl.DrawLineBezier(p1,p2,thick,get_color(col_))
        }
        else{
            fmt.println("no table on stack?")
            luaL_luajit.error(L,"no table as first argument on stack")
    }
        

    }
    else{

        luaL_luajit.error(L," (draw_line_bezier)")
    }
    return 0

}

// draw polygon

l_draw_polygon :: proc "c"(L:luaL_luajit.State) -> i32 {

    // DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color)
    // call with draw_rectangle(rec,color)
    context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))

    rot := luajit.tonumber(L,-2)
    radius := luajit.tonumber(L, -3)
    sides := luajit.tonumber(L,-4)

     if luajit.istable(L,-5){
            luajit.getfield(L, -5, "x")  // Push table.x onto stack
            x1 := i32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
            luajit.pop(L, 1)  
            
            luajit.getfield(L, -5, "y")
            y1 := i32(luaL_luajit.checknumber(L, -1))
            luajit.pop(L, 1)

            pos1 := rl.Vector2{f32(x1),f32(y1)}
            
            rl.DrawPoly(pos1,i32(sides),f32(radius),f32(rot),get_color(col_) )
        }
        else{
         
            luaL_luajit.error(L,"no table as first argument on stack (draw polygon)")
        }


    return 0
}

// draw polygon lines

l_draw_polygon_lines :: proc "c"(L:luaL_luajit.State) -> i32 {

    // DrawPolyLines(Vector2 center, int sides, float radius, float rotation, float thickness, Color color)

    context = runtime.default_context()
    col_:= int(luajit.tointeger(L, -1))

    thick:= luajit.tonumber(L,-2)
    rot := luajit.tonumber(L,-3)
    radius := luajit.tonumber(L, -4)
    sides := luajit.tonumber(L,-5)

     if luajit.istable(L,-6){
            luajit.getfield(L, -6, "x")  // Push table.x onto stack
            x1 := i32(luaL_luajit.checknumber(L, -1))  // Get the value from top of stack
            luajit.pop(L, 1)  
            
            luajit.getfield(L, -6, "y")
            y1 := i32(luaL_luajit.checknumber(L, -1))
            luajit.pop(L, 1)

            pos1 := rl.Vector2{f32(x1),f32(y1)}
            
            rl.DrawPolyLinesEx(pos1,i32(sides),f32(radius),f32(rot),f32(thick),get_color(col_))
        }
        else{
       
            luaL_luajit.error(L,"no table as first argument on stack")
        }


    return 0
}

// function to make rectangle
l_make_rectangle :: proc "c"(L:luaL_luajit.State) -> i32 {
    
    // Check  4 arguments
    if luajit.gettop(L) != 4 {
        luaL_luajit.error(L, "make_rectangle expects 4 arguments: x, y, w, h")
        return 0
    }
    
    // Get the four arguments 
    x := luaL_luajit.checknumber(L, 1)
    y := luaL_luajit.checknumber(L, 2)
    w := luaL_luajit.checknumber(L, 3)
    h := luaL_luajit.checknumber(L, 4)
    
    // Create a new table
    luajit.createtable(L, 0, 4)  // 0 array elements, 4 hash elements
    
    // Set the fields in the table
    luajit.pushinteger(L, luajit.Integer(x))
    luajit.setfield(L, -2, "x")
    
    luajit.pushinteger(L, luajit.Integer(y))
    luajit.setfield(L, -2, "y")
    
    luajit.pushinteger(L, luajit.Integer(w))
    luajit.setfield(L, -2, "w")
    
    luajit.pushinteger(L, luajit.Integer(h))
    luajit.setfield(L, -2, "h")
  
    return 1

    }
// function to make a circle
l_make_circle :: proc "c"(L:luaL_luajit.State) -> i32 {
    
    // Check 3 arguments
    if luajit.gettop(L) != 3 {
        luaL_luajit.error(L, "make_circle expects 3 arguments: x, y,r")
        return 0
    }
    
    // Get the four arguments 
    x := luaL_luajit.checknumber(L, 1)
    y := luaL_luajit.checknumber(L, 2)
    r := luaL_luajit.checknumber(L, 3)
   
    
    // Create a new table
    luajit.createtable(L, 0, 3)  // 0 array elements, 3 hash elements
    
    // Set the fields in the table
    luajit.pushinteger(L, luajit.Integer(x))
    luajit.setfield(L, -2, "x")
    
    luajit.pushinteger(L, luajit.Integer(y))
    luajit.setfield(L, -2, "y")
    
    luajit.pushnumber(L, r)
    luajit.setfield(L, -2, "r")
  
  
    return 1

    }
// function to make a point
l_make_point :: proc "c"(L:luaL_luajit.State) -> i32 {

     // Check  4 arguments
    if luajit.gettop(L) != 2 {
        luaL_luajit.error(L, "make_point expects 2 arguments: x, y")
        return 0
    }

    x := luaL_luajit.checknumber(L, 1)
    y := luaL_luajit.checknumber(L, 2)

    // Create a new table
    luajit.createtable(L, 0, 2)  // 0 array elements, 2 hash elements
    // Set the fields in the table
    luajit.pushinteger(L, luajit.Integer(x))
    luajit.setfield(L, -2, "x")
    
    luajit.pushinteger(L, luajit.Integer(y))
    luajit.setfield(L, -2, "y")
    
    return 1
}

// draw linear spline minimum 2 points
l_draw_linear_spline :: proc "c"(L:luaL_luajit.State) -> i32 {

    // const Vector2 *points, int pointCount, float thick, Color color
    col_:= int(luajit.tointeger(L, -1))
    thick:= f32(luajit.tonumber(L,-2))
    point_count := i32(luajit.tonumber(L,-3))
	
	
    if luajit.istable(L,-4)
    {
        context = runtime.default_context()
       
        len := luajit.objlen(L, -4)
    
        // make array of length len
        points : [dynamic]rl.Vector2 
		reserve(&points, int(len))
		defer delete(points)
        actualIndex: int
		
        if len>1 {
			
             for index:= 0; index < int(len); index+=1 {
            // Our actual index will be +1 because Lua 1 indexes tables.
            actualIndex = index + 1; 
            // Push our target index to the stack.
            luajit.pushinteger(L, luajit.Integer(actualIndex))
            // Get the table data at this index (and not get the table, which is what I thought this did.)
            luajit.gettable(L, -5); 
            // Check for the sentinel nil element.
            if (luajit.type(L, -1) == luajit.TNIL){ break } 
            // Get the x and y value
			new_vec : rl.Vector2
			luajit.getfield(L, -1, "x")
			x := f32(luajit.tonumber(L, -1))  
			new_vec.x = x
			luajit.pop(L, 1)

			luajit.getfield(L, -1, "y")
			y := f32(luajit.tonumber(L, -1))  
			new_vec.y = y
			luajit.pop(L, 1)
            
    
            append_elem(&points,new_vec)
            // Pop it off again.
            luajit.pop(L, 1);
        }
        }else{
            err_msg = "Minimum two points for linear spline"
        }
       
        dummy := raw_data(points)
        rl.DrawSplineLinear(dummy,point_count,thick,get_color(col_))
		

    }else{
        err_msg = " for draw_linear_spline"
        return 0
     }
    return 0
}


// draw b spline minimum 4 points
l_draw_b_spline :: proc "c"(L:luaL_luajit.State) -> i32 {

     // const Vector2 *points, int pointCount, float thick, Color color
    col_:= int(luajit.tointeger(L, -1))
    thick:= f32(luajit.tonumber(L,-2))
    point_count := i32(luajit.tonumber(L,-3))
	
	
    if luajit.istable(L,-4)
    {
        context = runtime.default_context()
       
        len := luajit.objlen(L, -4)
    
        // make array of length len
        points : [dynamic]rl.Vector2 
		reserve(&points, int(len))
		defer delete(points)
        actualIndex: int
		
        // minimum 4 points
        if len>1 {
			
             for index:= 0; index < int(len); index+=1 {
            // Our actual index will be +1 because Lua 1 indexes tables.
            actualIndex = index + 1; 
            // Push our target index to the stack.
            luajit.pushinteger(L, luajit.Integer(actualIndex))
            // Get the table data at this index (and not get the table, which is what I thought this did.)
            luajit.gettable(L, -5); 
            // Check for the sentinel nil element.
            if (luajit.type(L, -1) == luajit.TNIL){ break } 
            // Get the x and y value
			new_vec : rl.Vector2
			luajit.getfield(L, -1, "x")
			x := f32(luajit.tonumber(L, -1))  
			new_vec.x = x
			luajit.pop(L, 1)

			luajit.getfield(L, -1, "y")
			y := f32(luajit.tonumber(L, -1))  
			new_vec.y = y
			luajit.pop(L, 1)
            
    
            append_elem(&points,new_vec)
            // Pop it off again.
            luajit.pop(L, 1);
        }
        }else{
            err_msg = "Minimum two points for linear spline"
        }
       
        dummy := raw_data(points)
        rl.DrawSplineBasis(dummy,point_count,thick,get_color(col_))
		

    }else{
        err_msg = " for draw_linear_spline"
        return 0
     }
    return 0
}

// draw catmull rom spline minimum 4 points
l_draw_catrmull_rom_spline :: proc "c"(L:luaL_luajit.State) -> i32 {

    // const Vector2 *points, int pointCount, float thick, Color color
    col_:= int(luajit.tointeger(L, -1))
    thick:= f32(luajit.tonumber(L,-2))
    point_count := i32(luajit.tonumber(L,-3))
	
	
    if luajit.istable(L,-4)
    {
        context = runtime.default_context()
       
        len := luajit.objlen(L, -4)
    
        // make array of length len
        points : [dynamic]rl.Vector2 
		reserve(&points, int(len))
		defer delete(points)
        actualIndex: int
		
        // minimum 4 points for catmull too
        if len>1 {
			
             for index:= 0; index < int(len); index+=1 {
            // Our actual index will be +1 because Lua 1 indexes tables.
            actualIndex = index + 1; 
            // Push our target index to the stack.
            luajit.pushinteger(L, luajit.Integer(actualIndex))
            // Get the table data at this index (and not get the table, which is what I thought this did.)
            luajit.gettable(L, -5); 
            // Check for the sentinel nil element.
            if (luajit.type(L, -1) == luajit.TNIL){ break } 
            // Get the x and y value
			new_vec : rl.Vector2
			luajit.getfield(L, -1, "x")
			x := f32(luajit.tonumber(L, -1))  
			new_vec.x = x
			luajit.pop(L, 1)

			luajit.getfield(L, -1, "y")
			y := f32(luajit.tonumber(L, -1))  
			new_vec.y = y
			luajit.pop(L, 1)
            
    
            append_elem(&points,new_vec)
            // Pop it off again.
            luajit.pop(L, 1);
        }
        }else{
            err_msg = "Minimum two points for linear spline"
        }
       
        dummy := raw_data(points)
        rl.DrawSplineCatmullRom(dummy,point_count,thick,get_color(col_))
		

    }else{
        err_msg = " for draw_linear_spline"
        return 0
     }
    return 0
}


// GetSplinePointLinear(Vector2 startPos, Vector2 endPos, float t);
// get point on spline
l_get_spline_point_linear :: proc "c"(L:luaL_luajit.State) -> i32 {

    context = runtime.default_context()
    t := f32(luajit.tonumber(L,-1))
   

    if luajit.istable(L,-2) && luajit.istable(L,-3)
    {
            startPos : rl.Vector2 
            luajit.getfield(L, -3, "x")
			x := f32(luajit.tonumber(L, -1)) 
			startPos.x = x
			luajit.pop(L, 1)

			luajit.getfield(L, -3, "y")
			y := f32(luajit.tonumber(L, -1))  
			startPos.y = y
			luajit.pop(L, 1)

            // end pos
            luajit.getfield(L, -2, "x")
			x2 := f32(luajit.tonumber(L, -1)) 
            endpos : rl.Vector2 
			endpos.x = x2
			luajit.pop(L, 1)

			luajit.getfield(L, -2, "y")
			y2 := f32(luajit.tonumber(L, -1))  
			endpos.y = y2
			luajit.pop(L, 1)

            // return result as table
            point_:=rl.GetSplinePointLinear(startPos,endpos,t)
          
            luajit.createtable(L,0,2)

            luajit.pushnumber(L, luajit.Number(point_.x))
            luajit.setfield(L, -2, "x")
            
            luajit.pushnumber(L, luajit.Number(point_.y))
            luajit.setfield(L, -2, "y")
            
            return 1


    }else{
        err_msg = "no table on stack for point on linear spline"
        return 0
    }
    return 0

}

// GetSplinePointBasis
l_get_spline_point_basis :: proc "c"(L:luaL_luajit.State) -> i32 {

    context = runtime.default_context()
    t := f32(luajit.tonumber(L,-1))
   
    // needs four points
    if luajit.istable(L,-2) && luajit.istable(L,-3) && luajit.istable(L,-4) && luajit.istable(L,-5)
    {
            // pos 1
            luajit.getfield(L, -5, "x")
			x1 := f32(luajit.tonumber(L, -1)) 
            pos1 : rl.Vector2 
			pos1.x = x1
			luajit.pop(L, 1)

			luajit.getfield(L, -5, "y")
			y1 := f32(luajit.tonumber(L, -1))  
			pos1.y = y1
			luajit.pop(L, 1)

            // pos 2
            luajit.getfield(L, -4, "x")
			x2 := f32(luajit.tonumber(L, -1)) 
            pos2 : rl.Vector2 
			pos2.x = x2
			luajit.pop(L, 1)

			luajit.getfield(L, -4, "y")
			y2 := f32(luajit.tonumber(L, -1))  
			pos2.y = y2
			luajit.pop(L, 1)

            // pos 3
            luajit.getfield(L, -3, "x")
			x3 := f32(luajit.tonumber(L, -1)) 
            pos3 : rl.Vector2 
			pos3.x = x3
			luajit.pop(L, 1)

			luajit.getfield(L, -3, "y")
			y3 := f32(luajit.tonumber(L, -1))  
			pos3.y = y3
			luajit.pop(L, 1)

            // pos 4
            luajit.getfield(L, -2, "x")
			x4 := f32(luajit.tonumber(L, -1)) 
            pos4 : rl.Vector2 
			pos4.x = x4
			luajit.pop(L, 1)

			luajit.getfield(L, -2, "y")
			y4 := f32(luajit.tonumber(L, -1))  
			pos4.y = y4
			luajit.pop(L, 1)

            // return result as table
            point_:=rl.GetSplinePointBasis(pos1,pos2,pos3,pos4,t)
          
            luajit.createtable(L,0,2)

            luajit.pushnumber(L, luajit.Number(point_.x))
            luajit.setfield(L, -2, "x")
            
            luajit.pushnumber(L, luajit.Number(point_.y))
            luajit.setfield(L, -2, "y")
            
            return 1


    }else{
        err_msg = "no table on stack for point on linear spline"
        return 0
    }
    return 0

}


// GetSplinePointBasis
l_get_spline_point_catmull :: proc "c"(L:luaL_luajit.State) -> i32 {

    context = runtime.default_context()
    t := f32(luajit.tonumber(L,-1))
   
    // needs four points
    if luajit.istable(L,-2) && luajit.istable(L,-3) && luajit.istable(L,-4) && luajit.istable(L,-5)
    {
            // pos 1
            luajit.getfield(L, -5, "x")
			x1 := f32(luajit.tonumber(L, -1)) 
            pos1 : rl.Vector2 
			pos1.x = x1
			luajit.pop(L, 1)

			luajit.getfield(L, -5, "y")
			y1 := f32(luajit.tonumber(L, -1))  
			pos1.y = y1
			luajit.pop(L, 1)

            // pos 2
            luajit.getfield(L, -4, "x")
			x2 := f32(luajit.tonumber(L, -1)) 
            pos2 : rl.Vector2 
			pos2.x = x2
			luajit.pop(L, 1)

			luajit.getfield(L, -4, "y")
			y2 := f32(luajit.tonumber(L, -1))  
			pos2.y = y2
			luajit.pop(L, 1)

            // pos 3
            luajit.getfield(L, -3, "x")
			x3 := f32(luajit.tonumber(L, -1)) 
            pos3 : rl.Vector2 
			pos3.x = x3
			luajit.pop(L, 1)

			luajit.getfield(L, -3, "y")
			y3 := f32(luajit.tonumber(L, -1))  
			pos3.y = y3
			luajit.pop(L, 1)

            // pos 4
            luajit.getfield(L, -2, "x")
			x4 := f32(luajit.tonumber(L, -1)) 
            pos4 : rl.Vector2 
			pos4.x = x4
			luajit.pop(L, 1)

			luajit.getfield(L, -2, "y")
			y4 := f32(luajit.tonumber(L, -1))  
			pos4.y = y4
			luajit.pop(L, 1)

            // return result as table
            point_:=rl.GetSplinePointCatmullRom(pos1,pos2,pos3,pos4,t)
          
            luajit.createtable(L,0,2)

            luajit.pushnumber(L, luajit.Number(point_.x))
            luajit.setfield(L, -2, "x")
            
            luajit.pushnumber(L, luajit.Number(point_.y))
            luajit.setfield(L, -2, "y")
            
            return 1


    }else{
        err_msg = "no table on stack for point on linear spline"
        return 0
    }
    return 0

}