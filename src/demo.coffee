#* ======================================== *#
#* Usage

Semantics = require 'main'
$ = Semantics()

$.addDict 'es-US', {
    plurals: {
        people: (count, context...) ->
            switch count
                when 1 then "Una persona"
                else "#{count} personas"
    }
    values: {
        hi: (name) -> "¡Hola, #{name}!"
    }
}
$.addDict 'en-US', {
    plurals:
        people: (count, context...) ->
            switch count
                when 1 then "One person"
                else "#{count} people"
    values:
        hi: (name) -> "Hi, #{name}!"
}

console.log [
    $.setLang 'es-US' # Language set to Spanish
    $ 1, 'people'     # -> "Una persona"
    $ 2, 'people'     # -> "2 personas"
    $ 'hi', 'Alice'   # -> "¡Hola, Alice!"

    $.setLang 'es-US' # Language set to English
    $ 1, 'people'     # -> "One person"
    $ 2, 'people'     # -> "2 people"
    $ 'hi', 'Bob'     # -> "Hi, Bob!"
]
