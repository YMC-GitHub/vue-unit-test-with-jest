const path = require('path');
module.exports = {
    // tell Jest the project root dir
    rootDir: path.resolve(__dirname, '../../'),
    "moduleFileExtensions": [
        "js",
        // tell Jest to handle `*.vue` files
        "vue"
    ],
    "moduleNameMapper": {
        // support the same @ -> src alias mapping in source code
        '^@\/(.*?\.?(js|vue)?|)$': '<rootDir>/src/$1',
        // support mock load static file
        '\\.(jpg|jpeg|png|gif|eot|otf|webp|svg|ttf|woff|woff2|mp4|webm|wav|mp3|m4a|aac|oga)$': '<rootDir>/test/unit/__mocks__/fileMock.js',
        // support mock load style file
        '\\.(css|styl|less|sass|scss)$': '<rootDir>/test/unit/__mocks__/styleMock.js'
    },
    "transform": {
        // process `*.js` files with `babel-jest`
        "^.+\\.js$": "<rootDir>/node_modules/babel-jest",
        // process `*.vue` files with `vue-jest`
        ".*\\.(vue)$": "<rootDir>/node_modules/vue-jest"
    },
    "snapshotSerializers": [
        //for snapshot tests
        "<rootDir>/node_modules/jest-serializer-vue"
    ],
    //tell Jest  which file to test
    testMatch: [
        // match the test file
        '<rootDir>/test/unit/**/*.spec.js'
    ],
    testPathIgnorePatterns: [
    ],
    //tell Jest where to save coverage test ouput
    coverageDirectory: '<rootDir>/test/unit/coverage',
    //tell Jest which file to coverage test
    collectCoverageFrom: [
        // 'src/components/**/*.(js|vue)',
        'src/components/*.(vue)',
        '!src/main.js',
        '!**/node_modules/**'
    ]
}