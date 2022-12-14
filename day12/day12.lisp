
(defclass Node ()
  ((adj :accessor adj)
    (add :accessor add)
    (take :accessor take)) )

; adds item to the end of the adj list
(defmethod add ((object Node) (new-item Node)) 
  (setq (Node-adj object) (append (Node-adj object) new-item)) )

(defmethod take ((object Node))
  (let ((first-element car (Node-adj object)) (the-rest cdr (Node-adj object)))
    (setf (Node-adj object) the-rest)
    first-element))

(defun part1 () 
  (progn
    (let ((lines (mapcar (make-instance 'Node) (uiop:read-file-lines "input2"))))
      (print lines) )))

(defun part2 () 2)

(defun main () 
  (progn
    (part1)
    (part2) ))