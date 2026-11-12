(import ecs)

(defn print-1 [message] (printf " -> %s" message))

(print-1 "creating world...")
(def world (ecs/create-world))

(print-1 "creating player...")
(def player (ecs/create-entity world))

(print-1 "adding health (10) component to player...")
(ecs/add-components player @{:health 10})

(print-1 "adding 10 health to player...")
(update player :health + 10)

(assert (= 20 (get player :health)) "player should have 20 health total")
(print-1 "player has correct health total (20)")

(print "")
