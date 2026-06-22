--- basic color palette
function init()

    title ="PALETTE"
    screenwidth = 1200
    screenheight = 900
    colors = {
    color.WHITE,color.BLACK, 
    color.GREEN,color.LIGHTGRAY,
    color.GRAY,color.DARKGRAY,
    color.YELLOW, color.GOLD,
    color.ORANGE, color.PINK,
    color.RED,color.MAROON,
    color.GREEN,color.LIME,
    color.DARKGREEN,color.SKYBLUE,
    color.BLUE,color.DARKBLUE,
    color.PURPLE,
    color.VIOLET,color.DARKPURPLE,
    color.BEIGE,color.DARKBROWN,
    color.BLANK,color.MAGENTA,
    color.RAYWHITE,
    color.GB_COLOR1,
    color.GB_COLOR2,
    color.GB_COLOR3,
    color.GB_COLOR4,
    }

    text_col = {
    "color.WHITE","color.BLACK", 
    "color.GREEN","color.LIGHTGRAY",
    "color.GRAY","color.DARKGRAY",
    "color.YELLOW", "color.GOLD",
    "color.ORANGE"," color.PINK",
    "color.RED","color.MAROON",
    "color.GREEN","color.LIME",
    "color.DARKGREEN","color.SKYBLUE",
    "color.BLUE","color.DARKBLUE",
    "color.PURPLE",
    "color.VIOLET","color.DARKPURPLE",
    "color.BEIGE","color.DARKBROWN",
    "color.BLANK","color.MAGENTA",
    "color.RAYWHITE",
    "color.GB_COLOR1",
    "color.GB_COLOR2",
    "color.GB_COLOR3",
    "color.GB_COLOR4",
    }

    xstart=20
    ystart=20

    local x = xstart
    local y = ystart

    wid_ = 30
    heig_ = 30

    dist = 4
    vdist = 10

    rectangles = {}

    for j=1,30 do
        
     
        x = 20 + 150*(j%7) + 10*(j%7)
        y = 40 + 100*(math.floor(j/7.0)) + 40*(math.floor(j/7.0))
        local rect_ = make_rectangle(x,y,wid_,heig_)
       
        table.insert(rectangles,rect_)
    end

end

function update()

end

function draw()
    local fontsize = 14
    clear_background(color.BLACK)
    for i,v in ipairs(rectangles) do
        
        draw_rectangle(v, colors[i])
        if i~=2 and i~=24 then
            draw_text(text_col[i],v.x+wid_+4,v.y,fontsize,colors[i])
        elseif i==2 and i~=24 then
            draw_text(text_col[i],v.x+wid_+4,v.y,fontsize,colors[1])
        elseif i==24  then
           
            draw_text(text_col[i],v.x+wid_+4,v.y,fontsize,colors[1])
        end
        
    end

end