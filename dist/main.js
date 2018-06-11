// Generated by CoffeeScript 2.3.1
(function() {
  /*
   * To compile, install coffeescript and run the following command:
   * coffee -o dist/ -cw src/
   */
  var Semantics;

  //! The Semantics constructor function
  Semantics = function() {
    this.$values = {};
    this.$plurals = {};
    this.$options = {
      escapeHTML: true
    };
    Semantics.prototype.add.apply(this, arguments);
  };

  //! ========================================
  //! Helpers
  Semantics.deepVal = function(obj, path) {
    var folder, i, l, len;
    //! Given an object and path as a string (ex, "foo/bar/baz"),
    //! return that object's property. (ex, obj.foo.bar.baz)
    path = path.replace(/^\//, ''); // Removes the beginning slash in the path
    path = path.replace(/\/$/, ''); // Removes the trailing slash in the path
    path = path.split('/');
    l = path.length;
    for (i = 0, len = path.length; i < len; i++) {
      folder = path[i];
      try {
        obj = obj[folder];
      } catch (error) {
        return void 0;
      }
    }
    return obj;
  };

  //! ========================================
  //! Prototype
  Semantics.prototype.get = function(path, ...args) {
    var translation;
    //! Returns the translation at `path`
    translation = Semantics.deepVal(this.$values, path);
    if (typeof translation === "function") {
      return translation(...args);
    } else {
      return translation;
    }
  };

  Semantics.prototype.pluralize = function(quantity, key, ...args) {
    //! Add plural rules
    if (typeof this.$plurals[key] === "function") {
      return this.$plurals[key](quantity, ...args);
    } else if (typeof this.$values[key] !== "undefined") {
      return this.$plurals[key];
    } else {
      return null;
    }
  };

  Semantics.prototype.add = function(translations) {
    var key, ref, ref1, val;
    ref = translations['values'];
    //! Add translations
    for (key in ref) {
      val = ref[key];
      if (this.$values[key]) {
        console.log(`Translation “${key}” already defined as “${this.$values[key]}”, replacing with “${val}”.`);
      }
      this.$values[key] = val;
    }
    ref1 = translations['plurals'];
    for (key in ref1) {
      val = ref1[key];
      if (this.$plurals[key]) {
        console.log(`Plural rule “${key}” already defined as “${this.$plurals[key]}”, replacing with “${val}”.`);
      }
      this.$plurals[key] = val;
    }
    return this;
  };

  Semantics.prototype.setOption = function(setting, value) {
    if (this.$options[setting] != null) {
      return this.$options[setting] = value;
    }
  };

  //! ========================================
  //! Export
  if ((typeof module !== "undefined" && module !== null ? module.exports : void 0) != null) {
    //! Probably node
    module.exports = Semantics;
  } else {
    //! Probably browser
    window["Semantics"] = Semantics;
  }

}).call(this);