--- subtext
function init()
    
    message = [[Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi leo sem, sollicitudin ac tellus ut, aliquam dictum libero. \n
     Phasellus volutpat ut velit vitae lacinia. Ut ultrices mauris interdum aliquet vulputate. Aliquam ultricies nec risus ut dapibus. \n
     Curabitur odio ex, convallis eget risus a, ultricies malesuada lorem. Sed gravida neque et tellus convallis pharetra. \n
    Integer et mauris sed lacus ornare interdum. In non mi at mauris condimentum sodales.\n
    Fusce fermentum turpis dolor, non egestas lacus pretium sed. Quisque libero metus, \n
    gravida a commodo sollicitudin, rutrum vehicula dui. Aliquam erat volutpat. Nulla facilisi. \n
    Integer nec ornare nisl, non hendrerit orci. Nulla eget venenatis libero, et finibus ante. \n
    Integer rhoncus non massa ac ultrices. Nam lacus mi, rhoncus sit amet bibendum quis, hendrerit nec magna.\n
     Sed at sagittis orci. Duis vulputate lacus et massa luctus dignissim. \n
    Maecenas vel tincidunt lectus, in accumsan ante. Morbi ac purus tempor, pulvinar risus vitae, \n
     dignissim massa. Ut at blandit tortor, ut finibus turpis. Pellentesque habitant morbi tristique \n
     senectus et netus et malesuada fames ac turpis egestas. Donec neque metus, suscipit eget rhoncus quis, \n 
     eleifend a justo. Quisque condimentum lorem odio, et sagittis risus mattis at. Vestibulum pellentesque \n
     ultricies elit, nec porttitor risus pharetra dictum. Suspendisse potenti. Fusce eu risus nec arcu maximus \n
      semper. Maecenas risus ex, convallis vel rhoncus non, accumsan et massa. Proin ante libero, accumsan \n
       mattis ultrices at, imperdiet in libero. Nulla vel interdum tortor. Sed auctor lectus tincidunt \n
       mi mattis, vel semper nibh aliquet. Sed congue leo enim, ut condimentum dolor interdum vitae. \n
       Fusce aliquet, lacus nec vestibulum sodales, mi sem malesuada neque, sed consectetur ipsum augue \n
       vitae est. Aenean imperdiet, mi ut tristique volutpat, sem diam luctus turpis, et porta risus massa \n
        id orci. 
    ]]
    frame_counter = 0
    text = ""
    end_string =1
end

function update()
     

    if frame_counter%10==0 then
        end_string = end_string + 1
    end

    if #text~=#message then
        if key_down(key.SPACE) then
            frame_counter = frame_counter+ 8
        else
            frame_counter = frame_counter+ 1
        end
    end

end

function draw()
    clear_background(color.BLACK)
    text = string.sub(message,1,end_string)
    draw_text(text,10,20,12,color.YELLOW)

    if #text<200 then
        draw_text("Press Space to go faster",10,300,16,color.YELLOW)
    end
end