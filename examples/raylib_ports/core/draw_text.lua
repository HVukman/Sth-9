--- draw text expert and pro 
function init()
     rotation = 0
end

function update()

     rotation = (rotation+1)%360
end

function draw()
     
     clear_background(color.RAYWHITE)
     draw_text("Congrats! You created your first window!", 190, 200, 20,color.BLACK)
     --draw_text_ex(string, x, y, size, spacing, color)
     draw_text_ex("Even more congrats", 190, 220, 20, 15, color.GREEN)

     --draw_text_pro(string, x, y, rotation, size, spacing, color)
     draw_text_pro("What is happening?", 190, 230, rotation, 20, 13, color.RED)

end