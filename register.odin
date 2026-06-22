package sth9

import luajit "luajit"
import luaL_luajit "luajit/luaL"

// register functions

register :: proc (L: ^luaL_luajit.State) {

    // set standard screenwidth and screenheight
    luajit.pushinteger(L^,luajit.Integer(SCREEN_WIDTH))
    luajit.setglobal(L^,"screenwidth")

    luajit.pushinteger(L^,luajit.Integer(SCREEN_HEIGHT))
    luajit.setglobal(L^,"screenheight")


    luaL_luajit.openlibs(L^); // Load Lua standard libraries

    // make colors and keys as tables colors,keys
    make_colors(L)
    make_keys(L)
    make_gamepad(L)
    // help_stuff

    // make shapes
    luajit.register(L^,"make_rectangle",l_make_rectangle)
    luajit.register(L^,"make_point",l_make_point)
    luajit.register(L^,"make_circle",l_make_circle)

    // draw stuff
    luajit.register(L^, "draw_text", l_draw_text )
    luajit.register(L^, "draw_text_ex", l_draw_text_ex)
    luajit.register(L^, "draw_text_pro", l_draw_text_pro )
    luajit.register(L^, "draw_pixel", l_draw_pixel )
    luajit.register(L^, "draw_rectangle", l_draw_rectangle )
    luajit.register(L^, "draw_rectangle_lines", l_draw_rectangle_lines )
    luajit.register(L^, "draw_rectangle_pro", l_draw_rectangle_pro )
    luajit.register(L^, "draw_line", l_draw_line )
    luajit.register(L^, "draw_line_bezier",l_draw_line_bezier)
    luajit.register(L^, "draw_line_thick", l_draw_line_thick )
    luajit.register(L^, "draw_circle", l_draw_circle )
    luajit.register(L^, "draw_circle_line", l_draw_circle_line)

    luajit.register(L^, "draw_triangle", l_draw_triangle)
    luajit.register(L^, "draw_triangle_lines", l_draw_triangle_lines)

    luajit.register(L^, "draw_polygon", l_draw_polygon)
    luajit.register(L^, "draw_polygon_lines", l_draw_polygon_lines)

    luajit.register(L^, "draw_ellipse", l_draw_ellipse)
    luajit.register(L^, "draw_ellipse_lines", l_draw_ellipse_lines)
    luajit.register(L^, "draw_ring", l_draw_ring)
    luajit.register(L^, "draw_ring_lines", l_draw_ring_lines)
    luajit.register(L^, "clear_background", l_clearbackground)

    // splines
    luajit.register(L^, "draw_linear_spline", l_draw_linear_spline)
	luajit.register(L^, "draw_basis_spline",l_draw_b_spline)
    luajit.register(L^, "draw_catmull_rom_spline",l_draw_catrmull_rom_spline)
    luajit.register(L^, "get_spline_point_linear",l_get_spline_point_linear)
    luajit.register(L^, "get_spline_point_basis",l_get_spline_point_basis)
    luajit.register(L^, "get_spline_point_catmull",l_get_spline_point_catmull)

    // textures
    luajit.register(L^, "load_image", l_load_image)
    luajit.register(L^, "draw_sprite", l_draw_sprite)
    luajit.register(L^, "draw_sprite_pro", l_draw_sprite_pro)

    // key stuff
    luajit.register(L^, "key_down",l_keydown)
    luajit.register(L^, "key_pressed",l_keypressed)
    luajit.register(L^, "get_char_pressed" ,l_get_charpressed)

    // gamepad
    luajit.register(L^, "is_gamepad_available", l_is_gamepad_available)
    luajit.register(L^, "get_gamepad_axis_lx " , l_get_gamepad_axis_left_x)
    luajit.register(L^, "get_gamepad_axis_rx " , l_get_gamepad_axis_right_x)
    luajit.register(L^, "get_gamepad_axis_lx " , l_get_gamepad_axis_left_y)
    luajit.register(L^, "get_gamepad_axis_rx " , l_get_gamepad_axis_right_y)
    luajit.register(L^, "get_gamepad_button_pressed" , l_get_gamepad_button_pressed)
    luajit.register(L^, "is_gamepad_button_pressed" , l_is_gamepad_button_pressed)
    luajit.register(L^, "is_gamepad_button_down" , l_is_gamepad_button_down)
    luajit.register(L^, "is_gamepad_button_released" , l_is_gamepad_button_released)
    luajit.register(L^, "is_gamepad_button_up" , l_is_gamepad_button_up)
    luajit.register(L^, "get_gamepad_name", l_get_gamepad_name)

    // mouse functions
    luajit.register(L^, "get_mouse_x", l_get_mouse_x)
    luajit.register(L^, "get_mouse_y", l_get_mouse_y)
    luajit.register(L^, "get_wheel_movement", l_get_wheel_movement)
    luajit.register(L^,"mouse_pressed", l_mouse_pressed)
    luajit.register(L^,"mouse_down", l_mouse_down)
    luajit.register(L^,"mouse_up", l_mouse_up)
    luajit.register(L^,"is_cursor_on_screen", l_cursor_on_screen)
    luajit.register(L^,"mouse_released", l_mouse_released)
    luajit.register(L^, "show_cursor", l_show_cursor)
    luajit.register(L^, "hide_cursor", l_hide_cursor)
    luajit.register(L^, "cursor_hidden", l_cursor_hidden)
    luajit.register(L^, "enable_cursor", l_enable_cursor)
    luajit.register(L^, "disable_cursor", l_disable_cursor)
    luajit.register(L^, "mouse_crosshair", l_mouse_crosshair)
    luajit.register(L^, "mouse_default", l_mouse_default)
    luajit.register(L^, "mouse_ibeam", l_mouse_ibeam)
    luajit.register(L^, "mouse_notallowed", l_mouse_notallowed)
    // io stuff
    luajit.register(L^, "read_file" , l_read_file)
    luajit.register(L^, "write_file", l_write_file)
    luajit.register(L^, "file_exist", l_exist_file)
    luajit.register(L^, "change_dir", l_change_directory)
    luajit.register(L^, "file_copy", l_copy_file)
    luajit.register(L^, "file_size", l_file_size )
    luajit.register(L^, "file_info" , l_file_info)
    luajit.register(L^, "base_file" , l_base_file)
    luajit.register(L^, "copy_directory" , l_copy_directory)
    luajit.register(L^, "dir" , l_dir)
    luajit.register(L^, "ext" , l_ext) // get extension 
    luajit.register(L^, "glob" , l_glob)
    luajit.register(L^, "is_file_dropped", l_is_file_dropped)
    luajit.register(L^, "get_info_dropped_file", l_get_dropped_info)

    // sound
    
    luajit.register (L^, "add_sound" , l_add_sound)
    luajit.register (L^, "play_sound" , l_play_sound)
    luajit.register (L^, "resume_sound" , l_resume_sound)
    luajit.register (L^, "pause_sound" , l_pause_sound)
    luajit.register (L^, "is_sound_playing" , l_is_sound_playing)
    luajit.register(L^,  "play_sfx", l_play_sfx)
    luajit.register(L^,  "set_sound_pitch",l_set_sound_pitch)
    luajit.register(L^,  "set_sound_pan",l_set_sound_pan)
    luajit.register(L^,  "set_sfx_pitch",l_set_sfx_pitch)
    luajit.register(L^,  "set_sfx_pan",l_set_sfx_pan)
    // music
    luajit.register (L^, "add_music" , l_add_music)
    luajit.register (L^, "play_music" , l_play_music)
    luajit.register (L^, "stop_music" , l_stop_music)
    luajit.register (L^, "resume_music" , l_resume_music)
    luajit.register (L^, "pause_music" , l_pause_music)
    luajit.register (L^, "is_music_playing" , l_is_music_playing)
    luajit.register (L^, "set_music_volume" , l_set_music_volume)
    luajit.register (L^, "set_music_pitch" , l_set_music_pitch)
    luajit.register (L^, "set_music_pan" , l_set_music_pan)
    luajit.register (L^, "seek_music_time" , l_seek_music_time)
    luajit.register (L^, "get_music_time_played", l_get_music_time_played)
    luajit.register (L^ , "get_music_length", l_get_music_length)

    // easing 
    luajit.register(L^, "ease_sine_in" , l_ease_sine_in)
    luajit.register(L^, "ease_sine_out" , l_ease_sine_out)
    luajit.register(L^, "ease_bounce_out", l_ease_bounce_out)
    luajit.register(L^, "ease_bounce_in", l_ease_bounce_in)
    luajit.register(L^, "ease_elastic_in", l_ease_elastic_in)
    luajit.register(L^, "ease_elastic_out", l_ease_elastic_out)
    luajit.register(L^, "ease_linear_in", l_ease_linear_in)
    luajit.register(L^, "ease_linear_out", l_ease_linear_out)
    luajit.register(L^, "ease_linear_in_out", l_ease_linear_in_out)
    luajit.register(L^, "ease_expo_in", l_ease_expo_in)
    luajit.register(L^, "ease_expo_out", l_ease_expo_out)
    luajit.register(L^, "ease_expo_in_out", l_ease_expo_in_out)

    // collisions
    luajit.register(L^, "check_collision_recs", l_check_collision_recs)
    luajit.register(L^, "check_collision_circles", l_check_collision_circles)
    luajit.register(L^, "check_collision_circle_line", l_check_collision_circle_line)
    luajit.register(L^, "check_collision_circle_rec", l_check_collision_circle_rec)
    luajit.register(L^, "check_collision_point_rec", l_check_collision_point_rec)
    luajit.register(L^, "check_collision_point_circ", l_check_collision_point_circle)
    
    // close window
    luajit.register(L^, "close_window", l_close_window)

    // time
    luajit.register (L^, "weekday", l_weekday)
    luajit.register (L^, "to_month_string", l_to_month_string)
    luajit.register (L^, "to_month", l_to_month)
    luajit.register (L^, "month_now", l_month_now)
    luajit.register (L^, "to_year", l_to_year)
    luajit.register (L^, "today_string", l_today_string)
    luajit.register(L^,  "time_now", l_time_now)
    luajit.register(L^,  "time_now_string", l_time_now_string)
    luajit.register(L^,  "time_to_hms_24",l_to_hms_24)
    luajit.register(L^,  "time_to_hms_12",l_to_hms_12)
    luajit.register (L^, "to_string_dd_mm_yy", l_to_string_dd_mm_yy)
    luajit.register (L^, "to_string_dd_mm_yyyy", l_to_string_dd_mm_yyyy)
    luajit.register (L^, "sleep", l_sleep)

    // camera2d 
    
    luajit.register(L^,"init_camera",l_init_camera)
    luajit.register(L^,"begin_mode_2D",l_begin_mode_2D)
    luajit.register(L^,"end_mode_2D",l_end_mode_2D)
    
    // fps
    luajit.register(L^,"set_target_fps", l_set_target_fps)
    luajit.register(L^, "get_fps", l_get_fps)
    luajit.register(L^, "get_frame_time", l_get_frame_time)

    // window
    luajit.register(L^,"toggle_fullscreen", l_toggle_fullscreen)
    luajit.register(L^,"toggle_borderless",l_toggle_borderless)
    luajit.register(L^,"take_screenshot", l_take_screenshot)
    luajit.register(L^,"maximize_window", l_maximize_window)
    luajit.register(L^,"minimize_window", l_minimize_window)
    luajit.register(L^,"restore_window", l_restore_window)
    luajit.register(L^,"is_window_fullscreen", l_is_window_fullscreen)
    luajit.register(L^,"is_window_minimzed", l_is_window_minimzed)
    luajit.register(L^,"is_window_maximzed", l_is_window_maximized)
    luajit.register(L^,"window_should_close", l_window_should_close)
    luajit.register(L^,"set_window_position",l_set_window_pos)
    // noise
    luajit.register(L^,"l_noise2d", l_noise2d)
    luajit.register(L^,"l_noise2d_improve_x", l_noise2d_improve_x)

    // other, helper
    //luajit.register(L^, "run_command" , l_run_command)
    luajit.register(L^, "clamp" , l_clamp)
    luajit.register(L^, "ping_pong" , l_ping_pong)
    luajit.register(L^, "sign" , l_sign)
    luajit.register(L^, "is_upper", l_is_upper)
    luajit.register(L^, "is_lower", l_is_lower)
    luajit.register(L^, "normal", l_normal_dist)
    luajit.register(L^, "pareto", l_pareto_dist)
    luajit.register(L^, "gamma_dist", l_gamma_dist)
    luajit.register(L^, "round", l_round)
}