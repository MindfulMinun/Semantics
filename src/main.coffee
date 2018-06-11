###
 * To compile, install coffeescript and run the following command:
 * coffee -o dist/ -cw src/
###

#! The Semantics constructor function
Semantics = ->
    @$values = {}
    @$plurals = {}
    @$options = {
        escapeHTML: yes
    }
    Semantics::add.apply this, arguments
    return

#! ========================================
#! Helpers
Semantics.deepVal = (obj, path) ->
    #! Given an object and path as a string (ex, "foo/bar/baz"),
    #! return that object's property. (ex, obj.foo.bar.baz)
    path = path.replace /^\//, '' # Removes the beginning slash in the path
    path = path.replace /\/$/, '' # Removes the trailing slash in the path
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
    translation = Semantics.deepVal(@$values, path)
    if typeof translation is "function"
        translation(args...)
    else
        translation

Semantics::pluralize = (quantity, key, args...) ->
    #! Add plural rules
    if typeof @$plurals[key] is "function"
        @$plurals[key](quantity, args...)
    else if typeof @$values[key] isnt "undefined"
        @$plurals[key]
    else
        null

Semantics::add = (translations) ->
    #! Add translations
    for key, val of translations['values']
        if @$values[key]
            console.log "Translation “#{key}” already defined as
                “#{@$values[key]}”, replacing with “#{val}”."
        @$values[key] = val

    for key, val of translations['plurals']
        if @$plurals[key]
            console.log "Plural rule “#{key}” already defined as
                “#{@$plurals[key]}”, replacing with “#{val}”."
        @$plurals[key] = val
    return @

Semantics::setOption = (setting, value) ->
    if @$options[setting]? then @$options[setting] = value

#! ========================================
#! Export
if module?.exports?
    #! Probably node
    module.exports = Semantics
else
    #! Probably browser
    window["Semantics"] = Semantics
