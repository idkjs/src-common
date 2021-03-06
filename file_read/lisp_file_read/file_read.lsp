(defun file_read_old(ifname)
  ;(format t "example_function(~A)=<~A>~%" 1 (example_function 1))
  (with-open-file (stream ifname)
    (do ((line (read-line stream nil)
      (read-line stream nil)))
      ((null line))
      (format t "line=<~s>~%" line)
    )
)

  (with-open-file (stream ifname)
    (do ((char (read-char stream nil)
      (read-char stream nil)))
      ((null char))
      (print char))
  )
)

(defun file_read(ifname)
  (with-open-file (stream ifname)
    (loop for line = (read-line stream nil)
      while line
      collect line
    )
  )
)

(defun main()
  ;(trace file_read_old)
  ;(file_read_old "input.txt")
  ;(print (file_read "input.txt"))
  (format t "data=~s>~%" (file_read "input.txt"))
)

(main)
(exit)
