x: 1
y: {}
y.x: -> 3

print x is 1
print typeof(y.x) is 'function'
print y.x() is 3
print y.x.name is 'x'


# The empty function should not cause a syntax error.
->


obj: {
  name: "Fred"

  bound: ->
    (=> print(this.name is "Fred"))()

  unbound: ->
    (-> print(!this.name?))()
}

obj.unbound()
obj.bound()


# The named function should be cleared out before a call occurs:

# Python decorator style wrapper that memoizes any function
memoize: (fn) ->
  cache: {}
  self: this
  (args...) ->
    key: args.toString()
    return cache[key] if cache[key]
    cache[key] = fn.apply(self, args)

Math: {
  Add: (a, b) -> a + b
  AnonymousAdd: ((a, b) -> a + b)
  FastAdd: memoize (a, b) -> a + b
}

print Math.Add(5, 5) is 10
print Math.AnonymousAdd(10, 10) is 20
print Math.FastAdd(20, 20) is 40


# Parens are optional on simple function calls.
print 100 > 1 if 1 > 0
print true unless false
print true for i in [1..3]

print_func: (f) -> print(f())
print_func -> true

# Optional parens can be used in a nested fashion.
call: (func) -> func()

result: call ->
  inner: call ->
    Math.Add(5, 5)

print result is 10


# And even with strange things like this:

funcs:  [(x) -> x, (x) -> x * x]
result: funcs[1] 5

print result is 25

result: ("hello".slice) 3

print result is 'lo'