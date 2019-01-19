Semantics = (language, dictionary) ->
    lang = (
        if typeof language is "string" then language else null
    )
    dict = {}
    if lang
        dict[lang] = {
            values: Object.assign({}, dictionary?.values)
            plurals: Object.assign({}, dictionary?.plurals)
        }

    S = ->
        if not dict?[lang]
            throw Error "Language `#{lang}` is not defined."

        switch typeof arguments[0]
            when "string"
                [key, context...] = arguments
                f = dict[lang].values[key]
                return (switch typeof f
                    when "function" then f(context...)
                    else f
                )
            when "number"
                [count, key, context...] = arguments
                f = dict[lang].plurals[key]
                return (switch typeof f
                    when "function" then f(count, context...)
                    else f
                )
            else throw Error "First argument isn't a string or number."

    S.setLang = (l) ->
        if typeof l is "string"
            lang = l
        else
            throw Error "Expected language to be of type string."
    S.addDict = (lang, dictionary) ->
        dict[lang] ?= {values: {}, plurals: {}}
        Object.assign dict[lang].values, dictionary?.values ? {}
        Object.assign dict[lang].plurals, dictionary?.plurals ? {}

    return S

# ========================================
# Export
if this is window?
    # Probably browser
    window["Semantics"] = Semantics
else
    # Probably node
    module.exports = Semantics
