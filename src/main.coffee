###
 * To compile, install coffeescript and run the following command:
 * coffee -o dist/ -cw src/
###

#! The Semantics class
class Semantics
    constructor: ->
        @values = {}
        @plurals = {}
        @options = {
            escapeHTML: yes
        }
        Semantics::add.apply this, arguments


#! ========================================
#! Helpers
Semantics.deepVal = (obj, path) ->
    #! Given an object and path as a string (ex, "foo/bar/baz"),
    #! return that object's property. (ex, obj.foo.bar.baz)
    # Removes the beginning/ending slashes in the path
    path = path.replace /(^\/)|(\/$)/, ''
    path = path.split '/'
    l = path.length
    for folder in path
        try
            obj = obj[folder]
        catch
            return undefined
    return obj

#! ========================================
#! Prototype
Semantics::get = (path, args...) ->
    #! Returns the translation at `path`
    translation = Semantics.deepVal(@values, path)
    if typeof translation is "function"
        translation(args...)
    else
        translation

Semantics::plural = (quantity, key, args...) ->
    #! Add plural rules
    if typeof @plurals[key] is "function"
        @plurals[key](quantity, args...)
    else if typeof @values[key] isnt "undefined"
        @plurals[key]
    else
        null

Semantics::add = (translations = {}) ->
    #! Add translations
    for key, val of translations['values']
        @values[key] = val

    #! Add plural rules
    for key, val of translations['plurals']
        @plurals[key] = val
    this

Semantics::setOption = (setting, value) ->
    if @options[setting]? then @options[setting] = value

#! ========================================
#! Export
if this is window?
    #! Probably browser
    window["Semantics"] = Semantics
else
    #! Probably node
    module.exports = Semantics
