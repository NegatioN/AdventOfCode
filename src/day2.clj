(ns day2)
(require '[clojure.pprint :refer [pprint pp]])
;1-3 a: abcde
;1-3 b: cdefg
;2-9 c: ccccccccc

(defn validate [low high target password] ( (get (frequencies password) target 0) ))
(validate 1 5 "a" "abcde")
(get (frequencies "abcde") "a" 0)
(zipmap (vec (str "abcde")) (repeat 0))

(pprint "yolo")
(pp)

(loop [i 0] (if (< i 10) (recur (inc i)) i))