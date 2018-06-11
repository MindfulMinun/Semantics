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
```

## Basic usage
```js
var es = new Semantics({
    "Hello": "Hola",
    "Yes": "Sí",
    "No": "No",
    "Maybe": "Tal vez"
});

es.get('Hello'); // "Hola"
```

## License
[MIT License](./LICENSE)
