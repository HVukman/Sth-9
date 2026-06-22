-- tests function of gamepad
function init()
    screenwidth = 400
    screenheight= 300
    sprite_width= 64
    sprite_height= 64
    load_image("gamepad","examples/gamepad.png")

    -- right face
    circ_right_face_down = make_circle(197,165,8)
    circ_right_face_left = make_circle(179,148,8)
    circ_right_face_right = make_circle(210,151,8)
    circ_right_face_up = make_circle(197,135,8)

   -- left face
    circ_left_face_up = make_circle(40,125,8)
    circ_left_face_down = make_circle(40,155,8)
    circ_left_face_left = make_circle(32,140,8)
    circ_left_face_right = make_circle(50,140,8)

    -- middle 
    circ_middle_left = make_circle(90,125,8)
    circ_middle_right = make_circle(140,125,8)

    -- left trigger
     circ_trigger_left = make_circle(40,80,8)
     -- right trigger
     circ_trigger_right = make_circle(200,80,8)
    -- LEFT_TRIGGER_1
    

end

function update()
    
end

function draw()
    clear_background(color.GRAY)
    -- test only first gamepad 
    if is_gamepad_available(0) then
        draw_text("Gamepad found!" , 10, 20, 19, color.RED)
        draw_sprite_pro( "gamepad", 10 ,0,10,0,4.0)
        draw_text(string.format("%s gamepad , %i button pressed", get_gamepad_name(0),get_gamepad_button_pressed() ), 0, 220,18,color.RED)
        
        -- find the right button and show the result 
        if is_gamepad_button_pressed(0,gamepad.GAMEPAD_RIGHT_FACE_DOWN) then
                draw_circle(circ_right_face_down,color.YELLOW)
        end

        if is_gamepad_button_pressed(0,gamepad.GAMEPAD_RIGHT_FACE_LEFT) then
                draw_circle(circ_right_face_left,color.YELLOW)
        end

        if is_gamepad_button_pressed(0,gamepad.GAMEPAD_RIGHT_FACE_RIGHT) then
                draw_circle(circ_right_face_right,color.YELLOW)
        end

        if is_gamepad_button_pressed(0,gamepad.GAMEPAD_RIGHT_FACE_UP) then
                draw_circle(circ_right_face_up,color.YELLOW)
        end

        if is_gamepad_button_pressed(0,gamepad.GAMEPAD_LEFT_FACE_UP) then
                draw_circle(circ_left_face_up,color.YELLOW)
        end

        if is_gamepad_button_pressed(0,gamepad.GAMEPAD_LEFT_FACE_DOWN) then
                draw_circle(circ_left_face_down,color.YELLOW)
        end

        if is_gamepad_button_pressed(0,gamepad.GAMEPAD_LEFT_FACE_LEFT) then
                draw_circle(circ_left_face_left,color.YELLOW)
        end

        if is_gamepad_button_pressed(0,gamepad.GAMEPAD_LEFT_FACE_RIGHT) then
                draw_circle(circ_left_face_right,color.YELLOW)
        end

        if is_gamepad_button_pressed(0,gamepad.GAMEPAD_MIDDLE_LEFT) then
                draw_circle(circ_middle_left,color.YELLOW)
        end

         if is_gamepad_button_pressed(0,gamepad.GAMEPAD_MIDDLE_RIGHT) then
                draw_circle(circ_middle_right,color.YELLOW)
        end

        if is_gamepad_button_pressed(0,gamepad.GAMEPAD_LEFT_TRIGGER_1) then
                draw_circle(circ_trigger_left,color.YELLOW)
        end
    
        if is_gamepad_button_pressed(0,gamepad.GAMEPAD_RIGHT_TRIGGER_1) then
                draw_circle(circ_trigger_right,color.YELLOW)
        end
        
      

    else
        draw_text(" No gamepad!" , 0, 20, 14, color.RED)
    end
    
  
 

end