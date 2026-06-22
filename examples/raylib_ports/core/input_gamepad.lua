-- move circle with gamepad
function init()
    title= "Input Keys"
    speed = 5.0
    -- make circle
    radius = 30
    circ = make_circle(300,200,radius)

end

function update()

     

     if is_gamepad_available(0) then
       -- print(get_gamepad_button_pressed() == gamepad.GAMEPAD_RIGHT_FACE_UP)
        if (is_gamepad_button_pressed(0,gamepad.GAMEPAD_RIGHT_FACE_DOWN))
        then
            circ.y = circ.y + speed
        end
        if (is_gamepad_button_pressed(0,gamepad.GAMEPAD_RIGHT_FACE_UP))
        then
            circ.y = circ.y - speed
        end
        if (is_gamepad_button_pressed(0,gamepad.GAMEPAD_RIGHT_FACE_LEFT))
        then
            circ.x = circ.x - speed
        end
        if (is_gamepad_button_pressed(0,gamepad.GAMEPAD_RIGHT_FACE_RIGHT))
        then
            circ.x = circ.x + speed
        end

     end
        
       
        
end

function draw()
     
    clear_background(color.RAYWHITE)
    draw_text("move the ball with arrow keys", 10, 10, 20, color.DARKGRAY)
    draw_circle(circ,color.RED)
    
    
end