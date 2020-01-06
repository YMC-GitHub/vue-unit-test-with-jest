# project dir construtor

```
|--README.md #readme before
|--dist #build the source files,the output to here (for pro)
|--index.html #the html index file
|--node_modules #save project local deps here for npm
|--note #save my some note for the project
|--package-lock.json
|--package.json #use npm ,and it's description
|--src #save the source code (for dev)
|--test #save the test code (for tes)
|--webpack.config.js #build the source files with webpack,and it's config file
|--.babelrc #use babel to handle es6+,and it's config file
```

note:pro=production,dev=devlepment,tes=test

## test dir construtor

```
unit
|--jest.config.js #test with jest,and it's config file
|--__snapshots__ #save snapshots test ouput
|--__mocks__ #some mock handle file for jest test
```