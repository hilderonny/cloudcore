let $arr = {

    currentuser: {
        _id: undefined,
        password: undefined,
        username: undefined,
        token: undefined
    },

    helper: {
        delete: async function(url) {
            return $arr.helper.request('DELETE', url, $arr.currentuser.token);
        },
        get: async function(url) {
            return $arr.helper.request('GET', url, $arr.currentuser.token);
        },
        handleloginregister: function(username, password, response) {
            if (response.status === 200) {
                $arr.currentuser.password = password;
                $arr.currentuser.username = username;
                $arr.currentuser._id = response.body._id;
                $arr.currentuser.token = response.body.token;
                return true;
            }
            return false;
        },
        post: async function post(url, data) {
            return $arr.helper.request('POST', url, $arr.currentuser.token, data);
        },
        request: async function(mode, url, data) {
            return new Promise(function(resolve) {
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = async function() {
                    if (this.readyState == 4) {
                        const result = this.responseText ? JSON.parse(this.responseText) : undefined;
                        // Token expired, relogin and try again
                        if (this.status === 401 && result.error === 'Token cannot be validated') {
                            const loggedin = await $arr.login($arr.currentuser.username, $arr.currentuser.password);
                            if (loggedin) {
                                const result2 = await $arr.helper.request(mode, url, data);
                                resolve(result2);
                            } else {
                                resolve(undefined); // Read failed again even after relogin
                            }
                        } else {
                            resolve(result);
                        }
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
        return $arr.helper.post('/api/arrange/addreadableby/' + tablename + '/' + entityid, { userid: userid });
    },
    addwritableby: async function(tablename, entityid, userid) {
        return $arr.helper.post('/api/arrange/addwritableby/' + tablename + '/' + entityid, { userid: userid });
    },
    delete: async function(tablename, entityid) {
        return $arr.helper.delete('/api/arrange/delete/' + tablename + '/' + entityid);
    },
    details: async function(tablename, entityid, attributefilter) {
        return $arr.helper.post('/api/arrange/details/' + tablename + '/' + entityid, attributefilter);
    },
    list: async function(tablename, queryfilter) {
        return $arr.helper.post('/api/arrange/list/' + tablename, queryfilter);
    },
    listusers: async function() {
        return $arr.helper.get('/api/arrange/listusers');
    },
    login: async function(username, password) {
        const response = await $arr.helper.post('/api/arrange/login', { username: username, password: password });
        return $arr.helper.handleloginregister(username, password, response);
    },
    register: async function(username, password) {
        const response = $arr.helper.post('/api/arrange/register', { username: username, password: password });
        return $arr.helper.handleloginregister(username, password, response);
    },
    removereadableby: async function(tablename, entityid, userid) {
        return $arr.helper.post('/api/arrange/removereadableby/' + tablename + '/' + entityid, { userid: userid });
    },
    removewritableby: async function(tablename, entityid, userid) {
        return $arr.helper.post('/api/arrange/removewritableby/' + tablename + '/' + entityid, { userid: userid });
    },
    save: async function(tablename, entity) {
        return $arr.helper.post('/api/arrange/save/' + tablename, entity);
    },
    setpassword: async function(newpassword) {
        return $arr.helper.post('/api/arrange/setpassword', { password: newpassword });
    },
    setpubliclyreadable: async function(tablename, entityid, readable) {
        return $arr.helper.post('/api/arrange/setpubliclyreadable/' + tablename + '/' + entityid + '/' + (readable ? 'true' : 'false'));
    },
    setpubliclywritable: async function(tablename, entityid, writable) {
        return $arr.helper.post('/api/arrange/setpubliclywritable/' + tablename + '/' + entityid + '/' + (writable ? 'true' : 'false'));
    },
    transferownership: async function(tablename, entityid, newuserid) {
        return $arr.helper.post('/api/arrange/transferownership/' + tablename + '/' + entityid + '/' + newuserid);
    }

};