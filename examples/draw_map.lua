-- draw map with function

function draw_map ( map_, sheet)
     -- save old height and width
    local old_width = sprite_width 
    local old_height = sprite_height
    local first = map_.tilesets[1].firstgid
    for i=1, #map_.layers do
         map_.layers[i].width = sprite_width 
         map_.layers[i].height = sprite_height 
         for j=1,(sprite_width*sprite_height) do
            local x = (sprite_width*j )%(sprite_width*sprite_height)
            local y = ((j//sprite_height)%sprite_height)*sprite_height
           
            if (map_.layers[i].data[j]>=first) then
                 draw_sprite( sheet,map_.layers[i].data[j]-first ,x,y)
            end
         end
         
    end
    -- restore sprite_width and height 
    sprite_width = old_width
    sprite_height = old_height
end


function init()

    palette= 0
    load_image("simple_set","examples/resources/simple_set.png")
    -- import map
    imported_map = require("examples/resources/map")
end

function update()

end

function draw()
    clear_background(color.BLACK)
    draw_map(imported_map,"simple_set")
   -- draw_sprite( "simple_set", 1 ,60,14)
   -- draw_sprite( "simple_set",0 ,120,14)
end