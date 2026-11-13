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

(defn query [world mode & components]
  ```
  queries a world with given components based on a mode
  returns a list of entities that match the given criteria
  
  current modes supported:
    `:any` matches any entities with given components
    `:all` matches all entities with given components
  ```
  (match mode
    :any (filter
           (fn [entity]
             (any? (map
                     (fn [component]
                       (has-key? entity component)) components))) (values world))
    :all (filter
           (fn [entity]
             (every? (map
                       (fn [component]
                         (has-key? entity component)) components))) (values world))))

(defn tick [world tick-systems]
  "calculates a world tick with the given tick-based systems"
  (each system tick-systems (eval (system world))))
