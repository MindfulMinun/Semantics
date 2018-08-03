Semantics = require '../dist/main.js'
chai = require 'chai'
assert = chai.assert

describe "Semantics", ->
    describe "Constructor", ->
        it "should be instanciated with a language", ->
            tr = new Semantics 'en-US', {'en-US': 'hi': 'Hello!'}
            assert.equal tr.lang, 'en-US'

        it "language should default to “en” if not provided", ->
            tr = new Semantics null, {'en': 'hi': 'Hello!'}
            assert.equal tr.lang, 'en'

        it "dictionary should be extended", ->
            tr = new Semantics 'en-US', {'en-US': 'hi': 'Hello!'}
