# Arrange client library

To use the arrange library, create a HTML file with the following content.

```html
<html>
    <head>
        <script src="/arrange/arrange.js"></script>
        <script>

            // To connect to a different server, use const arrange = Arrange('https://mydomain.com')
            const arrange = Arrange();

            // Now you can access arrange functions via the $arr object
            window.addEventListener('load', async function() {
                // Create arrange instance connected to the local server
                // Login to arrange
                await arrange.login('myusername', 'password');
                // Fetch a list of all entities of the "models" table
                let modellist = await arrange.list('models');
            });

        </script>
    </head>
</html>
```

After that you can use the ```arrange``` variable to call to the Arrange based server. In the following the API calles are described.

## addreadableby(tablename, entityid, userid)
```js
const result = await arrange.addreadableby('models', entity._id, user._id);
// Check result.error for error details. On success result.error is undefined.
```
## addwritableby(tablename, entityid, userid)
```js
const result = await arrange.addwritableby('models', entity._id, user._id);
// Check result.error for error details. On success result.error is undefined.
```
## delete(tablename, entityid)
```js
const result = await arrange.delete('models', entity._id);
// Check result.error for error details. On success result.error is undefined.
```
## details(tablename, entityid, attributefilter)
```js
// Request only attribute1 and attribute2 from entity
const attributefilter = { attribute1: true, attribute2: true };
const entity = await arrange.details('models', entityid, attributefilter);
// entitiy._id, entity.attribute1 and entity.attribute2 are set here
```
## list(tablename, queryfilter)
```js
// Request entities where the attribute "attribute" has the value "value1"
const queryfilter = { attribute1: 'value1' };
// Return only the "attribute1" and "attribute2" attributes
const resultfilter = { attribute1: true, attribute2: true };
const entities = await arrange.list('models', { query: queryfilter, result: resultfilter });
// The result will be an array of matching entities having only the given attributes (plus the _id attribute)
```
## listusers()
```js
const users = await arrange.listusers();
// users is an array of user objects containing _id and username of all existing users
```
## login(username, password)
```js
const user = await arrange.login('myusername', 'mypassword');
// Returned user contains _id, username and token or is undefind on failure
```
## register(username, password)
```js
const user = await arrange.register('myusername', 'mypassword');
// User is getting registered and logged in immediately
// Returned user contains _id, username and token or is undefind on failure
```
## removereadableby(tablename, entityid, userid)
```js
const result = await arrange.removereadableby('models', entity._id, user._id);
// Check result.error for error details. On success result.error is undefined.
```
## removewritableby(tablename, entityid, userid)
```js
const result = await arrange.removewritableby('models', entity._id, user._id);
// Check result.error for error details. On success result.error is undefined.
```
## save(tablename, entity)
```js
// Create a new entity by leaving out the _id attribute
const newentity = { attribute1: 'value1', attribute2: 'value2' };
const savedentity = await arrange.save('models', newentity); // savedentity now has the _id attribute set
// Update an existing entity by defining the _id attribute
const existingentity = { _id: entityid, attribute1: 'value1' };
await arrange.save('models', existingentity); // Only defined attributes will be updated
```
## setpassword(newpassword)
```js
// Works only after login and sets the password for the current user
const result = await arrange.setpassword('newpassword');
// Check result.error for error details. On success result.error is undefined.
```
## setpubliclyreadable(tablename, entityid, readable)
```js
// Making an entity publicly readable
const result = await arrange.setpubliclyreadable('models', entityid, true);
// Prevent an entity from being publicly readable
const result = await arrange.setpubliclyreadable('models', entityid, false);
// Check result.error for error details. On success result.error is undefined.
```
## setpubliclywritable(tablename, entityid, writable)
```js
// Making an entity publicly writable
const result = await arrange.setpubliclywritable('models', entityid, true);
// Prevent an entity from being publicly writable
const result = await arrange.setpubliclywritable('models', entityid, false);
// Check result.error for error details. On success result.error is undefined.
```
## transferownership(tablename, entityid, newuserid)
```js
// Only works when the logged in user is the owner of the target entity
const result = await arrange.transferownership('models', entityid, anotheruserid);
// Check result.error for error details. On success result.error is undefined.
```
