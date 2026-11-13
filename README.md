# `janet-ecs`

simple and readable ECS (entity-component-system) library for the janet language. no dependencies! so small you can embed the code!

## planned features

- [X] create, read and delete entities
- [X] create, read, update and delete components
- [X] simple queries for systems
- [X] more complex and ergonomic queries for systems
- [ ] type assertion

## quick example

for more examples, check out [the tests](./test)

```janet
(import ecs)

# systems are just janet functions!
# every tick-based system requires this signature
# everything can be accessed through the `world`
(defn damage-over-time 
  "applies a damage over time to all entities alive"
  [world]
  (def bodies (ecs/query world :any :health))
  (each body bodies (update body :health - 1)))

(defn kill-dead
  "kills off dead (`:health` equals to `0`) entities"
  [world]
  (def bodies (ecs/query world :any :health))
  (each body bodies (when (>= 0 (get body :health)) (ecs/kill-entity world body))))

(def tick-systems @[damage-over-time kill-dead])

# this creates the world
# you control how this is shared across your application
# since this library isn't ready for concurrency yet, it expects to run on a single thread
(def world (ecs/create-world))

(def player (ecs/create-entity world)) # `ecs/create-entity` returns an identifier
(ecs/add-components player @{:health 2})

(ecs/tick world tick-systems)
# after this first tick, the `player` will have `:health 1`

(ecs/tick world tick-systems)
# after this tick, the `player` will temporarily have `:health 0`
# after `damage-over-time` is finished, `kill-dead` will be triggered
```

## installation

assuming an Unix system and `janet-pm` installed;

```shell
git clone https://github.com/burntmyrrh/janet-ecs
cd janet-ecs
janet-pm install
```

that's it! start a REPL with `janet -l ecs` or run `(import ecs)` inside of it

## license

[GNU General Public License v3.0](COPYING)
