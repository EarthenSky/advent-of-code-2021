sbcl --noinform --load day12.lisp --eval "(progn (sb-ext:save-lisp-and-die \"day12\" :toplevel #'main :executable t) (sb-ext:quit))"