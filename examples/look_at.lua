-- rectangle looks at mouse cursor
function init()
    title = "look at"
    mouse_x = 0.0
    mouse_y = 0.0
    target_x = 0.0
    target_y = 0.0
    rect = make_rectangle(screenwidth/2,screenheight/2,60,150)
    rot=0.0
    origin = make_point(30, 75)
    p1 = make_circle(rect.x,rect.y + rect.h/2,12)
end

function update()
    mouse_x = get_mouse_x()
    mouse_y = get_mouse_y() 
   
    local cx = rect.x + origin.x
    local cy = rect.y + origin.y

    local dx = mouse_x - cx
    local dy = mouse_y - cy

    rot = math.deg(math.atan2(dy, dx)) + 90

    p1.x = rect.x +  rect.h/2*(math.cos(math.atan2(dy, dx)))
    p1.y = rect.y +  rect.h/2*(math.sin(math.atan2(dy, dx)))
end

function draw()

     clear_background(color.BLACK)
     draw_rectangle_pro(rect,origin,rot,color.RED)
     draw_circle(p1, color.YELLOW)
end