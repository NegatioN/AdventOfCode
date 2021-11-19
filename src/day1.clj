(ns day1
    (:require [clojure.java.io :as io]
      [clojure.string :as str]))
(def myData [1721 979 366 299 675 1456])

(defn find-and-mul [target data] (for [i data j data
                                        :when (= target (+ i j))]
                                    (* i j) )
                                  )
(find-and-mul 2020 myData)

(for [i myData
      j myData
      y myData
      :when (= 2020 (+ i j y))]
  (* i j y) )
