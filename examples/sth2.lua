
-- a random collection of things
function init()

    mouse_notallowed()
    x = "goodbye world"
    write_file ("dummy", x)

    -- if file exists 
    print(file_exist("dummy"))

    if (file_exist("dummy")) then
        print(file_size("dummy"))
    end

    title= "Random Stuff (move arrow keys and click around)"
    posx = 300
    posy = 200

    circ1_y = 100
    circ3_y = 200
    rect =  make_rectangle(10,100,200,150)
    rect2 = make_rectangle(35,200,200,150)
    rect3 = make_rectangle(posx-5,200,40,20)

    p1 = make_point(12,13)
    p2 = make_point(50,113)
    p3 = make_point(55,13)
    p4 = make_point(90,113)

    origin = make_point(30,99)
    rot = 78.3

    thick= 3.3
    circ = make_circle(300,circ1_y,19)
    circ2 = make_circle(300,400,28)

    -- for collision circle line and rectangle
    circ3 = make_circle(600,circ3_y,35)
    rect_dummy = make_rectangle(600,300,10,20)

    p11 = make_point(210,10)
    p22 = make_point(320,140)
    p33 = make_point(160,190)

    p331 = make_point(218,9)
    p332 = make_point(320,140)
    p333 = make_point(160,190)

    p1new = make_point(550,290)
    p1new2 = make_point(650,290)

    collision_recs = false
    collision_msg = "Collision Rectangles!"

    collision_circs = false
    collision_msg2 = "Collision Circles!"

    collision_circle_line = false
    collision_msg3 = "Collision circle line"

    collision_circle_rect = false
    collision_msg4 = "Collision circle rectangle"

    -- for easing
    frame_counter = 0
    ease_circ_y = 100
    time = 240
    easecirc = make_circle(700,ease_circ_y,20)

    -- mouse

    mousex = get_mouse_x()
    mousey = get_mouse_y()
    wheel_movement = get_wheel_movement()

    mouse_left_down = false
    mouse_down_message = "pressed left mouse"
    mouse_collision_message = "pressed mouse in rectangle"

    mouse_in_rect = false

    -- polygon
    poly_center = make_point(600,400)

    -- ellipse
    p1ellipse = make_point(450,90)

    -- time in console
    print(weekday(time_now()))
    -- puts program to sleep 
    -- sleep(2)

   
end

-- update
function update()
    
    local step  = 1
   
    if key_down(key.RIGHT) then
        posx = posx + step
        rect3.x = rect3.x + step 
    end
    if key_down(key.LEFT) then
        posx = posx - step
        rect3.x = rect3.x - step 
    end

    if key_down(key.UP) then
        circ1_y = circ1_y - step*3
        circ.y = circ1_y
    end
    if key_down(key.DOWN) then
        circ1_y = circ1_y + step*3
        circ.y = circ1_y 
    end

    if key_pressed(key.ESCAPE) then
        close_window()
    end

    circ3.y = circ3.y + step

    if circ3.y > 400 then
        circ3.y = 100
    end
    collision_recs = check_collision_recs(rect2,rect3)
    collision_circs = check_collision_circles(circ,circ2)
    collision_circle_line= check_collision_circle_line(circ3,p1new,p1new2)
    collision_circle_rect= check_collision_circle_rec(circ3,rect_dummy)

    if mouse_pressed(key.MOUSE_LEFT) then
        mouse_left_down = true
    else
        mouse_left_down = false
    end

    if mouse_left_down then
         localmousex = get_mouse_x()
         localmousey = get_mouse_y()
         local mousepoint = make_point(localmousex,localmousey)
         if check_collision_point_rec ( mousepoint, rect) then
             mouse_in_rect = true
         else 
             mouse_in_rect = false
         end
    end

    -- easing
    frame_counter = frame_counter + 1

    if frame_counter >= time then
         frame_counter = 0
    end
    
    easecirc.y = ease_elastic_in(frame_counter,10,200,time)

    if  frame_counter >= time then
         frame_counter = 0
         
    end 

    -- mouse

    mousex = get_mouse_x()
    mousey = get_mouse_y()
    wheel_movement = get_wheel_movement()

    if key_pressed(key.H) then
        if cursor_hidden() then
            show_cursor()
        else
            hide_cursor()
        end
    end


end

-- draw

function draw()

    clear_background(color.BLACK)
   

    draw_text(x,300,100,20,color.GREEN)


    draw_pixel(posx,300,color.RED)
    draw_line(p1,p2,color.WHITE)
   

    draw_line_thick(p3,p4,thick,color.MAGENTA)
    draw_rectangle_lines(rect,1.2,color.SKYBLUE)

    draw_circle(circ,color.GOLD)
    draw_circle_line(circ2,color.VIOLET)

    -- for collision circle line
    draw_circle(circ3,color.SKYBLUE)
    draw_line(p1new,p1new2,color.WHITE)

    draw_rectangle_pro(rect2,origin,rot,color.MAGENTA)
    draw_triangle(p331,p22,p33, color.GOLD)
    draw_triangle_lines(p11,p22,p33, color.GREEN)
   
    draw_text(tostring(screenwidth),posx,posy,20,color.GREEN)
    draw_rectangle_lines(rect3,1.3,color.GREEN)

    draw_rectangle(rect_dummy,color.WHITE)

    -- if collision than write message
    if collision_recs then
        draw_text(collision_msg,400,400,20,color.RED)
    end
    if collision_circs then
        draw_text(collision_msg2,400,350,20,color.RED)
    end
    if collision_circle_line then
        draw_text(collision_msg3,400,375,15,color.YELLOW)
    end
    if collision_circle_rect then
        draw_text(collision_msg4,400,365,15,color.YELLOW)
    end
    
      -- for ease circle line
    draw_circle(easecirc,color.WHITE)


    -- mouse

    -- if on screen
    if is_cursor_on_screen() then
            draw_text("mouse x " .. tostring(mousex),670,100,15,color.YELLOW)
            draw_text("mouse y " ..tostring(mousey),670,130,15,color.YELLOW)
            draw_text("mouse wheel x " ..tostring(wheel_movement.x),670,145,15,color.YELLOW)
            draw_text("mouse wheel y " ..tostring(wheel_movement.y),670,160,15,color.YELLOW)
    end
    
    
    if mouse_left_down then
        draw_text(mouse_down_message, 670, 80 , 15, color.YELLOW)
    end
    if mouse_in_rect then
        draw_text(mouse_collision_message, 600, 40 , 15, color.YELLOW)
    end
    -- polygon

    draw_polygon(poly_center,7,30.0,12.0,color.WHITE)
    draw_polygon_lines(poly_center,9,50.0,90.0,3.0,color.RED)

    -- ellipse
    draw_ellipse(p1ellipse,89.0,15,color.BLUE)
    draw_ellipse_lines(p1ellipse,120.0,20,color.WHITE)
    draw_ring(p1ellipse,100.0,105,18,98.0,28,color.WHITE)
    draw_ring_lines(p1ellipse,100.0,105,130,190.0,28,color.WHITE)
end

