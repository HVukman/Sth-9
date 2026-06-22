--- 
function init()
    title ="Delta Time"
    currentfps = 60 --- 60 is the standard time
    speed = 10.0
    -- make 2 circles
    delta_circ = make_circle(300,200,30)
    frame_circ = make_circle(300,300,30)
end

function update()

        mouseWheel =  get_wheel_movement()

        if mouseWheel.y ~= 0 then
                currentfps = currentfps + math.tointeger(mouseWheel.y)
                if (currentfps < 0) 
                    then currentfps = 0
                end
                set_target_fps(currentfps)
        end
     
        delta_circ.x = delta_circ.x + (get_frame_time()*6.0*speed)
        frame_circ.x =  frame_circ.x+ 0.1*speed

       
        if (delta_circ.x > screenwidth) then
            delta_circ.x = 0
        end 
        if (frame_circ.x > screenwidth) then
             frame_circ.x = 0
        end

     
        if (key_down(key.R))
        then
            delta_circ.x = 0
            frame_circ.x = 0
        end
             
        
end

function draw()
     
    local fps_text = ""
    clear_background(color.RAYWHITE)
    draw_circle(delta_circ,color.GOLD)
    draw_circle(frame_circ,color.VIOLET)
    
    if currentfps <= 0 then
        fps_text = "FPS unlimited"
    else
        fps_text = string.format("FPS: target (%i)", get_fps())
    end

    local frame_text = ""

    frame_text = string.format("Frame time: %02.02f ms", get_frame_time())

    draw_text(fps_text, 10, 10, 20, color.DARKGRAY)
    draw_text(frame_text, 10, 30, 20, color.DARKGRAY)
    draw_text("Use the scroll wheel to change the fps limit, r to reset", 10, 50, 20, color.DARKGRAY)
    
end