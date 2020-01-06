# vue-unit-test-with-jest

### desc

test vue unit with jest

note: you can also test your project with [Vue CLI 3](https://cli.vuejs.org/)

### project diretory constructor

get detail [here](./note/dir-construtor.md)

### some deps for test

- `vue-test-utils` (test vue with offical tool)
- `jest` (test with jest framework)
- `babel-jest` (for ES2015+ features in tests)
- `vue-jest` (for handling `*.vue` files in tests)
- `jest-serializer-vue` (for snapshot tests)

### some config

#### `jest.config.js`

01.tell Jest to handle `*.vue` files ([jest.config.js](./test/unit/jest.config.js#L7))

02.tell Jest to process `*.vue` files with `vue-jest` ([jest.config.js](./test/unit/jest.config.js#L22))

03.tell Jest to snapshot tests for vue ([jest.config.js](./test/unit/jest.config.js#L26))

04.tell Jest to handle `*.js` files ([jest.config.js](./test/unit/jest.config.js#L6))

05.tell Jest to process `*.js` files with `babel-jest` ([jest.config.js](./test/unit/jest.config.js#L20))

06.tell Jest to support the same `@` -> `src` alias mapping in source code ([jest.config.js](./test/unit/jest.config.js#L12))

07.tell Jest the project root dir ([jest.config.js](./test/unit/jest.config.js#L4))

08.tell Jest to support mock load static file ([jest.config.js](.t/est/unit/jest.config.js#L14))

09.tell Jest to support mock load style file ([jest.config.js](.t/est/unit/jest.config.js#L16))

10.tell Jest  which file to test ([jest.config.js](./test/unit/jest.config.js#L29-#34))

11.tell Jest where to save coverage test ouput ([jest.config.js](.t/est/unit/jest.config.js#L36))

12.tell Jest which file to coverage test ([jest.config.js](./test/unit/jest.config.js#L38-#L43))



#### `.babelrc`

Our default Babel config disables ES modules transpilation because webpack already knows how to handle ES modules(./.babelrc#L5). However, we do need to enable it for our tests because Jest tests are run directly in Node[.babelrc](./.babelrc#L13-#L20).

Also, if our tests are run in a relatively newer version of Node, most of the ES features are already supported - we can tell `babel-preset-env` to target the Node version we are using. This skips transpiling unnecessary features and makes our tests boot faster.

get detail on [.babelrc](./.babelrc#L17)

To apply these options only for tests, we need to add a separate config under `env.test` (this will be automatically picked up by `babel-jest`):

get detail on [.babelrc](./.babelrc#L11)


### Build Commands

``` bash
# install dependencies
npm install
#install tes deps (esstional)
#npm run install:tes
#npm run install:tes:unit
#install dev deps (optional)
#npm run install:dev
#install pro deps (optional)
#npm run install:pro

# dev serve with hot reload at localhost:8080 (optional)
npm run dev

# build for production with minification (optional)
npm run build

# run tests
npm run test 
#npm run test -- -u
#run unit test
npm run test:unit
#run unit test with coverage
npm run test:unit:with-coverage
```

### get more

For detailed explanation on how vue-test-utils work, consult the [docs for vue-test-utils](https://vue-test-utils.vuejs.org/guides/#testing-single-file-components-with-jest).

For detailed explanation on how jest work, consult the [docs for jest]().

For detailed explanation on how jest-babel work, consult the [docs for jest-babel]().

For detailed explanation on how vue-jest work, consult the [docs for vue-jest]().

For detailed explanation on how jest-serializer-vue work, consult the [docs for jest-serializer-vue]().


### author

yemiancheng <ymc-github@gmail.com>

### contributor

Evan You <yyx990803@gmail.com>

### License

MIT