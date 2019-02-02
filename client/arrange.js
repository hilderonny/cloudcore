let $arr = {

    currentuser: {
        _id: undefined,
        token: undefined
    },

    helper: {
        delete: async function(url, token) {
            return $arr.helper.request('DELETE', url, token);
        },
        get: async function(url, token) {
            return $arr.helper.request('GET', url, token);
        },
        post: async function post(url, token, data) {
            return $arr.helper.request('POST', url, token, data);
        },
        request: async function(mode, url, token, data) {
            return new Promise(function(resolve) {
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4) {
                        const result = this.responseText ? JSON.parse(this.responseText) : undefined;
                        resolve(result);
                    }
                };
                xmlhttp.open(mode, url);
                if (token) {
                    xmlhttp.setRequestHeader('x-access-token', token);
                }
                if (mode === 'POST' && data) {
                    xmlhttp.setRequestHeader('Content-Type', 'application/json');
                    xmlhttp.send(JSON.stringify(data));
                } else {
                    xmlhttp.send();
                }
            });
        }
    },

    addreadableby: async function(tablename, entityid, userid) {
        return $arr.helper.post('/api/arrange/addreadableby/' + tablename + '/' + entityid, currentuser.token, { userid: userid });
    },
    addwritableby: async function(tablename, entityid, userid) {
        return $arr.helper.post('/api/arrange/addwritableby/' + tablename + '/' + entityid, currentuser.token, { userid: userid });
    },
    delete: async function(tablename, entityid) {
        return $arr.helper.delete('/api/arrange/delete/' + tablename + '/' + entityid, currentuser.token);
    },
    details: async function(tablename, entityid, attributefilter) {
        return $arr.helper.post('/api/arrange/details/' + tablename + '/' + entityid, currentuser.token, attributefilter);
    },
    list: async function(tablename, queryfilter) {
        return $arr.helper.post('/api/arrange/list/' + tablename, currentuser.token, queryfilter);
    },
    listusers: async function() {
        return $arr.helper.get('/api/arrange/listusers', currentuser.token);
    },
    login: async function(username, password) {
        return $arr.helper.post('/api/arrange/login', undefined, { username: username, password: password });
    },
    register: async function(username, password) {
        return $arr.helper.post('/api/arrange/register', undefined, { username: username, password: password });
    },
    removereadableby: async function(tablename, entityid, userid) {
        return $arr.helper.post('/api/arrange/removereadableby/' + tablename + '/' + entityid, currentuser.token, { userid: userid });
    },
    removewritableby: async function(tablename, entityid, userid) {
        return $arr.helper.post('/api/arrange/removewritableby/' + tablename + '/' + entityid, currentuser.token, { userid: userid });
    },
    save: async function(tablename, entity) {
        return $arr.helper.post('/api/arrange/save/' + tablename, currentuser.token, entity);
    },
    setpassword: async function(newpassword) {
        return $arr.helper.post('/api/arrange/setpassword', currentuser.token, { password: newpassword });
    },
    setpubliclyreadable: async function(tablename, entityid, readable) {
        return $arr.helper.post('/api/arrange/setpubliclyreadable/' + tablename + '/' + entityid + '/' + (readable ? 'true' : 'false'), currentuser.token);
    },
    setpubliclywritable: async function(tablename, entityid, writable) {
        return $arr.helper.post('/api/arrange/setpubliclywritable/' + tablename + '/' + entityid + '/' + (writable ? 'true' : 'false'), currentuser.token);
    },
    transferownership: async function(tablename, entityid, newuserid) {
        return $arr.helper.post('/api/arrange/transferownership/' + tablename + '/' + entityid + '/' + newuserid, currentuser.token);
    }

};