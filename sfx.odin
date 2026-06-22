package sth9 

import rl "vendor:raylib"
import luajit "luajit"
import luaL_luajit "luajit/luaL"
import "core:math"
import "core:math/rand"
import "core:fmt"
import sounds "sounds"

// sound 1
sfx1 : rl.Wave
sample_rate1 :: sounds.SOUND_SAMPLE_RATE1
total_samples1 :: sounds.SOUND_SAMPLE_RATE1
audio_data1 : [total_samples1]i16

// sound 2
sfx2 : rl.Wave
sample_rate2 :: sounds.SOUND_SAMPLE_RATE2 
total_samples2 :: sounds.SOUND_SAMPLE_RATE2
audio_data2 : [total_samples2]i16

sfx3 : rl.Wave
sample_rate3 :: 46000
total_samples3 :: 2300
audio_data3 : [total_samples3]i16


sfx4 : rl.Wave
sample_rate4 :: 12000
total_samples4 :: 1200
audio_data4 : [total_samples4]i16

sfx5: rl.Wave
sample_rate5 ::  44100
total_samples5 :: 24826
audio_data5 : [total_samples5]i16

sfx6 : rl.Wave
sample_rate6 :: 32000
total_samples6 ::64000
audio_data6 : [total_samples6]i16

sfx7 : rl.Wave
sample_rate7 :: 34000
total_samples7 :: 102000
audio_data7 : [total_samples7]i16

sound1 : rl.Sound
sound2 : rl.Sound
sound3 : rl.Sound
sound4 : rl.Sound
sound5 : rl.Sound
sound6 : rl.Sound
sound7: rl.Sound



MAX_SOUNDS :: 8
sfx_sounds : [MAX_SOUNDS]rl.Sound

// play sound table


// make sound table
l_make_sound :: proc "c" () -> i32 {

    // 
    return 1
}

init_sfx :: proc  () {

    // sound 1
    
    sfx1 = rl.Wave{
    frameCount = sounds.SOUND_FRAME_COUNT1,
    sampleRate = sounds.SOUND_SAMPLE_RATE1,
    sampleSize = sounds.SOUND_SAMPLE_SIZE1,
    channels   = sounds.SOUND_CHANNELS1,
    data       = raw_data(sounds.WAV_DATA1[:]),
    }

    sound1 = rl.LoadSoundFromWave(sfx1)
    sfx_sounds[0] = sound1
    
    // sound 2
 
     sfx2 = rl.Wave{
    frameCount = sounds.SOUND_FRAME_COUNT2,
    sampleRate = sounds.SOUND_SAMPLE_RATE2,
    sampleSize = sounds.SOUND_SAMPLE_SIZE2,
    channels   = sounds.SOUND_CHANNELS2,
    data       = raw_data(sounds.WAV_DATA2[:]),
    }

   

    sound2 = rl.LoadSoundFromWave(sfx2)
    sfx_sounds[1] = sound2
    
    // sound 3
   
    frequency3 := 360.00
    for i := 0; i < total_samples3; i += 1 {
        phase := f32(i) * f32(frequency3) / f32(sample_rate3) * 2.0 * math.PI
        audio_data3[i] = i16(math.cos_f32(phase) * 32767.0)
    }

    sfx3.channels = 1
    sfx3.frameCount = u32(total_samples3)
    sfx3.sampleRate = u32(sample_rate3)
    sfx3.sampleSize = 16
    sfx3.data = raw_data(audio_data3[:])

    sound3 = rl.LoadSoundFromWave(sfx3)
    sfx_sounds[2] = sound3
   
     // sound 4 (white noise)
    
    for i := 0; i < total_samples4; i += 1 {
            value := i16(0)
        if rand.int31() % 2 == 0 {
            value = 32767   // full positive
        } else {
            value = -32768  // full negative
        }
        audio_data4[i] = value
        }

    sfx4.channels = 1
    sfx4.frameCount = u32(total_samples4)
    sfx4.sampleRate = u32(sample_rate4)
    sfx4.sampleSize = 16
    sfx4.data = raw_data(audio_data4[:])

    sound4 = rl.LoadSoundFromWave(sfx4)
    sfx_sounds[3] = sound4

     
     // sound 5 (pink noise)
   

    white := f32(0.0)
    pink := f32(0.0)
    for i := 0; i < total_samples5; i += 1 {
            white = f32(rand.int31() % 65536 - 32768) / 32768.0
    
            // Simple low-pass filter (one-pole)
            pink = pink * 0.95 + white * 0.05
    
            audio_data5[i] = i16(pink * 32767.0)
        }

    sfx5.channels = 1
    sfx5.frameCount = u32(total_samples5)
    sfx5.sampleRate = u32(sample_rate5)
    sfx5.sampleSize = 16
    sfx5.data = raw_data(audio_data5[:])

    sound5 = rl.LoadSoundFromWave(sfx5)
    sfx_sounds[4] = sound5


    // drum sound ? 
    sfx6 = rl.Wave{
    frameCount = sounds.SOUND_FRAME_COUNT5,
    sampleRate = sounds.SOUND_SAMPLE_RATE5,
    sampleSize = sounds.SOUND_SAMPLE_SIZE5,
    channels   = sounds.SOUND_CHANNELS5,
    data       = raw_data(sounds.WAV_DATA5[:]),
    }
    sound6 = rl.LoadSoundFromWave(sfx6)
    sfx_sounds[5] = sound6

     // sound 7 (space?)
   
   
     sfx6 = rl.Wave{
    frameCount = sounds.SOUND_FRAME_COUNT6,
    sampleRate = sounds.SOUND_SAMPLE_RATE6,
    sampleSize = sounds.SOUND_SAMPLE_SIZE6,
    channels   = sounds.SOUND_CHANNELS6,
    data       = raw_data(sounds.WAV_DATA6[:]),
    }
    sound7 = rl.LoadSoundFromWave(sfx6)
    sfx_sounds[6] = sound7
   
}


l_play_sfx ::  proc "c" (L: luaL_luajit.State) -> i32 {

    ind_:= luaL_luajit.checkinteger(L,-1)

    if ind_ < MAX_SOUNDS && 0<=ind_{
        rl.PlaySound(sfx_sounds[ind_])
    }
    return 0
}

