# Examples

First, let’s import Semantics.

    Semantics = require '../main.js'

One way to retrieve translations is by keeping them in another file,
and `require`ing them when we need to. This way, translations will
be easier to maintain in the long run.

    es = new Semantics require './es.js'

Of course, translations can be added to any Semantics instance
at any time by calling `<instance>.add()`, and passing the
translations as an argument.

But what do these translations look like? They’re essentially a
JavaScript object.

    translations =
        "values":
            "Hello": "Hola"
            "Yes": "Sí"
            "No": "No"
            "Cancel": "Cancelar"

Translations are stored in the `values` property of the main object.
As mentioned previously, we can add these translations by calling
`.add()`. See `es.litcoffee` for more examples on structuring translations.

    es.add(translations)

To retrieve these translations, all we need to do is call `.get()`,
passing the key as the first argument.

    console.log es.get "Hello" # -> "Hola"

Language isn’t always simple and straightforward, not every language
has a 1-to-1 equivalent translation. That’s why you can also pass
functions to aid with translations.

    es.add {
        "values":
            "welcome": (user) ->
                if user.gender is "female"
                    "Bienvenida, #{user.name}."
                else
                    "Bienvenido, #{user.name}."
    }

These functions can be called by calling `.get` as you normally would.
Arguments after the translation key will be passed to the translation
function.

    console.log es.get "welcome", {name: "María", gender: "female"}
    console.log es.get "welcome", {name: "Diego", gender: "male"}
    # -> Bienvenida, María.
    # -> Bienvenido, Diego.


## Pluralization

Semantics not only supports translations, but also pluralization.
Plural rules are added to the `plurals` key instead of the `values`
key.

Plural rules function similarly to regular translations,
except that the order of arguments is a bit different.
Take a look at the following example.

    es.add {
        "plurals":
            "newMessages": (count, args...) ->
                switch count
                    when 0 then "No tienes mensajes nuevos."
                    when 1 then "Tienes un mensaje nuevo."
                    else "Tienes #{count} mensajes nuevos."
    }

To pluralize something, we call the `.plural` function.

    console.log es.plural 3, "newMessages"
    console.log es.plural 1, "newMessages"
    console.log es.plural 0, "newMessages"
    # -> Tienes 3 mensajes nuevos.
    # -> Tienes un mensaje nuevo.
    # -> No tienes mensajes nuevos.

You might notice that, unlike the `get` function, the arguments in
the plural function are reversed. Its syntax goes as such:

```coffee
lang.plural(count, key, args...)
```

This makes for more natural sounding pluralization, such as `5, "eggs"`

    es.add {
        "plurals":
            "eggs": (count) ->
                if count is 1 then "Un huevo" else "#{count} huevos"
    }
    console.log es.plural 5, "eggs"
