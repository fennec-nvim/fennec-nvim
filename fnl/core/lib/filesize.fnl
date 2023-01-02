(local si {:bits [:b :Kb :Mb :Gb :Tb :Pb :Eb :Zb :Yb]
           :bytes [:B :KB :MB :GB :TB :PB :EB :ZB :YB]})

(fn is-nan [num]
  (not= num num))

(fn round-number [num digits]
  (let [fmt (.. "%." digits :f)]
    (tonumber (fmt:format num))))

(fn filesize [size options]
  (let [o {}]
    (each [key value (pairs (or options {}))]
      (tset o key value))

    (fn set-default [name default]
      (when (= (. o name) nil)
        (tset o name default)))

    (set-default :bits false)
    (set-default :unix false)
    (set-default :base 2)
    (set-default :round (or (and o.unix 1) 2))
    (set-default :spacer (or (and o.unix "") " "))
    (set-default :suffixes {})
    (set-default :output :string)
    (set-default :exponent (- 1))
    (assert (not (is-nan size)) "Invalid arguments")
    (local ceil (or (and (> o.base 2) 1000) 1024))
    (local negative (< size 0))
    (when negative
      (set-forcibly! size (- size)))
    (var result nil)
    (if (= size 0)
        (set result [0 (or (and o.unix "") (or (and o.bits :b) :B))])
        (do
          (when (or (= o.exponent (- 1)) (is-nan o.exponent))
            (set o.exponent (math.floor (/ (math.log size) (math.log ceil)))))
          (when (> o.exponent 8)
            (set o.exponent 8))
          (var val nil)
          (if (= o.base 2) (set val (/ size (math.pow 2 (* o.exponent 10))))
              (set val (/ size (math.pow 1000 o.exponent))))
          (when o.bits
            (set val (* val 8))
            (when (> val ceil)
              (set val (/ val ceil))
              (set o.exponent (+ o.exponent 1))))
          (set result [(round-number val (or (and (> o.exponent 0) o.round) 0))
                       (or (and (and (= o.base 10) (= o.exponent 1))
                                (or (and o.bits :kb) :kB))
                           (. (. si (or (and o.bits :bits) :bytes))
                              (+ o.exponent 1)))])
          (when o.unix
            (tset result 2 (: (. result 2) :sub 1 1))
            (when (or (= (. result 2) :b) (= (. result 2) :B))
              (set result [(math.floor (. result 1)) ""])))))
    (assert result)
    (when negative
      (tset result 1 (- (. result 1))))
    (tset result 2 (or (. o.suffixes (. result 2)) (. result 2)))
    (tset result 2 (or (. o.suffixes (. result 2)) (. result 2)))
    (if (= o.output :array) result (= o.output :exponent) o.exponent
        (= o.output :object) {:value (. result 1) :suffix (. result 2)}
        (= o.output :string)
        (do
          (var value (tostring (. result 1)))
          (set value (value:gsub "%.0$" ""))
          (local suffix (. result 2))
          (.. value o.spacer suffix)))))

{: filesize}
