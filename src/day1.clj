(ns day1
    (:require [clojure.java.io :as io]
      [clojure.string :as str]))
(def myData [1721 979 366 299 675 1456])

(for [i myData
      j myData
      :when (= 2020 (+ i j))]
  (* i j) )