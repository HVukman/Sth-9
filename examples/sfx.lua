--- program to manipulate and play sfx sounds
function init()
    sound_ = 0
    pitch_= 0.0 -- base pitch
    change = 0.01
    pan_ = 0.0
end

function update()

    if key_pressed(key.P) then
        play_sfx(sound_)
    end
    if key_pressed(key.SPACE) then
        sound_= (sound_ + 1) % 7
    end

    if key_pressed(key.DOWN) then
        pitch_ = pitch_ - change
        set_sfx_pitch(sound_,pitch_)
    end
     if key_pressed(key.UP) then
        pitch_ = pitch_ + change
        set_sfx_pitch(sound_,pitch_)
    end

    if key_pressed(key.LEFT) then
        pan_ = pan_ + change
        if pan_>1.0 then pan_=1.0 end
        set_sfx_pan(sound_,pan_)
    end
     if key_pressed(key.RIGHT) then
        pan_ = pan_ - change
        if pan_<-1.0 then pan_=-1.0 end
        set_sfx_pan(sound_,pan_)
    end

end

function draw() 
    clear_background(color.BLACK)
    draw_text("Current sound : " .. tostring(sound_) , 10, 10 , 25, color.YELLOW)
    draw_text("Press SPACE to cycle and P to play", 10, 50 , 25, color.YELLOW)
    draw_text("Press UP/DOWN to change pitch " , 10, 80 , 25, color.YELLOW)
    draw_text("Press LEFT/RIGHT to change pan " , 10, 110 , 25, color.YELLOW)
end