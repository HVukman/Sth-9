

(fn draw_hello []
  (draw_text "hello" 330 100 20 (. _G.color :YELLOW))
  )
  
;; colors are global, so are keys, and the variables screenwidth, screenheight, title and palt
;; Return a table containing the functions you want to expose
{: draw_hello}