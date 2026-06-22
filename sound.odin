package sth9
import rl "vendor:raylib"
import "core:time"
import luajit "luajit"
import luaL_luajit "luajit/luaL"
import "core:fmt"
import "core:math"
import "base:runtime"
import "core:os"

// sound map
sound_map : map[string]rl.Sound

// music map
MUSICS :: 12
music_map : map[string]rl.Music


sound_array_ : [12]rl.Sound


// for sfx too!
// set_sfx_pan(sfx,pan)
l_set_sfx_pitch :: proc "c" ( L: luaL_luajit.State) -> i32 {

     sfx_ := luaL_luajit.checknumber(L,-2)
     pitch := luaL_luajit.checknumber(L,-1)

     if 0<=int(sfx_)&& int(sfx_)<MAX_SOUNDS{

         rl.SetSoundPitch(sfx_sounds[int(sfx_)],f32(pitch))
     }
    
   return 0
}

// set_sfx_pan(sfx,pan)
l_set_sfx_pan :: proc "c" ( L: luaL_luajit.State) -> i32 {

     sfx_ := luaL_luajit.checknumber(L,-2)
     pitch := luaL_luajit.checknumber(L,-1)

     if 0<=int(sfx_)&& int(sfx_)<MAX_SOUNDS{

         rl.SetSoundPan(sfx_sounds[int(sfx_)],f32(pitch))
     }
    
   return 0
}

// set sound pan
l_set_sound_pan :: proc "c" ( L: luaL_luajit.State) -> i32 {

     name_ := luaL_luajit.checkstring(L,-2)
     pitch := luaL_luajit.checknumber(L,-1)

     _, ok := music_map[string(name_)] 

     if ok{
        rl.SetSoundPan(sound_map[string(name_)],f32(pitch) )
        return 1
     }else{
        luaL_luajit.error(L, "%s music not found ", name_)
        return 0
     }
   return 0
}

// set sound pitch
l_set_sound_pitch :: proc "c" ( L: luaL_luajit.State) -> i32 {

     name_ := luaL_luajit.checkstring(L,-2)
     pitch := luaL_luajit.checknumber(L,-1)

     _, ok := music_map[string(name_)] 

     if ok{
        rl.SetSoundPitch(sound_map[string(name_)],f32(pitch) )
        return 1
     }else{
        luaL_luajit.error(L, "%s music not found ", name_)
        return 0
     }
   return 0
}

// get_music_length (name)
l_get_music_time_played :: proc "c" ( L: luaL_luajit.State) -> i32 {

     name_ := luaL_luajit.checkstring(L,-1)
     _, ok := music_map[string(name_)] 

     if ok{
        res:=rl.GetMusicTimePlayed(music_map[string(name_)] )
        luajit.pushnumber(L,luajit.Number(res))
        return 1
     }else{
        luaL_luajit.error(L, "%s music not found ", name_)
        return 0
     }

}

// get_music_length (name)
l_get_music_length :: proc "c" ( L: luaL_luajit.State) -> i32 {

     
     name_:= luaL_luajit.checkstring(L,-1)
     _, ok := music_map[string(name_)] 

     if ok{
        res:=rl.GetMusicTimeLength(music_map[string(name_)] )
        luajit.pushnumber(L,luajit.Number(res))
        return 1
     }else{
        luaL_luajit.error(L, "%s music not found ", name_)
        return 0
     }

}

// set_music_time (name, time (in seconds))
l_seek_music_time:: proc "c" ( L: luaL_luajit.State) -> i32 {

     time_ := f32(luaL_luajit.checknumber(L,-1))
     name_:= luaL_luajit.checkstring(L,-2)
     _, ok := music_map[string(name_)] 

     if ok{
        rl.SeekMusicStream(music_map[string(name_)], time_ )
     }else{
        luaL_luajit.error(L, "%s music not found ", name_)
     }

     return 0
}

// set_music_pan (name, pan)
l_set_music_pan:: proc "c" ( L: luaL_luajit.State) -> i32 {

     pan_ := f32(luaL_luajit.checknumber(L,-1))
     name_:= luaL_luajit.checkstring(L,-2)
     _, ok := music_map[string(name_)] 

     if ok{
        rl.SetMusicPan(music_map[string(name_)], pan_ )
     }else{
        luaL_luajit.error(L, "%s music not found ", name_)
     }

     return 0
}

// set_music_pitch (name, pitch)
l_set_music_pitch :: proc "c" ( L: luaL_luajit.State) -> i32 {

     pitch_ := f32(luaL_luajit.checknumber(L,-1))
     name_:= luaL_luajit.checkstring(L,-2)
     _, ok := music_map[string(name_)] 

     if ok{
        rl.SetMusicPitch(music_map[string(name_)], pitch_ )
     }else{
        luaL_luajit.error(L, "%s music not found ", name_)
     }

     return 0
}

// set_music_volume (name, vol)
l_set_music_volume :: proc "c" ( L: luaL_luajit.State) -> i32 {

     vol_ := f32(luaL_luajit.checknumber(L,-1))
     name_:= luaL_luajit.checkstring(L,-2)
     _, ok := music_map[string(name_)] 

     if ok{
        rl.SetMusicVolume(music_map[string(name_)], vol_ )
     }else{
        luaL_luajit.error(L, "%s music not found ", name_)
     }

     return 0
}

l_is_music_playing :: proc "c" ( L: luaL_luajit.State) -> i32 {

     name_:= luaL_luajit.checkstring(L,-1)
     _, ok := music_map[string(name_)] 
     
     if ok{
        is_music_playing := rl.IsMusicStreamPlaying(music_map[string(name_)] )
        luajit.pushboolean(L,i32(is_music_playing))
        return 1
    } else{
        luaL_luajit.error(L, "%s music not found " , name_ )
        return 0
    }


     
}


// stop_music (name, filepath)
l_stop_music :: proc "c" ( L: luaL_luajit.State) -> i32 {

     name_:= luaL_luajit.checkstring(L,-1)
     _, ok := music_map[string(name_)] 

     if ok{
        if rl.IsMusicStreamPlaying(music_map[string(name_)]){
             rl.StopMusicStream(music_map[string(name_)] )
        }
       
     }else{
        luaL_luajit.error(L, "%s music not found ", name_)
     }

     return 0
}


// resume_music (name, filepath)
l_resume_music :: proc "c" ( L: luaL_luajit.State) -> i32 {

     name_:= luaL_luajit.checkstring(L,-1)
     _, ok := music_map[string(name_)] 

     if ok{
        if !rl.IsMusicStreamPlaying(music_map[string(name_)]){
             rl.ResumeMusicStream(music_map[string(name_)] )
        }
       
     }else{
        luaL_luajit.error(L, "%s music not found ", name_)
     }

     return 0
}


// pause_music (name, filepath)
l_pause_music :: proc "c" ( L: luaL_luajit.State) -> i32 {

     name_:= luaL_luajit.checkstring(L,-1)
     _, ok := music_map[string(name_)] 

     if ok{
         if rl.IsMusicStreamPlaying(music_map[string(name_)]){
            rl.PauseMusicStream(music_map[string(name_)] )
         }
     }else{
        luaL_luajit.error(L, "%s music not found ", name_)
     }

     return 0
}

// play_music (name)
l_play_music :: proc "c" ( L: luaL_luajit.State) -> i32 {

     name_:= luaL_luajit.checkstring(L,-1)
     _, ok := music_map[string(name_)] 

     if ok{
        
        rl.PlayMusicStream(music_map[string(name_)] )
     }else{
        luaL_luajit.error(L, "%s music not found ", name_)
     }

     return 0
}

// add_music(name, filepath)
l_add_music :: proc "c" ( L: luaL_luajit.State, ) -> i32 {

    context = runtime.default_context()
    file_:= luaL_luajit.checkstring(L,-1)

    isfile_ := os.is_file(string(file_))
    name_ := luaL_luajit.checkstring(L,-2)
    
    if isfile_ {
            mus_ := rl.LoadMusicStream(file_)

            if rl.IsMusicValid(mus_){
                 music_map[string(name_)] = mus_
            }else{
                luaL_luajit.error(L, "%s is not a valid music file ", file_)
            }
           
       
    }else{
        luaL_luajit.error(L, "%s was not found ", file_)
        return 0
    }
    return 0

}


// add sound to array
l_add_sound_ :: proc "c" ( L: luaL_luajit.State, ) -> i32 {

    context = runtime.default_context()
    file_:= luaL_luajit.checkstring(L,-1)

    isfile_ := os.is_file(string(file_))
    place_ := luaL_luajit.checkinteger(L,-2)
    
    if isfile_ {
            sound_ := rl.LoadSound(file_)

            if rl.IsSoundValid(sound_){
                sound_array_[int(place_)] = sound_
            }else{
                luaL_luajit.error(L, "%s is not a valid sound ", sound_)
                return 0
    }
            
       
    }else{
        luaL_luajit.error(L, "%s was not found ", file_)
        return 0
    }
    return 0

}
// add_sound(name, filepath)
l_add_sound :: proc "c" ( L: luaL_luajit.State, ) -> i32 {

    context = runtime.default_context()
    file_:= luaL_luajit.checkstring(L,-1)

    isfile_ := os.is_file(string(file_))
    name_ := luaL_luajit.checkstring(L,-2)
    
    if isfile_ {
            sound_ := rl.LoadSound(file_)

            if rl.IsSoundValid(sound_){
                sound_map[string(name_)] = sound_
            }else{
                luaL_luajit.error(L, "%s is not a valid sound ", sound_)
                return 0
    }
            
       
    }else{
        luaL_luajit.error(L, "%s was not found ", file_)
        return 0
    }
    return 0

}

l_play_sound :: proc "c" ( L: luaL_luajit.State) -> i32 {

     name_:= luaL_luajit.checkstring(L,-1)
     _, ok := sound_map[string(name_)] 

     if ok{
        rl.PlaySound(sound_map[string(name_)] )
     }else{
        luaL_luajit.error(L, "%s sound not found ", name_)
     }

     return 0
}

l_stop_sound :: proc "c" ( L: luaL_luajit.State) -> i32 {

     name_:= luaL_luajit.checkstring(L,-1)
     _, ok := sound_map[string(name_)] 

     if ok{
        if rl.IsSoundPlaying(sound_map[string(name_)] ) {
            rl.StopSound(sound_map[string(name_)] )
        }
        
     }

     return 0
}

l_pause_sound :: proc "c" ( L: luaL_luajit.State) -> i32 {

     name_:= luaL_luajit.checkstring(L,-1)
     _, ok := sound_map[string(name_)] 

     if ok{
        rl.PauseSound(sound_map[string(name_)] )
     }

     return 0
}

l_resume_sound :: proc "c" ( L: luaL_luajit.State) -> i32 {

     name_:= luaL_luajit.checkstring(L,-1)
     _, ok := sound_map[string(name_)] 

     if ok{
        rl.ResumeSound(sound_map[string(name_)] )
     }

     return 0
}

l_is_sound_playing :: proc "c" ( L: luaL_luajit.State) -> i32 {

     name_:= luaL_luajit.checkstring(L,-1)
     _, ok := sound_map[string(name_)] 

     if ok{
        is_playing:= rl.IsSoundPlaying(sound_map[string(name_)] )
        luajit.pushboolean(L, i32(is_playing))
        return 1
     } else{
        luaL_luajit.error(L, "%s sound not found ", name_)
        return 0
     }

     
}