(import ecs)

(defn print-1 [message] (printf " -> %s" message))

(defn damage-over-time [world]
  "applies a damage over time to all entities alive"
  (def bodies (ecs/query-components world @[:health]))
  (each body bodies (update body :health - 1)))

(defn kill-dead [world]
  "kills off dead (`:health` equals to `0`) entities"
  (def bodies (ecs/query-components world @[:health]))
  (each body bodies (when (>= 0 (get body :health)) (ecs/kill-entity world body))))

(def tick-systems @[damage-over-time kill-dead])

(print-1 "creating world...")
(def world (ecs/create-world))

(print-1 "creating a player with 2 HP...")
(def player (ecs/create-entity world))
(ecs/add-components player @{:health 2})

(print-1 "dealing one damage to the player...")
(ecs/tick world tick-systems)
(assert (= 1 (get player :health)) "player should take tick-based system damage")

(print-1 "dealing one damage to the player...")
(ecs/tick world tick-systems)
(assert (= 0 (length world)) "player should have died to damage")
(print-1 "successfully killed the player")

(print "")
