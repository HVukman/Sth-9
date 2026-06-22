--- Basic shapes
function init()

    -- rectangle x,y,w,h (x,y,width,height)
    rect =  make_rectangle(10,100,200,80)
   -- print (rect.w)
   -- print (rect.h)
    rect2 = make_rectangle(10,200,200,150)
    rect3 = make_rectangle(10,300,40,20)

    thick = 1.2
    rot = 9.0

    origin = make_point(rect3.x + rect3.w/2, rect3.y - rect3.h/2)

    -- circles x,y,radius

    circ1 = make_circle(300,100,30)
    circ2 = make_circle(300,180,30)

    -- triangle points

    p1 = make_point(258,259)
    p2 = make_point(360,340)
    p3 = make_point(210,390)

    p4 = make_point(308,259)
    p5 = make_point(400,340)
    p6 = make_point(280,390)

    poly_center = make_point(600,100)
    poly_center2 = make_point(600,300)
    rot_poly = 0.0
end

function update()
    rot_poly = rot_poly + 0.2
end

function draw()
     clear_background(color.BLACK)
     draw_rectangle(rect,color.RED)
     -- lines with thickness 1.2
     draw_rectangle_lines(rect2,thick,color.SKYBLUE)
     draw_rectangle_pro(rect3,origin,rot,color.MAGENTA)

     draw_circle(circ1, color.WHITE)
     draw_circle_line(circ2, color.WHITE)

     draw_triangle(p1,p2,p3,color.YELLOW)
     draw_triangle_lines(p4,p5,p6,color.RED)

     -- draw_polygon(center,sides,radius,rotation,color)
     draw_polygon(poly_center, 8, 55, 5.1, color.BLUE)
      -- draw_polygon_lines(center,sides,radius,rotation,thickness,color)
     draw_polygon_lines(poly_center2, 8, 55, rot_poly, thick,color.BLUE)

end