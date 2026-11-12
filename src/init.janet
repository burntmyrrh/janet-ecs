(defn create-world []
  "creates and returns a new world"
  @{})

(defn create-entity [world]
  "creates and returns a new entity"
  (def id (length world))
  (get (put world id @{:id id}) id))

(defn alive? [world entity]
  "check if a given entity is alive in a world"
  (truthy? (get world (get entity :id))))

(defn kill-entity [world entity]
  "kills a given entity of a world"
  (put world (get entity :id) nil))

(defn add-components [entity components]
  "add given component to an entity of a world"
  (eachp [_ component] (pairs components) (put entity (first component) (last component))))

# TODO: varargs
(defn remove-components [entity component-keys]
  "removes an array of component keys from a given entity"
  (each key component-keys (put entity key nil)))

#  TODO: add `:one`, `:any`, `:all` instead
#  (defn query [world components mode])

(defn query-component [world component-key]
  "query world for entities with component"
  (filter |(has-key? $ component-key) (values world)))

(defn query-components [world component-keys]
  "query world for entities with given components"
  (filter
    (fn [e]
      (any? (map
              (fn [c]
                (has-key? e c))
              component-keys)))
    (values world)))

(defn tick [world tick-systems]
  "calculates a world tick with the given tick-based systems"
  (each system tick-systems (eval (system world))))
