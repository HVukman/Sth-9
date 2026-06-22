package sth9

import luajit "luajit"
import luaL_luajit "luajit/luaL"
import "core:os"
import "base:runtime"
import "core:strings"
import "core:fmt"
import "core:time"

// puts hour string 24hrs
l_to_hms_24 :: proc "c" (L: luaL_luajit.State) -> i32 {
    buf: [64]u8
    context= runtime.default_context()
    time_ := luaL_luajit.checknumber(L,-1)
    new_time : time.Time
    new_time._nsec = i64(time_)
    hms_12 := time.to_string_hms(new_time, buf[:])

    res_string := strings.clone_to_cstring(hms_12)
    luajit.pushstring(L, res_string)
    
    return 1
}


// puts hour string 12hrs
l_to_hms_12 :: proc "c" (L: luaL_luajit.State) -> i32 {
    buf: [64]u8
    context= runtime.default_context()
    time_ := luaL_luajit.checknumber(L,-1)
    new_time : time.Time
    new_time._nsec = i64(time_)
    hms_12 := time.to_string_hms_12(new_time, buf[:])

    res_string := strings.clone_to_cstring(hms_12)
    luajit.pushstring(L, res_string)
    
    return 1
}

// puts day of time as number
l_to_day:: proc "c" (L: luaL_luajit.State) -> i32 {

    context= runtime.default_context()
    time_ := luaL_luajit.checknumber(L,-1)
    new_time : time.Time
    new_time._nsec = i64(time_)
    weekday_ := time.day(new_time)
    luajit.pushinteger(L, luajit.Integer(weekday_))
    
    return 1
}

// puts year of time as number
l_to_year:: proc "c" (L: luaL_luajit.State) -> i32 {

    context= runtime.default_context()
    time_ := luaL_luajit.checknumber(L,-1)
    new_time : time.Time
    new_time._nsec = i64(time_)
    weekday_ := time.year(new_time)
    luajit.pushinteger(L, luajit.Integer(weekday_))
    
    return 1
}

// puts current month in string
l_month_now :: proc "c" (L: luaL_luajit.State) -> i32 {
    
    context= runtime.default_context()
  
    new_time : time.Time
    new_time._nsec = i64(time.now()._nsec)
    weekday_ := time.month(new_time)
    
    new_str : string

    switch weekday_{
        case .January:
            new_str = "January"
        case .February:
            new_str = "February"
        case .March:
            new_str = "March"
        case .April:
            new_str = "April"
        case .May:
            new_str = "May"
        case .June:
            new_str = "June"
        case .July:
            new_str = "July"
        case .August:
            new_str = "August"
        case .September:
            new_str = "September"
        case .October:
            new_str = "October"
        case .November:
            new_str= "November"
        case .December:
            new_str = "December"

    }

    return_str := strings.clone_to_cstring(new_str)
    luajit.pushstring(L, return_str)
    
    return 1
}

// puts weekday of time as number
l_to_month :: proc "c" (L: luaL_luajit.State) -> i32 {

    context= runtime.default_context()
    time_ := luaL_luajit.checknumber(L,-1)
    new_time : time.Time
    new_time._nsec = i64(time_)
    weekday_ := time.month(new_time)
    luajit.pushinteger(L, luajit.Integer(weekday_))
    
    return 1
}

// puts weekday of time

l_to_month_string :: proc "c" (L: luaL_luajit.State) -> i32 {

    context= runtime.default_context()
    time_ := luaL_luajit.checknumber(L,1)
    new_time : time.Time
    new_time._nsec = i64(time_)
    weekday_ := time.month(new_time)
    
    new_str : string

    switch weekday_{
        case .January:
            new_str = "January"
        case .February:
            new_str = "February"
        case .March:
            new_str = "March"
        case .April:
            new_str = "April"
        case .May:
            new_str = "May"
        case .June:
            new_str = "June"
        case .July:
            new_str = "July"
        case .August:
            new_str = "August"
        case .September:
            new_str = "September"
        case .October:
            new_str = "October"
        case .November:
            new_str= "November"
        case .December:
            new_str = "December"

    }

    return_str := strings.clone_to_cstring(new_str)
    luajit.pushstring(L, return_str)
    
    return 1
}


// odin process to sleep
l_sleep :: proc "c" (L: luaL_luajit.State) -> i32 {

    context= runtime.default_context()
    sec:= luaL_luajit.checknumber(L,-1)
    // Convert seconds to nanoseconds
    nanoseconds := i64(sec * 1000000000)
    duration := time.Duration(nanoseconds)
    time.sleep(duration)
    return 0
}

// gets weekday of time
l_weekday :: proc "c" (L: luaL_luajit.State) -> i32 {

    context= runtime.default_context()
    buf: [64]u8
    now := time.now()
    day := time.weekday(now)

    new_str : string

    switch day{
        case .Monday:
            new_str = "Monday"
        case .Tuesday:
            new_str = "Tuesday"
        case .Wednesday:
            new_str = "Wednesday"
        case .Thursday:
            new_str = "Thursday"
        case .Friday:
            new_str = "Friday"
        case .Saturday:
            new_str = "Saturday"
        case .Sunday:
            new_str = "Sunday"

    }

    return_str := strings.clone_to_cstring(new_str)
    luajit.pushstring(L, return_str)
    return 1
}


// puts time now as number in absolute second

l_time_now :: proc "c" (L: luaL_luajit.State) -> i32 {

    context= runtime.default_context()
    buf: [64]u8
    now := time.now()
    time_now := now._nsec
    luajit.pushnumber(L, luajit.Number(time_now))
    return 1
}

// shows day now
l_time_now_string :: proc "c" (L: luaL_luajit.State) -> i32 {

    context= runtime.default_context()
    buf: [64]u8
    now := time.now()
    time_now := (time.to_string_hms_12(now, buf[:]))
    newstr: cstring = strings.clone_to_cstring(time_now)
    luajit.pushstring(L, newstr)
    return 1
}

// shows day now
l_today_string :: proc "c" (L: luaL_luajit.State) -> i32 {

    context= runtime.default_context()
    buf: [64]u8
    now := time.now()
    time_now := (time.to_string_dd_mm_yy(now, buf[:]))
    newstr: cstring = strings.clone_to_cstring(time_now)
    luajit.pushstring(L, newstr)
    return 1
}

// converts absolute time to string
l_to_string_dd_mm_yy :: proc "c" (L: luaL_luajit.State) -> i32 {

    context= runtime.default_context()
    
    new_time:=luaL_luajit.checknumber(L,-1)
    buf: [64]u8
    time_ : time.Time
    time_._nsec = i64(new_time)
    res:= time.to_string_dd_mm_yy(time_, buf[:])
    newstr: cstring = strings.clone_to_cstring(res)
    luajit.pushstring(L, newstr)
    return 1
}

// converts absolute time to string
l_to_string_dd_mm_yyyy :: proc "c" (L: luaL_luajit.State) -> i32 {

    context= runtime.default_context()  
    new_time:=luaL_luajit.checknumber(L,-1)
    buf: [64]u8
    time_ : time.Time
    time_._nsec = i64(new_time)
    res:= time.to_string_dd_mm_yyyy(time_, buf[:])
    newstr: cstring = strings.clone_to_cstring(res)
    luajit.pushstring(L, newstr)
    return 1
}