# Semantics

<!--
  TODO: Add the following:
    - [x] Summary / Overview
    - [x] Installation
    - [x] Basic usage / Example
    - [ ] API Docs
    - [ ] Related resources
    - [ ] Link to contributor info
    - [ ] Tests
    - [x] License
-->

Semantics is a simple yet powerful i18n library for JavaScript, built for both Node and the web.

> **Note:** Semantics is in v0; it should not be considered stable.

## Installation

### Node
```bash
npm i semantics-i18n
```
```js
const Semantics = require('semantics-i18n');
```

### Browser
```html
<script src="path/to/semantics.js"></script>
<!-- Semantics will be declared as a global object -->
```

## Basic usage
```js
var $ = Semantics('es', {
    "values": {
        "Hello": "Hola",
        "Yes": "Sí",
        "No": "No",
        "Maybe": "Tal vez"
    }
});

$('Hello'); // "Hola"
```

[Take a look at the examples][examples].

## License
[MIT License][license]

[examples]: https://github.com/MindfulMinun/Semantics/tree/master/src/demo.coffee
[license]: https://github.com/MindfulMinun/Semantics/blob/master/LICENSE
