# ========================================
# Class Semantics
class Semantics extends Function
    constructor: (defaultLang, dictionaries) ->
        #! `this` is the bound function
        #! Let this.me = bound, or `this.me = this`
        #! Workaround for `this` to be called properly
        super("return this.get.apply(this.me, arguments)")
        bound = @bind @
        [bound.me, @me, bound.translations] = [bound, bound, {}]
        bound.lang = (
            if typeof defaultLang is "string" then defaultLang else "en"
        )

        Semantics::add.call bound, dictionaries
        Object.setPrototypeOf(bound, Semantics::)
        return bound

    get: (key, args...) ->
        key = String key
        h = @translations[@lang]?[key]
        switch
            when not h? then throw Error "Key “#{key}” not found
                in language “#{@lang}”."
            when typeof h is "function" then h(args...)
            else h

    add: (dictionaries) ->
        @translations = Object.assign @translations, dictionaries
        @

    setLanguage: (@lang) ->

#! ========================================
#! Export
if this is window?
    #! Probably browser
    window["Semantics"] = Semantics
else
    #! Probably node
    module.exports = Semantics
