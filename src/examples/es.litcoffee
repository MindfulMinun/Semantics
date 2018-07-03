# Translation File example

I believe the best way of managing translation files is by importing
them with a `require` statement. Nevertheless, these files aren’t
JSON files but instead JavaScript files, giving us the ability to
use complex logic.

Let’s create an object to attach our translations to.
This object will end up being exported via `module.exports`.

    #! Add translations here
    translations = {}

Regular translations must be added to the `values` property of the
main object. Consider the following.

    translations =
        "values":
            "Hello": "Hola"

Say this object were to be exported. Calling `es.get('Hello')`
would return the string `"Hola"`. More translations can be added
in this fashion.

    translations =
        "values":
            "Hello": "Hola"
            "Yes": "Sí"
            "No": "No"
            "Cancel": "Cancelar"

Likewise, these translations can be retrieved with
`"Hello"`, `"Yes"`, `"No"`, and `"Cancel"` respectively.

Of course, these keys don't have to be the translation itself,
keys may very well be something similar to this:

    translations =
        "values":
            "offline": "No hay conexión a Internet. Por favor,
                verifique la conexión, e inténtalo de nuevo."

This way, you can simply call `lang.get('offline')` instead of
`lang.get("There's no Internet connection. Please double-check the
connection and try again")`.



To export our translations, just attach them to the `module.exports`
object.

    module.exports = translations
