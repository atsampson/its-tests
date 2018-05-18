   A subroutine to draw a light box  with a medium point inside it  at
the center of the screen.  A description of the item is returned.

      ((lambda (oastate b)
         (disaline b -100 -100 1)     ;go to lower left corner of box
         (diset b 0 (list 3 boxscale));set scale from global variable
                              ;set bright but don't change penup
         (disaline b 0 200)   ;draw box in incremental mode
         (disaline b 200 0)
         (disaline b 0 -200)
         (disaline b -200 0)
         (disini 0)           ;go to relative mode to
         (disapoint b 0 0 '(6 0))     ;draw the point
         (disini oastate)             ;restore astate
         (discribe b))                ;return value.
       (disini 2)	      ;enter with astate 2
       (discreate 1000 1000)) ;and b set to this item.

   To add some text on top of the box, assuming astate = 0 and that  b
is the item as above:

          (discuss b -200 207 "here is the box - see the box" '(6 2))

   To move the box b right 100 units:

         (setq foo (discribe b))
         (setq foo (list (car foo) (cadr foo)))
         (dislocate b (+ 100 (car foo)) (cadr foo))

   To put a cross where the pen is now, and some text where it used to
be before it was moved:

         (dismark b -1)
         (discuss b (caddr foo) (cadddr foo) "turtle slept here"))

   To brighten the box and point (but text is already brightest, so it
does not change):

                               (dischange b 2 0)

   To get rid of the box:

                                  (disflush b)

   To get rid of the slave:

                                   (disflush)
