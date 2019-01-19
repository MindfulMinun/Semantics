Semantics = require '../src/main'
chai = require 'chai'
assert = chai.assert

describe "Semantics", ->
    describe "Constructor-thingy", ->
        it "should return a translator function", ->
            tr = Semantics()
            assert.isFunction tr
        it "no two Semantics instances should be the same", ->
            t1 = Semantics()
            t2 = Semantics()
            assert t1 isnt t2, "no two Semantics instances should be the same"
        it "if instanciated with a language and dict,
            it should work immediately", ->
            dict = values: hi: 'Hola'
            tr = Semantics('es', dict)
            assert.strictEqual tr('hi'), 'Hola'

    describe 'Semantics#setLang', ->
        it "should set the language if passed a string", ->
            l = 'en'
            tr = Semantics()
            assert.strictEqual tr.setLang(l), l
        it "should throw if the language isn't a string", ->
            l = ['not', {a: 'string'}]
            tr = Semantics()
            assert.throws (-> tr.setLang l), /to be of type string/i

    describe 'Semantics#addDict', ->
        it "shouldn't delete previous dicts (added via constructor)", ->
            dict = values: hi: 'Hola'
            tr = Semantics('es', dict)
            tr.addDict('es', values: yes: 'Sí')
            assert.strictEqual tr('hi'),  'Hola'
            assert.strictEqual tr('yes'), 'Sí'
        it "shouldn't delete previous dicts (added via multiple calls)", ->
            tr = Semantics('es')
            tr.addDict('es', values: hi: 'Hola')
            tr.addDict('es', values: yes: 'Sí')
            assert.strictEqual tr('hi'),  'Hola'
            assert.strictEqual tr('yes'), 'Sí'
