--- More shapes and basic lines
function init()

  
    p1 = make_point(screenwidth/2,screenheight/2)
    linep1 = make_point( 12,10)
    linep2 = make_point( 410,310)
    linep3 = make_point( 410,10)
    linep4 = make_point( 10,310)
end

function update()
    
end

function draw()

    clear_background(color.BLACK)
    -- ellipse
    -- draw_ellipse( center, radius horizontal,  radius vertical,  color)
    draw_ellipse(p1,89.0,15,color.BLUE)
    -- draw_ellipse_lines( center, radius horizontal,  radius vertical,  color)
    draw_ellipse_lines(p1,120.0,20,color.WHITE)

    -- draw ring
    -- draw_ring(center, innerRadius, outerRadius, startAngle,endAngle, segments,color)
    draw_ring(p1,100.0,160,10,98.0,28,color.WHITE)
    -- draw_ring_lines(center, innerRadius, outerRadius, startAngle,endAngle, segments,color)
    draw_ring_lines(p1,100.0,105,130,190.0,28,color.RED)

    -- basic line
    draw_line(linep1,linep2, color.RED)
    draw_line_thick(linep1,linep2, 3.4, color.GREEN)

    -- bezier line
    draw_line_bezier(linep1,linep2, 3.0, color.YELLOW)
end