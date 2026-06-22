--- add music and play
function init()
    add_music("example", "examples/music/Sample.mp3")
    font_size = 20
    play_music("example")
    music_volume = 0.7
    set_music_volume("example", music_volume)
end

function update()

    if key_pressed(key.S) then
        if (is_music_playing("example")) then
            stop_music("example")
        end
    end
    if key_pressed(key.P) then
            pause_music("example")
    end

    if key_pressed(key.R) then
        if not(is_music_playing("example")) then
            play_music("example")
        end
    end
    if key_pressed(key.DOWN) then
        music_volume = music_volume - 0.05
        if music_volume <0.0 then music_volume = 0.0 end
        set_music_volume("example", music_volume)
    end
     if key_pressed(key.UP) then
        music_volume = music_volume + 0.05
         if music_volume >1.0 then music_volume = 1.0 end
        set_music_volume("example", music_volume)
    end

    
end

function draw()
     clear_background(color.BLACK)
     draw_text("You should hear music",100,100,font_size,color.YELLOW)
     draw_text("Press P to Pause",100,130,font_size,color.YELLOW)
     draw_text("Press R to Resume",100,160,font_size,color.YELLOW)
     draw_text( "Press Up/Down to Increase/Decrease Volume" ,100,190,font_size,color.YELLOW)
     draw_text( string.format(" Music of length %.0f sec played for %.2f sec",get_music_length("example"),get_music_time_played("example")  ),100,210,font_size,color.YELLOW)
     draw_text( "Press S to Stop" ,100,230,font_size,color.YELLOW)
end