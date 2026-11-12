(import ecs)

(defn print-1 [message] (printf " -> %s" message))

(print-1 "creating world...")
(def world (ecs/create-world))
(assert (= 0 (length world)) "the length of an empty world should be 0")

(print-1 "creating player...")
(def player (ecs/create-entity world))
(assert (= 0 (get player :id)) "id of first entity should be 0")
(print-1 "player has correct id")

(assert (= 1 (length world)) "the length of the world after adding an entity should be 1")
(print-1 "world has correct length")

(assert (ecs/alive? world player))
(print-1 "player is alive")

(print-1 "killing player...")
(ecs/kill-entity world player)
(assert (not (ecs/alive? world player)))
(print-1 "player isn't alive")

(print "")
