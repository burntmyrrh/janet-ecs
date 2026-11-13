(defn create-world
  "creates and returns a new world"
  []
  @{})

(defn create-entity
  "creates and returns a new entity"
  [world]
  (let [id (length world)]
    (get (put world id @{:id id}) id)))

(defn alive?
  "check if a given entity is alive in a world"
  [world entity]
  (truthy? (get world (get entity :id))))

(defn kill-entity
  "kills a given entity of a world"
  [world entity]
  (put world (get entity :id) nil))

# TODO: change is so that you can do `ecs/add-components e :health 10` instead
# ... change to varargs then from-pairs https://janet-lang.org/api/misc.html#from-pairs
(defn add-components
  "add given component to an entity of a world"
  [entity components]
  (eachp [_ component] (pairs components) (put entity (first component) (last component))))

(defn remove-components
  "removes an array of component keys from a given entity"
  [entity & component-keys]
  (each key component-keys (put entity key nil)))

(defn query
  ``
  queries a world with given components based on a mode
  returns a list of entities that match the given criteria
  
  current modes supported:
    `:any` matches any entities with given components
    `:all` matches all entities with given components
  ``
  [world mode & components]

  #  TODO: can a fn be extracted here? yes. but how would I support `:one` then
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

(defn tick
  "calculates a world tick with the given tick-based systems"
  [world tick-systems]
  (each system tick-systems (eval (system world))))
