Semantics = require './main'

tr = new Semantics('en-US', {
    'en-US':
        'greet': (name) ->
            "Hello, #{name ? "user"}!"
})

console.log tr 'greet'
