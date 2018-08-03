# ========================================
# Class Semantics
class Semantics extends Function
    constructor: ->
        #! `this` is the bound function
        #! Let this.me = bound, or `this.me = this`
        #! Workaround for `this` to be called properly
        super("return this.get.apply(this.me, arguments)")
        bound = @bind @
        [bound.me, @me, bound.tr] = [bound, bound, {}]
        Semantics::add.apply bound, arguments
        Object.setPrototypeOf(bound, Semantics::)
        return bound

    get: (key, args...) ->
        #! Main function, use this.me instead of this,
        #! bound functions mess up `this`
        key = String key
        h = @tr[@l][key]
        switch
            when not h? then key
            when typeof h is "function" then h(args...)
            else h

    add: (dictionaries) ->
        for language, dictionary of dictionaries
            if not @tr[language]?
                @tr[language] = dictionary
            else
                for key, translation of dictionary
                    @tr[language][key] = translation
        @

    setLanguage: (@l) ->

# ---

tr = new Semantics({
    "en": {
        "Hello": "Hello"
        "Yes": "Yes"
        "No": "No"
    }
    "es": {
        "Hello": "Hola"
        "Yes": "Sí"
        "No": "No"
    }
    "fr": {
        "Hello": "Bonjour"
        "Yes": "Oui"
        "No": "Non"
    }
    "ja": {
        "Hello": "こんにちは"
        "Yes": "はい"
        "No": "いいえ"
    }
})
tr.setLanguage('ja')
console.log tr('Hello')

#! ========================================
#! Export
if this is window?
    #! Probably browser
    window["Semantics"] = Semantics
else
    #! Probably node
    module.exports = Semantics
