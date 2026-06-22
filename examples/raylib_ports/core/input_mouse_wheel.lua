--- 
function init()
    title= "Input Mouse Wheel"
    
    -- make rectangle
    rect = make_rectangle(screenwidth/2-100,screenheight/2,200,150)
    scrollspeed = 4.0

end

function update()

    wheel_movement = get_wheel_movement()
    rect.y = rect.y - (wheel_movement.y*scrollspeed) 
        
end

function draw()
     
    clear_background(color.RAYWHITE)
    draw_rectangle(rect,color.RED)
    
    draw_text("Use mouse wheel to move the cube up and down!", 10, 10, 20, color.GRAY);
    draw_text(string.format("Box position Y: %03i", rect.y), 10, 40, 20, color.LIGHTGRAY);

    
end