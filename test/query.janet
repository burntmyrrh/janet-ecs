(import ecs)

(defn print-1 [message] (printf " -> %s" message))

(print-1 "creating world...")
(def world (ecs/create-world))

(print-1 "creating player...")
(def player (ecs/create-entity world))
(ecs/add-components player @{:name "hero" :health 10})

(print-1 "creating monster...")
(def monster (ecs/create-entity world))
(ecs/add-components monster @{:name "evil monster" :health 10})

(print-1 "creating sword...")
(def sword (ecs/create-entity world))
(ecs/add-components sword @{:name "steel sword" :damage 2})

(assert (= 2 (length (ecs/query world :all :health))) "should have two entities with health")
(assert (= 2 (length (ecs/query world :all :health :name))) "should have two entities with health and name")

(print-1 "successfully queried two entities with health and one with damage components")

(print "")
