--- add music and play
function init()
    add_music("example", "examples/resources/Sample.mp3")
    pan_ = 0.0
    set_music_pan("example",pan_ )
    play_music("example")
    pitch_=0.5
    manip = 0.01
    font_size = 22
end

function update()

    if key_pressed(key.UP) then
        pitch_ = pitch_ + manip
        set_music_pitch("example", pitch_)
    end
    if key_pressed(key.DOWN) then
        pitch_ = pitch_ - manip
        set_music_pitch("example", pitch_)
    end
    if key_pressed(key.LEFT) then
        pan_ = pan_ + manip
        if pan_>1.0 then pan_ = 1.0 end
        set_music_pan("example", pan_)
    end
     if key_pressed(key.RIGHT) then
        pan_ = pan_ - manip
         if pan_<- 1.0 then pan_ = -1.0 end
        set_music_pan("example", pan_)
    end
end

function draw()
    clear_background(color.BLACK)
     draw_text("You should hear music ",100,100,font_size,color.YELLOW)
     draw_text("Press Left/Right to Shift Pan",100,130,font_size,color.YELLOW)
     draw_text("Press Up/Down to Shift Pitch",100,160,font_size,color.YELLOW)
     draw_text( string.format(" Pan %.2f Pitch %.2f" , pan_, pitch_),100,190,font_size,color.YELLOW)
end