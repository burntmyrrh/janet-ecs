(import ecs)

(defn print-1 [message] (printf " -> %s" message))

(print-1 "creating world...")
(def world (ecs/create-world))

(print-1 "creating player...")
(def player (ecs/create-entity world))

(print-1 "adding components to player...")
(ecs/add-components player @{:name "hero" :health 10 :mana 10})

(assert (has-key? player :name))
(assert (has-key? player :health))
(assert (has-key? player :mana))
(print-1 "player has added components")

(assert (= "hero" (get player :name)))
(assert (= 10 (get player :health)))
(assert (= 10 (get player :mana)))
(print-1 "player has correct values in added components")

(ecs/remove-component player :health)
(assert (has-key? player :name))
(assert (not (has-key? player :health)))
(assert (has-key? player :mana))
(print-1 "`ecs/remove-component` works correctly")

(ecs/remove-components player @[:name :mana])
(assert (not (has-key? player :name)))
(assert (not (has-key? player :health)))
(assert (not (has-key? player :mana)))
(print-1 "`ecs/remove-components` works correctly")

(print "")
