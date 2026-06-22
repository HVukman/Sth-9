--- 
function init()
    title= "Input Mouse"
    
    -- make circle
    radius = 30
    circ = make_circle(300,200,radius)
    color_circle = color.BLUE
    -- mouse x , y
     mousex = 0
     mousey = 0

end

function update()

     circ.x =  get_mouse_x()
     circ.y =  get_mouse_y()

    if mouse_pressed(key.MOUSE_LEFT) then
        color_circle = color.RED
    elseif mouse_pressed(key.MOUSE_RIGHT) then
        color_circle = color.BLUE
    elseif mouse_pressed(key.MOUSE_MIDDLE) then
        color_circle = color.GREEN
    elseif mouse_pressed(key.MOUSE_SIDE) then
        color_circle = color.GOLD
    elseif mouse_pressed(key.MOUSE_EXTRA) then
        color_circle = color.BLACK
    end

     if key_pressed(key.H) then
        if cursor_hidden() then
            show_cursor()
        else
            hide_cursor()
        end
    end
        
end

function draw()
     
    clear_background(color.RAYWHITE)
    draw_circle(circ,color_circle)
    
    draw_text("move ball with mouse and click mouse buttons to change color", 10, 10, 20, color.DARKGRAY);
    draw_text("Press 'H' to toggle cursor visibility", 10, 30, 20, color.DARKGRAY);

     if cursor_hidden() then
            draw_text("CURSOR HIDDEN", 20, 60, 20, color.RED)
        else
            draw_text("CURSOR VISIBLE", 20, 60, 20, color.LIME)
        end
    
end