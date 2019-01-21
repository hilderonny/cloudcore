# arrange

## Usage

Installation is done in that way.

```
npm i --save @hilderonny/arrange
```

Create an ```index.js``` file with the following content.

```js
const arrange = require('@hilderonny/arrange');
const server = new arrange.Server(
    process.env.PORT || 8080, 
    process.env.DBURL || '127.0.0.1:27017/mydatabase',
    process.env.USECORS || true,
    process.env.TOKENSECRET || 'mytokensecret'
);
server.start();
```

Run the server with

```
node index.js
```

## Howto create NPM package

```
npm install npm@latest -g
npm init --scope=@hilderonny
npm adduser
npm publish --access public
```

For all following deployments to NPM you need to update the version in the ```package.json``` file and run ```npm publish```.

In dependent projects the lib can be updated to the newest version with ```npm up```.

## Links

* [Creating Node.js modules](https://docs.npmjs.com/creating-node-js-modules)
* [Before publishing to NPM](https://docs.npmjs.com/misc/developers#before-publishing-make-sure-your-package-installs-and-works)