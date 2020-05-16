--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: apps; Type: TABLE; Schema: public; Owner: cloudcore
--

CREATE TABLE public.apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    label text,
    userid uuid,
    ispublic boolean DEFAULT false,
    url text,
    description text
);


ALTER TABLE public.apps OWNER TO cloudcore;

--
-- Name: packageentities; Type: TABLE; Schema: public; Owner: cloudcore
--

CREATE TABLE public.packageentities (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tablename text,
    packageid uuid,
    entityid uuid
);


ALTER TABLE public.packageentities OWNER TO cloudcore;

--
-- Name: packagefields; Type: TABLE; Schema: public; Owner: cloudcore
--

CREATE TABLE public.packagefields (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    fieldname text,
    tablename text,
    packageid uuid
);


ALTER TABLE public.packagefields OWNER TO cloudcore;

--
-- Name: packages; Type: TABLE; Schema: public; Owner: cloudcore
--

CREATE TABLE public.packages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text,
    description text
);


ALTER TABLE public.packages OWNER TO cloudcore;

--
-- Name: packages_id_seq; Type: SEQUENCE; Schema: public; Owner: cloudcore
--

CREATE SEQUENCE public.packages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.packages_id_seq OWNER TO cloudcore;

--
-- Name: packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cloudcore
--

ALTER SEQUENCE public.packages_id_seq OWNED BY public.packages.id;


--
-- Name: routers; Type: TABLE; Schema: public; Owner: cloudcore
--

CREATE TABLE public.routers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    code text,
    url text,
    userid uuid,
    ispublic boolean DEFAULT false
);


ALTER TABLE public.routers OWNER TO cloudcore;

--
-- Name: routers_id_seq; Type: SEQUENCE; Schema: public; Owner: cloudcore
--

CREATE SEQUENCE public.routers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.routers_id_seq OWNER TO cloudcore;

--
-- Name: routers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cloudcore
--

ALTER SEQUENCE public.routers_id_seq OWNED BY public.routers.id;


--
-- Name: tabs; Type: TABLE; Schema: public; Owner: cloudcore
--

CREATE TABLE public.tabs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    url text,
    label text,
    appid uuid,
    userid uuid,
    ispublic boolean DEFAULT false
);


ALTER TABLE public.tabs OWNER TO cloudcore;

--
-- Name: tabs_id_seq; Type: SEQUENCE; Schema: public; Owner: cloudcore
--

CREATE SEQUENCE public.tabs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tabs_id_seq OWNER TO cloudcore;

--
-- Name: tabs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cloudcore
--

ALTER SEQUENCE public.tabs_id_seq OWNED BY public.tabs.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: cloudcore
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    username text,
    password text
);


ALTER TABLE public.users OWNER TO cloudcore;

--
-- Name: views; Type: TABLE; Schema: public; Owner: cloudcore
--

CREATE TABLE public.views (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    content text,
    contenttype text,
    url text,
    userid uuid,
    ispublic boolean DEFAULT false
);


ALTER TABLE public.views OWNER TO cloudcore;

--
-- Name: views_id_seq; Type: SEQUENCE; Schema: public; Owner: cloudcore
--

CREATE SEQUENCE public.views_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.views_id_seq OWNER TO cloudcore;

--
-- Name: views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cloudcore
--

ALTER SEQUENCE public.views_id_seq OWNED BY public.views.id;


--
-- Data for Name: apps; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.apps (id, label, userid, ispublic, url, description) FROM stdin;
8274563b-9982-4acc-bf70-d9a99c3fa0fa	Schnulli	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t	/	Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren.
9a80bfa4-72a9-43ba-b71c-521520afbb6c	Setup	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t	/setup/editor	Editor, Pakete, SQL Konsole, Tabellen
\.


--
-- Data for Name: packageentities; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.packageentities (id, tablename, packageid, entityid) FROM stdin;
64fe9262-1a7b-4bb5-924e-c7d26e76c0ba	routers	e842cea5-da51-4801-9403-1a8bd82a178b	80e51228-ea90-47b7-955e-c486ccfc8caa
23be29d9-2740-471c-a09c-097c717cdb4d	routers	e842cea5-da51-4801-9403-1a8bd82a178b	9a9b9ddf-df1a-421e-99b9-94da235814ca
8a83976c-37b0-4605-9586-e2807e8ed9a2	views	e842cea5-da51-4801-9403-1a8bd82a178b	c7f65743-ccc5-4dce-86ec-6ace01fb01c6
79a84325-cf45-4e7a-9fc8-8ce941e8ac04	views	e842cea5-da51-4801-9403-1a8bd82a178b	b344c26c-d088-4116-ab52-035cdde82a9e
b7680884-47e0-441b-9c59-fb3cd84bf5c8	views	e842cea5-da51-4801-9403-1a8bd82a178b	77c30dd7-0131-425b-a264-2150d0615f02
8da603fe-94de-4538-9d76-e2ae3c941987	tabs	4e596017-1984-43e7-bb99-1c005f2ef32a	4b380de5-7264-4a52-81aa-ee83e4160176
2bc7711e-df32-4142-8810-f58115106f7b	routers	4e596017-1984-43e7-bb99-1c005f2ef32a	a3a9d900-6fa8-4818-8838-4a4f41a2caab
da5f4525-826a-45ab-a1f4-6c43c9faa532	views	4e596017-1984-43e7-bb99-1c005f2ef32a	2ae98d59-3e80-4be4-aa65-822f11656514
5326e514-73a8-4b81-b48f-c68a80e078ef	views	4e596017-1984-43e7-bb99-1c005f2ef32a	81731013-bfd2-442e-85b2-5cf182da71cb
323784ff-915d-484c-937e-11d5f2a44ab0	views	4e596017-1984-43e7-bb99-1c005f2ef32a	d467c535-8c83-4b8a-a638-cdaf9375bedc
c3b5c029-b292-4e20-9576-5493f25d1274	apps	fdcfddb4-6ab2-4597-b647-7a8930d07033	9a80bfa4-72a9-43ba-b71c-521520afbb6c
a8a8f393-df3c-4712-883f-d520a2f84817	routers	fdcfddb4-6ab2-4597-b647-7a8930d07033	c11bd450-76b4-45cb-afce-619cbdcaadd6
8e5f925f-8a45-4027-ac9b-cbbfc469d2cd	views	fdcfddb4-6ab2-4597-b647-7a8930d07033	9c8c25ec-2fe7-4ad3-bd63-1935f743e1cd
f79b4748-592b-4977-8c47-c3389be816ee	views	fdcfddb4-6ab2-4597-b647-7a8930d07033	bac21733-0859-4457-a613-9300d7ec3de7
92548c51-bc8e-47f3-8d52-3c1ab6613adb	views	fdcfddb4-6ab2-4597-b647-7a8930d07033	d4d1f905-b12a-4d78-b6e7-0820d8ba4de4
6c112b27-1727-47e7-a7bd-31dd0ec989d7	views	fdcfddb4-6ab2-4597-b647-7a8930d07033	6f3433f6-12ea-4f23-b121-2731bc26150e
4aa2533d-e641-44fb-9e03-55fef240d662	views	fdcfddb4-6ab2-4597-b647-7a8930d07033	7aa3d0b9-35cd-49f7-9db0-667a3b2a02a3
ee45c1e6-da31-46e5-a593-6406f22eadf5	views	fdcfddb4-6ab2-4597-b647-7a8930d07033	956dda69-6cc6-406a-aa38-75a021581cf6
cb991504-385f-4ff5-96b7-926898b2882a	views	fdcfddb4-6ab2-4597-b647-7a8930d07033	a583b281-22f3-44fd-9db0-d4e2b9a1bc14
f2855b75-63f6-4aed-b6f0-8c412d546dd6	tabs	fdcfddb4-6ab2-4597-b647-7a8930d07033	cae375cc-28f5-4fbe-97a3-a3175a28b924
9e4614f3-d137-4f55-a889-12eb92738db9	tabs	fdcfddb4-6ab2-4597-b647-7a8930d07033	10da6bd3-e1f8-4eb3-8251-148ccd08efbc
36c1d36a-9df3-4317-9191-670934039100	tabs	fdcfddb4-6ab2-4597-b647-7a8930d07033	da5b9bd2-2784-4a74-bf07-f32281efb363
b88c8b6b-5846-46c5-9f12-577c2038946b	routers	fdcfddb4-6ab2-4597-b647-7a8930d07033	0d689490-685b-4260-9bc5-7ab712666b6e
db8c430b-1c90-46a2-ba6a-abc211db8baa	users	e842cea5-da51-4801-9403-1a8bd82a178b	6f6b93ae-94e5-45b0-904f-83a8b37e1627
94322393-5e5f-4e81-ba79-3a05e5a5b0ee	views	e842cea5-da51-4801-9403-1a8bd82a178b	d07d257b-89f0-40b9-9ddf-865f12422d3f
\.


--
-- Data for Name: packagefields; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.packagefields (id, fieldname, tablename, packageid) FROM stdin;
1cd466a2-1ea5-444b-a2e8-ce9d74ea6715	url	routers	e842cea5-da51-4801-9403-1a8bd82a178b
794c8af6-a2e1-47ba-91ce-f96f899392c2	code	routers	e842cea5-da51-4801-9403-1a8bd82a178b
004c2856-1cc4-41c5-b557-2bf14ba8b0ab	content	views	e842cea5-da51-4801-9403-1a8bd82a178b
68b247d3-cce8-4fcb-b18c-78a4e0fa2126	url	views	e842cea5-da51-4801-9403-1a8bd82a178b
1c0115a9-31e9-493f-8086-3bf3414b2ffd	contenttype	views	e842cea5-da51-4801-9403-1a8bd82a178b
8bf22c1e-1d0f-457b-a2dc-3f9225738c7b	label	tabs	e842cea5-da51-4801-9403-1a8bd82a178b
d4933121-4070-4a05-ade9-e0df623651c8	url	tabs	e842cea5-da51-4801-9403-1a8bd82a178b
1443ee29-4e2a-46cb-b5bc-effefef79f5e	appid	tabs	e842cea5-da51-4801-9403-1a8bd82a178b
a0da8ee5-196a-463f-8911-00d4eb0377fc	label	apps	e842cea5-da51-4801-9403-1a8bd82a178b
658a2cb8-2f00-404c-90a6-93722a640b73	ispublic	apps	e842cea5-da51-4801-9403-1a8bd82a178b
3b280681-4018-4aab-8101-d944fbbc82c2	userid	apps	e842cea5-da51-4801-9403-1a8bd82a178b
668e7114-a0e1-4f46-a112-4b566bb3d65a	userid	routers	e842cea5-da51-4801-9403-1a8bd82a178b
bf44a8b1-2fd1-49ff-bcf0-5632bec33676	ispublic	routers	e842cea5-da51-4801-9403-1a8bd82a178b
46702513-3dbd-41f6-a20d-834fb1a8ca94	userid	tabs	e842cea5-da51-4801-9403-1a8bd82a178b
a7ef0e9c-ceee-446f-ac09-adb6788e8e9a	ispublic	tabs	e842cea5-da51-4801-9403-1a8bd82a178b
27b52998-7a7b-477e-86bd-9911c9da7e10	username	users	e842cea5-da51-4801-9403-1a8bd82a178b
8b68294b-6ce4-49fb-827c-7b4b56c22fb7	password	users	e842cea5-da51-4801-9403-1a8bd82a178b
c6619906-cd25-42aa-84fe-93663e25037a	userid	views	e842cea5-da51-4801-9403-1a8bd82a178b
8b5e5c43-33c0-4fbc-8f64-b0e8afe64b33	ispublic	views	e842cea5-da51-4801-9403-1a8bd82a178b
619817fe-9862-41ea-9b3b-44300ec5943a	url	apps	e842cea5-da51-4801-9403-1a8bd82a178b
d5201293-d7a1-40d8-8ad8-a4a145d19548	description	apps	e842cea5-da51-4801-9403-1a8bd82a178b
\.


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.packages (id, name, description) FROM stdin;
4e596017-1984-43e7-bb99-1c005f2ef32a	packaging	Pakete erstellen und herunterladen
fdcfddb4-6ab2-4597-b647-7a8930d07033	setup	Setup mit Editor, SQL Konsole, Tabellen, Backup
e842cea5-da51-4801-9403-1a8bd82a178b	core	* Router für data- und schema-APIs und notwendige Tabellen und Felder\n* Anmeldung und Registrierung für Benutzer
\.


--
-- Data for Name: routers; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.routers (id, code, url, userid, ispublic) FROM stdin;
80e51228-ea90-47b7-955e-c486ccfc8caa	var router = require('express').Router();\n\n// Spalten\n\nrouter.get('/columns/:tablename', async (req, res) => {\n    var result = await req.db.query("SELECT * FROM information_schema.columns WHERE table_name = '" + req.params.tablename + "';");\n    res.json(result.error || result.rows);\n});\n\nrouter.post('/columns/:tablename/:columnname/:columntype', async (req, res) => {\n    var result = await req.db.query("ALTER TABLE " + req.params.tablename + " ADD " + req.params.columnname + " " + req.params.columntype + ";");\n    res.json(result.error || result.rows);\n});\n\nrouter.delete('/columns/:tablename/:columnname', async (req, res) => {\n    var result = await req.db.query("ALTER TABLE " + req.params.tablename + " DROP COLUMN " + req.params.columnname + ";");\n    res.json(result.error || result.rows);\n});\n\n// Tabellen\n\nrouter.get('/tables', async (req, res) => {\n    var result = await req.db.query("SELECT * FROM information_schema.tables WHERE table_schema != 'pg_catalog' AND table_schema != 'information_schema';");\n    res.json(result.rows);\n});\n\nrouter.post('/tables/:tablename', async (req, res) => {\n    res.json(await req.db.query("CREATE TABLE " + req.params.tablename + " (id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), userid UUID, ispublic BOOLEAN DEFAULT false);"));\n});\n\nrouter.delete('/tables/:tablename', async (req, res) => {\n    res.json(await req.db.query("DROP TABLE " + req.params.tablename + ";"));\n});\n\nmodule.exports = router;	/api-schema	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
c11bd450-76b4-45cb-afce-619cbdcaadd6	var router = require('express').Router();\n\nrouter.post('/', async (req, res) => {\n    var query = req.body.query;\n    var result = await req.db.query(query);\n    res.json(result.error ? result.error : result.rows);\n});\n\nmodule.exports = router;	/api-sqlconsole	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
9a9b9ddf-df1a-421e-99b9-94da235814ca	var router = require('express').Router();\r\n\r\nrouter.get('/list/:tablename', async (req, res) => {\r\n    var result = await req.db.query(`SELECT * FROM ${req.params.tablename};`);\r\n    res.json(result.error || result.rows);\r\n});\r\n\r\nrouter.get('/list/:tablename/:columns', async (req, res) => {\r\n    var result = await req.db.query(`SELECT ${req.params.columns} FROM ${req.params.tablename};`);\r\n    res.json(result.error || result.rows);\r\n});\r\n\r\nrouter.get('/list/:tablename/:columns/:filter', async (req, res) => {\r\n    var result = await req.db.query(`SELECT ${req.params.columns} FROM ${req.params.tablename} ${req.params.filter};`);\r\n    res.json(result.error || result.rows);\r\n});\r\n\r\nrouter.get('/:tablename/:id', async (req, res) => {\r\n    var result = await req.db.query("SELECT * FROM " + req.params.tablename + " WHERE id = '" + req.params.id + "';");\r\n    res.json(result.error || result.rows);\r\n});\r\n\r\nrouter.post('/:tablename', async (req, res) => {\r\n    var data = req.body;\r\n    // Solange es noch keine Authentifizierung gibt, wird der Systembenutzer als user festgelegt\r\n    if (data.userid === 'system') data.userid = req.user.id; // Wird von view /setup/editor so benutzt\r\n    var keys = Object.keys(data);\r\n    var values = Object.values(data).map(value => ((typeof value) === 'string') ? "'" + (value.replace(/\\'/g, '\\'\\'')) + "'" : value);\r\n    var query = "INSERT INTO " + req.params.tablename + " (" + keys.join(',') + ") VALUES (" + values.join(',') + ") RETURNING id;";\r\n    var result = await req.db.query(query);\r\n    res.json(result.error || result.rows);\r\n});\r\n\r\nrouter.put('/:tablename/:id', async (req, res) => {\r\n    var query = "UPDATE " + req.params.tablename + " SET " + Object.keys(req.body).map(key => {\r\n        var value = req.body[key];\r\n        return key + "=" + (((typeof value) === 'string') ? "'" + (value.replace(/\\'/g, '\\'\\'')) + "'" : value);\r\n    }).join(',') + " WHERE id='" + req.params.id + "';";\r\n    var result = await req.db.query(query);\r\n    res.json(result.error || result.rows);\r\n});\r\n\r\nrouter.delete('/:tablename/:id', async (req, res) => {\r\n    var result = await req.db.query("DELETE FROM " + req.params.tablename + " WHERE id = '" + req.params.id + "';");\r\n    res.json(result.error || result.rows);\r\n});\r\n\r\nmodule.exports = router;	/api-data	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
d9a4f1eb-f9fb-48b7-9e2c-d87f653309ae	var router = require('express').Router();\nvar bcryptjs = require('bcryptjs');\nvar jsonwebtoken = require('jsonwebtoken');\nvar tokensecret = 'schnullibulli';\n\nfunction createtokenanduserdata(id, username) {\n    return {\n        id: id,\n        token: jsonwebtoken.sign({\n            id: id,\n            time: Date.now()\n        }, tokensecret, {\n            expiresIn: '24h'\n        }),\n        username: username\n    };\n}\n\nrouter.post('/login', async (req, res) => {\n    var username = req.body.username;\n    var password = req.body.password;\n    var existing = await req.db.query("select id, password from users where username = '" + username + "';");\n    if (existing.rows.length < 1 || !bcryptjs.compareSync(password, existing.rows[0].password)) return res.status(403).json({ error: 'Anmeldung fehlgeschlagen' });\n    res.json(createtokenanduserdata(existing.rows[0].id, username));\n});\n\nrouter.post('/register', async (req, res) => {\n    var username = req.body.username;\n    var password = req.body.password;\n    var existing = await req.db.query("select id from users where username = '" + username + "';");\n    if (existing.rows.length > 0) return res.status(400).json({ error: 'Benutzername ist bereits vergeben' });\n    var id = (await req.db.query("INSERT INTO users (username, password) VALUES ('" + username + "', '" + bcryptjs.hashSync(password) + "') RETURNING id;")).rows[0].id;\n    res.json(createtokenanduserdata(id, username));\n});\n\nmodule.exports = router;	/api-auth	\N	f
a3a9d900-6fa8-4818-8838-4a4f41a2caab	// select table_name, column_name from information_schema.columns where table_schema='public' and not column_name = 'id';\nvar router = require('express').Router();\nvar archiver = require('archiver');\n\nrouter.get('/allfields', async (req, res) => {\n    var result = await req.db.query("SELECT table_name, column_name FROM information_schema.columns WHERE table_schema='public' AND column_name NOT IN ('id');");\n    var tablemap = {};\n    for (var row of result.rows) {\n        if (!tablemap[row.table_name]) tablemap[row.table_name] = [];\n        tablemap[row.table_name].push(row.column_name);\n    }\n    res.json(tablemap);\n});\n\nrouter.get('/packagefields/:packageid', async (req, res) => {\n    var result = await req.db.query("select * from packagefields where packageid = '" + req.params.packageid + "';");\n    res.json(result.error || result.rows);\n});\n\nrouter.get('/packageentities/:packageid', async (req, res) => {\n    var result = await req.db.query("select * from packageentities where packageid = '" + req.params.packageid + "';");\n    res.json(result.error || result.rows);\n});\n\nrouter.delete('/:packageid', async (req, res) => {\n    await req.db.query("DELETE FROM packagefields WHERE packageid = '" + req.params.packageid + "';");\n    await req.db.query("DELETE FROM packageentities WHERE packageid = '" + req.params.packageid + "';");\n    await req.db.query("DELETE FROM packages WHERE id = '" + req.params.packageid + "';");\n    res.send();\n});\n\nrouter.get('/download/:packageid', async (req, res) => {\n    var packageid = req.params.packageid;\n    var json = { entities: {} };\n    var package = (await req.db.query("select id, description, name from packages where id='" + packageid + "';")).rows[0];\n    json.id = package.id;\n    json.description = package.description;\n    json.name = package.name;\n    var packagefields = (await req.db.query("select tablename, fieldname from packagefields where packageid = '" + req.params.packageid + "';")).rows.reduce((map, field) => {\n        if (Object.keys(map).indexOf(field.tablename) < 0) map[field.tablename] = [];\n        map[field.tablename].push(field.fieldname);\n        return map;\n    }, {});\n    var columndefs = (await req.db.query("select column_name, table_name, data_type from information_schema.columns where table_schema='public';")).rows.reduce((map, column) => {\n        if (packagefields[column.table_name] && packagefields[column.table_name].indexOf(column.column_name) >= 0) {\n            if (Object.keys(map).indexOf(column.table_name) < 0) map[column.table_name] = {};\n            map[column.table_name][column.column_name] = column.data_type;\n        }\n        return map;\n    }, {});\n    json.fields = columndefs;\n    var packageentities = (await req.db.query("select tablename, entityid from packageentities where packageid = '" + req.params.packageid + "';")).rows.reduce((map, entity) => {\n        if (Object.keys(map).indexOf(entity.tablename) < 0) map[entity.tablename] = [];\n        map[entity.tablename].push(entity.entityid);\n        return map;\n    }, {});\n    for (var [tablename, entityids] of Object.entries(packageentities)) {\n        var query = "select * from \\"" + tablename + "\\" where id in (" + entityids.map(id => "'" + id + "'").join(',') + ");";\n        json.entities[tablename] = (await req.db.query(query)).rows;\n    }\n    // In ZIP packen\n    res.attachment(package.name + '.zip');\n    var archive = archiver('zip');\n    archive.pipe(res);\n    archive.append(JSON.stringify(json), { name: package.name + '.json' });\n    archive.finalize();\n});\n\nmodule.exports = router;	/api-packages	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
0d689490-685b-4260-9bc5-7ab712666b6e	/**\r\n * Dieser Router soll Datenbankbackups erstellen.\r\n */\r\nvar childprocess = require('child_process');\r\nvar router = require('express').Router();\r\n\r\n// Datenbank-Dump erstellen und herunterladen\r\nrouter.get('/', (req, res) => {\r\n    var config = req.db.config;\r\n    var resultbuffer = childprocess.execSync('PGPASSWORD="' + config.PGPASSWORD + '" pg_dump -d ' + config.PGDATABASE + ' -h ' + config.PGHOST + ' -p ' + config.PGPORT + ' -U ' + config.PGUSER); // Benutzt die Einstellungen aus den Environment Variablen\r\n    res.setHeader("Content-Type","text/plain");\r\n    res.send(resultbuffer);\r\n});\r\n\r\nmodule.exports = router;\r\n	/backup	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
\.


--
-- Data for Name: tabs; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.tabs (id, url, label, appid, userid, ispublic) FROM stdin;
cae375cc-28f5-4fbe-97a3-a3175a28b924	/setup/tables	Tabellen	9a80bfa4-72a9-43ba-b71c-521520afbb6c	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
10da6bd3-e1f8-4eb3-8251-148ccd08efbc	/setup/sqlconsole	SQL Konsole	9a80bfa4-72a9-43ba-b71c-521520afbb6c	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
4b380de5-7264-4a52-81aa-ee83e4160176	/setup/packages	Pakete	9a80bfa4-72a9-43ba-b71c-521520afbb6c	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
da5b9bd2-2784-4a74-bf07-f32281efb363	/setup/editor	Editor	9a80bfa4-72a9-43ba-b71c-521520afbb6c	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.users (id, username, password) FROM stdin;
6f6b93ae-94e5-45b0-904f-83a8b37e1627	system	\N
b08c6ae2-e9a5-42ae-8db6-2230bd080fed	r	$2a$10$wB7/U1Yx5gcbKcNfAKbNcurevxrbMaEpZXbJai8f8NSXp/hJds2nG
aec961ff-7b40-405a-ba41-178887eb4d5e	a	$2a$10$OTNb4u57VE4lrK/9yNXLP.KNWbuKSTGOnMCxvJ/TqMibbDEW3S.sS
\.


--
-- Data for Name: views; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.views (id, content, contenttype, url, userid, ispublic) FROM stdin;
52cf145b-f648-4f4a-85af-d9086b51764b	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="assets/slds.css">\n        <script src="/ccc/cc-globalnav"></script>\n    </head>\n    <body>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\n            <subtitle><a href="#">Setup</a> &gt; <a href="#">Setup</a> &gt; Setup</subtitle>\n            <page-title>Tables</page-title>\n            <button>New</button>\n        </header>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\n            <page-title>Title with very long text. I do not know how long it can get so stay away from me!</page-title>\n            <button>New</button>\n            <button>Save</button>\n            <button>Save</button>\n            <button>Delete</button>\n        </header>\n        <content>\n            <table>\n                <thead>\n                    <tr>\n                        <th>Header 1</th>\n                        <th>Header 2</th>\n                        <th>Header 3</th>\n                        <th>Header 4</th>\n                        <th>Header 5</th>\n                        <th>Header 6</th>\n                        <th>Header 7</th>\n                    </tr>\n                </thead>\n                <tbody>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                </tbody>\n            </table>\n        </content>\n        <content>\n            <input-field>\n                <input placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n        </content>\n        <content class="cols-2">\n            <input-field>\n                <input placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <select>\n                    <option value="integer">INTEGER</option>\n                    <option value="varchar" selected="">VARCHAR</option>\n                </select>\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <textarea></textarea>\n                <label>Fullibulli</label>\n            </input-field>\n        </content>\n    </body>\n</html>	text/html	/layouttest	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
6f3433f6-12ea-4f23-b121-2731bc26150e	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            var tablename;\r\n\r\n            async function createcolumn() {\r\n                var name = document.querySelector('#columnname').value;\r\n                var datatype = document.querySelector('#datatype').value;\r\n                await fetch('/api-schema/columns/' + tablename + '/' + name + '/' + datatype, { method: 'POST' });\r\n                location.href = '/setup/tables/columns?' + tablename;\r\n            }\r\n\r\n            window.addEventListener('load', () => {\r\n                tablename = location.search.substring(1);\r\n                document.getElementById('tablename').innerHTML = tablename;\r\n                document.getElementById('columnslink').setAttribute('href', '/setup/tables/columns?' + tablename);\r\n            });\r\n\r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup &gt; <a href="/setup/tables">Tabellen</a> &gt; <a href="#" id="columnslink"><span id="tablename"></span> - Spalten</a></subtitle>\r\n            <page-title>Neue Spalte</page-title>\r\n            <button onclick="createcolumn();">Erstellen</button>\r\n        </header>\r\n        <content>\r\n            <input-field>\r\n                <input id="columnname" placeholder="Name" />\r\n                <label>Name</label>\r\n            </input-field>\r\n            <input-field>\r\n                <select id="datatype">\r\n                    <option value="boolean">BOOLEAN</option>\r\n                    <option value="int">INT</option>\r\n                    <option value="json">JSON</option>\r\n                    <option value="numeric">NUMERIC</option>\r\n                    <option value="real">REAL</option>\r\n                    <option value="text" selected>TEXT</option>\r\n                    <option value="uuid">UUID</option>\r\n                </select>\r\n                <label>Datentyp</label>\r\n            </input-field>\r\n        </content>\r\n    </body>\r\n</html>\r\n	text/html	/setup/tables/columns/create	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
7aa3d0b9-35cd-49f7-9db0-667a3b2a02a3	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            var tablename;\r\n\r\n            function createcontent() {\r\n                location.href = '/setup/tables/content/edit?' + tablename;\r\n            }\r\n\r\n            function htmlencode(str) {\r\n                return ('' + str).replace(/</g, '&lt;').replace(/>/g, '&gt;')\r\n            }\r\n\r\n            async function deletecontent(id) {\r\n                if (!confirm('Soll der Inhalt mit der Id "' + id + '" wirklich gelöscht werden?')) return;\r\n                await fetch('/api-data/' + tablename + '/' + id, { method: 'DELETE' });\r\n                loadcontent();\r\n            }\r\n\r\n            async function loadcontent() {\r\n                var content = await (await fetch('/api-data/list/' + tablename)).json();\r\n                var tbody = document.querySelector('tbody');\r\n                tbody.innerHTML = '';\r\n                console.log(content);\r\n                var columns = {};\r\n                var maxlength = 1000;\r\n                for (var entity of content) {\r\n                    var tr = document.createElement('tr');\r\n                    tbody.appendChild(tr);\r\n                    for (var key of Object.keys(entity)) {\r\n                        columns[key] = true;\r\n                    }\r\n                    tr.innerHTML = Object.values(entity).map(v => {\r\n                        if ((typeof v) === 'object') v = JSON.stringify(v);\r\n                        var text = htmlencode(v && v.length > maxlength ? v.substring(0, maxlength) : v);\r\n                        return '<td title="' + text.replace(/\\"/g, '&quot;') + '">' + text + '</td>';\r\n                    }).join('');\r\n                    tr.innerHTML += '<td><a href="/setup/tables/content/edit?' + tablename + '/' + entity.id + '">Bearbeiten</a></td><td><a href="#" onclick="deletecontent(\\'' + entity.id + '\\');">Löschen</a></td>';\r\n                }\r\n                var thead = document.querySelector('thead');\r\n                thead.innerHTML = '<tr>' + Object.keys(columns).map(c => '<th>' + c + '</th>').join('') + '<th></th><th></th></tr>';\r\n            }\r\n\r\n            window.addEventListener('load', () => {\r\n                tablename = location.search.substring(1);\r\n                document.getElementById('tablename').innerHTML = tablename;\r\n                loadcontent();\r\n            });\r\n        \r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup &gt; <a href="/setup/tables">Tabellen</a></subtitle>\r\n            <page-title><span id="tablename"></span> - Inhalt</page-title>\r\n            <button onclick="createcontent();">Neuer Inhalt</button>\r\n        </header>\r\n        <content>\r\n            <table>\r\n                <thead></thead>\r\n                <tbody></tbody>\r\n            </table>\r\n        </content>\r\n    </body>\r\n</html>\r\n	text/html	/setup/tables/content	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
956dda69-6cc6-406a-aa38-75a021581cf6	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="/assets/slds.css">\n        <style>\n            textarea {\n                border: none;\n                width: 100%;\n                height: 100%;\n                padding: 4px;\n                font-family: monospace;\n                background-color: black;\n                color: lightgreen;\n                font-size: 14px;\n            }\n            #output {\n                white-space: pre;\n                font-family: monospace;\n            }\n        </style>\n        <script src="/ccc/cc-globalnav"></script>\n        <script>\n\n            async function run() {\n                var tf = document.getElementById('input');\n                var sql = tf.value;\n                var result = await (await fetch('/api-sqlconsole/', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ query: sql }) })).json();\n                var output = document.getElementById('output');\n                output.innerText = sql + '\\n\\n' + JSON.stringify(result, null, 2);\n                tf.focus();\n            }\n\n            window.addEventListener('load', () => { document.getElementById('input').focus(); });\n\n        </script>\n    </head>\n    <body>\n        <cc-globalnav selectedurl="/setup/sqlconsole"></cc-globalnav>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/local_shipping/v4/24px.svg"/>\n            <subtitle>Setup</subtitle>\n            <page-title>SQL Konsole</page-title>\n            <button onclick="run();">Ausführen</button>\n        </header>\n        <content>\n            <textarea id="input"></textarea>\n        </content>\n        <content id="output"></content>\n    </body>\n</html>	text/html	/setup/sqlconsole	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
9c8c25ec-2fe7-4ad3-bd63-1935f743e1cd	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="/assets/slds.css">\n        <script src="/ccc/cc-globalnav"></script>\n        <script src="/monaco-editor/min/vs/loader.js"></script>\n        <script>\n        var monacoEditor;\n        var currentView;\n        var currentRouter;\n\n        function openInNewTab() {\n            if (!currentView) return;\n            window.open(currentView.url, '_blank');\n        }\n\n        async function del() {\n            if (currentView) {\n                if (!confirm('Soll die View wirklich gelöscht werden?')) return;\n                await fetch('/api-data/views/' + currentView.id, { method: 'DELETE' });\n                location.href = '?';\n            } else if (currentRouter) {\n                if (!confirm('Soll der Router wirklich gelöscht werden?')) return;\n                await fetch('/api-data/routers/' + currentRouter.id, { method: 'DELETE' });\n                location.href = '?';\n            }\n        }\n\n        async function createView() {\n            var url = prompt('Welche URL?', '/');\n            if (!url) return;\n            var contenttype = prompt('Welcher Content Type?', 'text/html');\n            if (!contenttype) return;\n            var id = (await (await fetch('/api-data/views', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ url: url, contenttype: contenttype, content: '', userid: 'system', ispublic: true }) })).json())[0].id;\n            location.href = '?views/' + id;\n        }\n\n        async function createRouter() {\n            var url = prompt('Welche URL?', '/');\n            if (!url) return;\n            var id = (await (await fetch('/api-data/routers', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ url: url, code: '' }) })).json())[0].id;\n            location.href = '?routers/' + id;\n        }\n\n        async function save() {\n            if (currentView) {\n                var content = monacoEditor.getValue();\n                await fetch('/api-data/views/' + currentView.id, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ content: content }) });\n            } else if (currentRouter) {\n                var code = monacoEditor.getValue();\n                await fetch('/api-data/routers/' + currentRouter.id, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ code: code }) });\n            }\n            var button = document.querySelector('#savebutton');\n            button.classList.add('green');\n            setTimeout(() => {\n                button.classList.remove('green');\n            }, 1000);\n        }\n\n        async function loadView(id) {\n            currentRouter = false;\n            currentView = (await (await fetch('/api-data/views/' + id)).json())[0];\n            monacoEditor.setValue(currentView.content);\n            var language = monaco.languages.getLanguages().find(l => l.mimetypes && (l.mimetypes.indexOf(currentView.contenttype) >= 0));\n            monaco.editor.setModelLanguage(monacoEditor.getModel(), language ? language.id : 'plaintext');\n            document.querySelectorAll('content table .selected').forEach(e => e.classList.remove('selected'));\n            document.getElementById('view-' + id).classList.add('selected');\n            window.history.pushState(null, null, '?views/' + id);\n        }\n\n        async function loadRouter(id) {\n            currentView = false;\n            currentRouter = (await (await fetch('/api-data/routers/' + id)).json())[0];\n            monacoEditor.setValue(currentRouter.code);\n            monaco.editor.setModelLanguage(monacoEditor.getModel(), 'javascript');\n            document.querySelectorAll('content table .selected').forEach(e => e.classList.remove('selected'));\n            document.getElementById('router-' + id).classList.add('selected');\n            window.history.pushState(null, null, '?routers/' + id);\n        }\n\n        async function listViewsAndRouters() {\n            var views = await (await fetch('/api-data/list/views/id,url')).json();\n            views.sort((v1, v2) => v1.url > v2.url ? 1 : -1);\n            var viewlist = document.getElementById('views');\n            viewlist.innerHTML = '';\n            for (var view of views) {\n                viewlist.innerHTML += '<tr id="view-' + view.id + '"><td><a href="#" onclick="loadView(\\'' + view.id + '\\');">' + view.url + '</a></td></tr>';\n            }\n            var routers = await (await fetch('/api-data/list/routers/id,url')).json();\n            routers.sort((r1, r2) => r1.url > r2.url ? 1 : -1);\n            var routerlist = document.getElementById('routers');\n            routerlist.innerHTML = '';\n            for (var router of routers) {\n                routerlist.innerHTML += '<tr id="router-' + router.id + '"><td><a href="#" onclick="loadRouter(\\'' + router.id + '\\');">' + router.url + '</a></td></tr>';\n            }\n        }\n\n        window.addEventListener('load', function() {\n            // MonacoEditor initialisieren\n            require.config({ paths: { 'vs': '/monaco-editor/min/vs' }});\n            require(['vs/editor/editor.main'], function() {\n                monacoEditor = monaco.editor.create(document.getElementById('editor'));\n                if (location.search.length > 1) {\n                    var parts = location.search.substring(1).split('/');\n                    if (parts[0] === 'views') {\n                        loadView(parts[1]);\n                    } else {\n                        loadRouter(parts[1]);\n                    }\n                };\n                monacoEditor.addCommand(monaco.KeyMod.CtrlCmd | monaco.KeyCode.KEY_S, save);\n            });        \n            listViewsAndRouters();\n        });\n\n        window.addEventListener('resize', function() {\n            if (monacoEditor) monacoEditor.layout();\n        });\n\n        </script>\n    </head>\n    <body>\n        <cc-globalnav selectedurl="/setup/editor"></cc-globalnav>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/code/v4/24px.svg"/>\n            <subtitle>Setup</subtitle>\n            <page-title>Editor</page-title>\n            <button onclick="createView();">+ View</button>\n            <button onclick="createRouter();">+ Router</button>\n            <button onclick="save();" id="savebutton">Speichern</button>\n            <button onclick="del();">Löschen</button>\n            <button onclick="openInNewTab();">Öffnen</button>\n            <button>\n                <select onchange="monaco.editor.setTheme(this.value);">\n                    <option value="vs">Hell</option>\n                    <option value="vs-dark">Dunkel</option>\n                    <option value="hc-black">Hoher Kontrast</option>\n                </select>\n            </button>\n        </header>\n        <columns class="two-fix-flex">\n            <content style="width:300px;">\n                <table>\n                    <thead><tr><th>Views</th></tr></thead>\n                    <tbody id="views"></tbody>\n                </table>\n                <table>\n                    <thead><tr><th>Routers</th></tr></thead>\n                    <tbody id="routers"></tbody>\n                </table>\n            </content>\n            <content id="editor" style="overflow: hidden;"></content>\n        </columns>\n    </body>\n</html>	text/html	/setup/editor	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
a583b281-22f3-44fd-9db0-d4e2b9a1bc14	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            var tablename, entityid;\r\n\r\n            async function save() {\r\n                var content = {};\r\n                for (var key  of keys) {\r\n                    content[key] = document.getElementById(key).value;\r\n                }\r\n                if (entityid) {\r\n                    await fetch('/api-data/' + tablename + '/' + entityid, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(content) });\r\n                } else {\r\n                    entityid = (await (await fetch('/api-data/' + tablename, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(content) })).json())[0].id;\r\n                    location.href += '/' + entityid;\r\n                }\r\n            }\r\n\r\n            async function loadcontent() {\r\n                var content;\r\n                if (entityid) {\r\n                    content = (await (await fetch('/api-data/' + tablename + '/' + entityid)).json())[0];\r\n                } else {\r\n                    content = {};\r\n                    var columns = await (await fetch('/api-schema/columns/' + tablename)).json();\r\n                    for (var column of columns) {\r\n                        if (column.table_schema !== 'public') continue;\r\n                        content[column.column_name] = '';\r\n                    }\r\n                }\r\n                delete content.id;\r\n                var contentelement = document.querySelector('content');\r\n                contentelement.innerHTML = '';\r\n                keys = Object.keys(content);\r\n                for (var key of keys) {\r\n                    var inputfield = document.createElement('input-field');\r\n                    inputfield.innerHTML = '<textarea id="' + key + '"></textarea><label>' + key + '</label>';\r\n                    contentelement.appendChild(inputfield);\r\n                    var value = content[key];\r\n                    if (typeof(value) === 'object') value = JSON.stringify(value);\r\n                    document.getElementById(key).value = value;\r\n                }\r\n            }\r\n\r\n            window.addEventListener('load', () => {\r\n                var urlparts = location.search.substring(1).split('/');\r\n                tablename = urlparts[0];\r\n                entityid = urlparts[1];\r\n                document.getElementById('tablename').innerHTML = tablename;\r\n                document.getElementById('contentlink').setAttribute('href', '/setup/tables/content?' + tablename);\r\n                loadcontent();\r\n            });\r\n\r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup &gt; <a href="/setup/tables">Tabellen</a> &gt; <a href="#" id="contentlink"><span id="tablename"></span> - Inhalt</a></subtitle>\r\n            <page-title>Inhalt bearbeiten</page-title>\r\n            <button onclick="save();">Speichern</button>\r\n        </header>\r\n        <content>\r\n        </content>\r\n    </body>\r\n</html>\r\n	text/html	/setup/tables/content/edit	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
d467c535-8c83-4b8a-a638-cdaf9375bedc	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="/assets/slds.css">\n        <script src="/ccc/cc-globalnav"></script>\n        <script>\n\n            var package;\n\n            function htmlencode(str) {\n                return ('' + str).replace(/</g, '&lt;').replace(/>/g, '&gt;')\n            }\n\n            async function selecttable() {\n                var selectedtable = document.getElementById('tables').value;\n                var content = await (await fetch('/api-data/list/' + selectedtable)).json();\n                var tbody = document.querySelector('#availableentities tbody');\n                tbody.innerHTML = '';\n                var columns = {};\n                var maxlength = 1000;\n                for (var entity of content) {\n                    var tr = document.createElement('tr');\n                    tbody.appendChild(tr);\n                    for (var key of Object.keys(entity)) {\n                        columns[key] = true;\n                    }\n                    tr.innerHTML = Object.values(entity).map(v => {\n                        var text = htmlencode(v && v.length > maxlength ? v.substring(0, maxlength) : v);\n                        return '<td title="' + text.replace(/\\"/g, '&quot;') + '">' + text + '</td>';\n                    }).join('');\n                    tr.innerHTML += '<td><a href="#" onclick="addentity(\\'' + entity.id + '\\');">Hinzufügen</a></td>';\n                }\n                var thead = document.querySelector('#availableentities thead');\n                thead.innerHTML = '<tr>' + Object.keys(columns).map(c => '<th>' + c + '</th>').join('') + '<th></th><th></th></tr>';\n            }\n\n            async function addentity(entityid) {\n                var selectedtable = document.getElementById('tables').value;\n                await fetch('/api-data/packageentities', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ tablename: selectedtable, entityid: entityid, packageid: package.id }) });\n                load();\n            }\n\n            async function deletepackageentity(id) {\n                await fetch('/api-data/packageentities/' + id, { method: 'DELETE' });\n                load();\n            }\n\n            async function load() {\n                var packageid = location.search.substring(1);\n                package = (await (await fetch('/api-data/packages/' + packageid)).json())[0];\n                document.getElementById('packagename').innerHTML = package.name;\n                var tables = await (await fetch('/api-schema/tables')).json();\n                tables.sort((a, b) => a.table_name > b.table_name ? 1 : -1);\n                var tablesselect = document.getElementById('tables');\n                tablesselect.innerHTML = '';\n                for (table of tables) {\n                    tablesselect.innerHTML += '<option value="' + table.table_name + '">' + table.table_name + '</option>';\n                }\n                tablesselect.selectedIndex = 0;\n                selecttable();\n                var packageentities = await (await fetch('/api-packages/packageentities/' + packageid)).json();\n                packageentities.sort((a, b) => a.tablename > b.tablename ? 1 : -1);\n                var tbody = document.querySelector('#packageentities tbody');\n                tbody.innerHTML = '';\n                for (var packageentity of packageentities) {\n                    var tr = document.createElement('tr');\n                    tr.innerHTML = '<td>' + packageentity.tablename + '</td><td><a href="/setup/tables/content/edit?' + packageentity.tablename + '/' + packageentity.entityid + '">' + packageentity.entityid + '</a></td><td><a href="#" onclick="deletepackageentity(\\'' + packageentity.id + '\\');">Entfernen</a></td>';\n                    tbody.appendChild(tr);\n                }\n            }\n\n            window.addEventListener('load', load);\n\n        </script>\n    </head>\n    <body>\n        <cc-globalnav selectedurl="/setup/packages"></cc-globalnav>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/local_shipping/v4/24px.svg"/>\n            <subtitle>Setup &gt; <a href="/setup/packages">Pakete</a></subtitle>\n            <page-title><span id="packagename"></span> - Daten</page-title>\n            <button>\n                <select id="tables" onchange="selecttable();"></select>\n            </button>\n        </header>\n        <content>\n            <table id="availableentities">\n                <thead></thead>\n                <tbody></tbody>\n            </table>\n        </content>\n        <content>\n            <table id="packageentities">\n                <thead><tr><th>Tabelle</th><th>Datensatz</th><th></th></tr></thead>\n                <tbody></tbody>\n            </table>\n        </content>\n    </body>\n</html>	text/html	/setup/packages/entities	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
bac21733-0859-4457-a613-9300d7ec3de7	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            async function createtable() {\r\n                var tablename = window.prompt('Name der neuen Tabelle');\r\n                if(!tablename) return;\r\n                await fetch('/api-schema/tables/' + tablename, { method: 'POST' });\r\n                loadtables();\r\n            }\r\n\r\n            async function deletetable(tablename) {\r\n                if (!confirm('Soll die Tabelle "' + tablename + '" wirklich gelöscht werden?')) return;\r\n                await fetch('/api-schema/tables/' + tablename, { method: 'DELETE' });\r\n                loadtables();\r\n            }\r\n\r\n            async function loadtables() {\r\n                var tables = await (await fetch('/api-schema/tables')).json();\r\n                tables.sort((a, b) => a.table_name > b.table_name ? 1 : -1);\r\n                var tbody = document.querySelector('tbody');\r\n                tbody.innerHTML = '';\r\n                for (var table of tables) {\r\n                    var tr = document.createElement('tr');\r\n                    tr.innerHTML = '<td>' + table.table_name + '</td><td><a href="/setup/tables/content?' + table.table_name + '">Daten</a></td><td><a href="/setup/tables/columns?' + table.table_name + '">Felder</a></td><td><a href="#" onclick="deletetable(\\'' + table.table_name + '\\');">Löschen</a></td>';\r\n                    tbody.appendChild(tr);\r\n                }\r\n            }\r\n\r\n            window.addEventListener('load', loadtables);\r\n\r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup</subtitle>\r\n            <page-title>Tabellen</page-title>\r\n            <button onclick="createtable();">Neue Tabelle</button>\r\n            <button onclick="window.open('/backup/', '_blank');">Download Backup</button>\r\n        </header>\r\n        <content>\r\n            <table>\r\n                <thead><tr><th>Name</th><th></th><th></th><th></th></tr></thead>\r\n                <tbody></tbody>\r\n            </table>\r\n        </content>\r\n    </body>\r\n</html>	text/html	/setup/tables	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
d4d1f905-b12a-4d78-b6e7-0820d8ba4de4	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            var tablename;\r\n\r\n            function createcolumn() {\r\n                location.href = '/setup/tables/columns/create?' + tablename;\r\n            }\r\n\r\n            async function deletecolumn(columnname) {\r\n                if (!confirm('Really delete column "' + columnname + '"?')) return;\r\n                await fetch('/api-schema/columns/' + tablename + '/' + columnname, { method: 'DELETE' });\r\n                loadcolumns();\r\n            }\r\n\r\n            async function loadcolumns() {\r\n                var columns = await (await fetch('/api-schema/columns/' + tablename)).json();\r\n                var tbody = document.querySelector('tbody');\r\n                tbody.innerHTML = '';\r\n                for (var column of columns) {\r\n                    if (column.table_schema !== 'public') continue;\r\n                    var tr = document.createElement('tr');\r\n                    tr.innerHTML = '<td>' + column.column_name + '</td><td>' + column.data_type + '</td><td><a href="#" onclick="deletecolumn(\\'' + column.column_name + '\\');">Delete</a></td>';\r\n                    tbody.appendChild(tr);\r\n                }\r\n            }\r\n\r\n            window.addEventListener('load', () => {\r\n                tablename = location.search.substring(1);\r\n                document.getElementById('tablename').innerHTML = tablename;\r\n                loadcolumns();\r\n            });\r\n        \r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup &gt; <a href="/setup/tables">Tabellen</a></subtitle>\r\n            <page-title><span id="tablename"></span> - Spalten</page-title>\r\n            <button onclick="createcolumn();">Neue Spalte</button>\r\n        </header>\r\n        <content>\r\n            <table>\r\n                <thead><tr><th>Name</th><th>Datentyp</th><th></th></tr></thead>\r\n                <tbody></tbody>\r\n            </table>\r\n        </content>\r\n    </body>\r\n</html>\r\n	text/html	/setup/tables/columns	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
81731013-bfd2-442e-85b2-5cf182da71cb	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="/assets/slds.css">\n        <script src="/ccc/cc-globalnav"></script>\n        <script>\n\n            var package, allfields;\n\n            function selecttable() {\n                var selectedtable = document.getElementById('tables').value;\n                var fieldsselect = document.getElementById('fields');\n                fieldsselect.innerHTML = '';\n                for (var field of allfields[selectedtable]) {\n                    fieldsselect.innerHTML += '<option value="' + field + '">' + field + '</option>';\n                }\n            }\n\n            async function addfield() {\n                var selectedtable = document.getElementById('tables').value;\n                var selectedfield = document.getElementById('fields').value;\n                await fetch('/api-data/packagefields', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ tablename: selectedtable, fieldname: selectedfield, packageid: package.id }) });\n                load();\n            }\n\n            async function deletepackagefield(id) {\n                await fetch('/api-data/packagefields/' + id, { method: 'DELETE' });\n                load();\n            }\n\n            async function load() {\n                var packageid = location.search.substring(1);\n                package = (await (await fetch('/api-data/packages/' + packageid)).json())[0];\n                document.getElementById('packagename').innerHTML = package.name;\n                allfields = await (await fetch('/api-packages/allfields')).json();\n                var tablesselect = document.getElementById('tables');\n                tablesselect.innerHTML = '';\n                for (table of Object.keys(allfields)) {\n                    tablesselect.innerHTML += '<option value="' + table + '">' + table + '</option>';\n                }\n                tablesselect.selectedIndex = 0;\n                selecttable();\n                var packagefields = await (await fetch('/api-packages/packagefields/' + packageid)).json();\n                packagefields.sort((a, b) => a.tablename === b.tablename ? (a.fieldname > b.fieldname ? 1 : -1) : (a.tablename > b.tablename ? 1 : -1));\n                var tbody = document.querySelector('tbody');\n                tbody.innerHTML = '';\n                for (var packagefield of packagefields) {\n                    var tr = document.createElement('tr');\n                    tr.innerHTML = '<td>' + packagefield.tablename + '</td><td>' + packagefield.fieldname + '</td><td><a href="#" onclick="deletepackagefield(\\'' + packagefield.id + '\\');">Löschen</a></td>';\n                    tbody.appendChild(tr);\n                }\n\n            }\n\n            window.addEventListener('load', load);\n\n        </script>\n    </head>\n    <body>\n        <cc-globalnav selectedurl="/setup/packages"></cc-globalnav>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/local_shipping/v4/24px.svg"/>\n            <subtitle>Setup &gt; <a href="/setup/packages">Pakete</a></subtitle>\n            <page-title><span id="packagename"></span> - Felder</page-title>\n            <button>\n                <select id="tables" onchange="selecttable();"></select>\n            </button>\n            <button>\n                <select id="fields"></select>\n            </button>\n            <button onclick="addfield();">Hinzufügen</button>\n        </header>\n        <content>\n            <table>\n                <thead><tr><th>Tabelle</th><th>Feld</th><th></th></tr></thead>\n                <tbody></tbody>\n            </table>\n        </content>\n    </body>\n</html>	text/html	/setup/packages/fields	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
77c30dd7-0131-425b-a264-2150d0615f02	html,\r\nbody {\r\n    margin: 0;\r\n    padding: 0;\r\n    width: 100%;\r\n    height: 100%;\r\n    overflow: hidden;\r\n}\r\nbody {\r\n    display: flex;\r\n    flex-direction: column;\r\n    font-family: sans-serif;\r\n    font-size: 13px;\r\n    color: #080707;\r\n    background-image: url(https://www.lightningdesignsystem.com/assets/images/themes/oneSalesforce/banner-brand-default.png), linear-gradient(0, rgba(176, 196, 223, 1), 85%, #195594);\r\n    background-repeat: repeat-x;\r\n    position: relative;\r\n    overflow: auto;\r\n}\r\nbody::after {\r\n    content: "";\r\n    background-image: linear-gradient(0, rgba(176, 196, 223, 1), 90%, transparent\r\n    );\r\n    height: 100%;\r\n    top: 0;\r\n    position: absolute;\r\n    left: 0;\r\n    width: 100%;\r\n    z-index: -1;\r\n}\r\na {\r\n    color: rgb(0, 109, 204);\r\n    text-decoration: none;\r\n}\r\na:hover {\r\n    text-decoration: underline;\r\n}\r\nbutton-row {\r\n    display: block;\r\n    text-align: right;\r\n    padding: 12px 12px 0 12px;\r\n}\r\nbutton-row > a {\r\n    margin: 0 16px;\r\n}\r\nform-title {\r\n    font-size: 17px;\r\n    padding: 16px 12px 0 12px;\r\n}\r\nheader {\r\n    margin: 12px 12px 0 12px;\r\n    border-radius: 4px;\r\n    border: 1px solid #ccc;\r\n    box-shadow: 1px 1px 3px -1px rgba(0, 0, 0, 0.5);\r\n    padding: 16px;\r\n    background-color: rgb(243, 242, 242);\r\n    display: flex;\r\n    position: relative;\r\n}\r\nheader > img {\r\n    filter: invert(1);\r\n    background-color: coral;\r\n    border-radius: 3px;\r\n    padding: 7px;\r\n    margin-right: 16px;\r\n}\r\nheader > page-title {\r\n    display: block;\r\n    flex: 1;\r\n    font-size: 18px;\r\n    font-weight: bold;\r\n    line-height: 38px;\r\n    overflow: hidden;\r\n    white-space: nowrap;\r\n    text-overflow: ellipsis;\r\n}\r\nheader > subtitle {\r\n    position: absolute;\r\n    left: 70px;\r\n    color: rgb(62, 62, 60);\r\n}\r\nheader > subtitle + page-title {\r\n    line-height: 22px;\r\n    margin-top: 16px;\r\n}\r\nheader > button,\r\nbutton-row > button {\r\n    background-color: #fff;\r\n    padding: 0 16px;\r\n    border: solid rgb(221, 219, 218);\r\n    line-height: 30px;\r\n    margin: 4px 0;\r\n    border-width: 1px 1px 1px 0;\r\n    color: rgb(27, 82, 151);\r\n    font-size: 13px;\r\n    cursor: pointer;\r\n}\r\nheader > button > select {\r\n    border: none;\r\n    display: block;\r\n    background-color: transparent;\r\n    padding: 7px 16px;\r\n    margin: 0 -16px;\r\n    color: rgb(27, 82, 151);    \r\n}\r\nheader > button > label,\r\nbutton-row > button > label {\r\n    border: none;\r\n    display: block;\r\n    cursor: pointer;\r\n    background-color: transparent;\r\n    padding: 0 16px;\r\n    margin: 0 -16px;\r\n    color: rgb(27, 82, 151);    \r\n}\r\nheader > button > label > input {\r\n    display: none;\r\n}\r\nheader > button:hover,\r\nbutton-row > button:hover {\r\n    background-color: rgb(243, 242, 242);\r\n}\r\nheader > button:first-of-type,\r\nbutton-row > button:first-of-type {\r\n    border-left-width: 1px;\r\n    border-top-left-radius: 4px;\r\n    border-bottom-left-radius: 4px;\r\n    margin-left: 16px;\r\n}\r\nheader > button:last-of-type,\r\nbutton-row > button:last-of-type {\r\n    border-right-width: 1px;\r\n    border-top-right-radius: 4px;\r\n    border-bottom-right-radius: 4px;\r\n}\r\ncolumns {\r\n    display: flex;\r\n    flex: 1;\r\n}\r\ncolumns.two-fix-flex > *:first-child {\r\n    flex: unset;\r\n    margin-right: 0;\r\n}\r\ncontent {\r\n    margin: 12px 12px 0 12px;\r\n    border-radius: 4px;\r\n    border: 1px solid #ccc;\r\n    box-shadow: 1px 1px 3px -1px rgba(0, 0, 0, 0.5);\r\n    flex: 1;\r\n    overflow: auto;\r\n    background-color: #fff;\r\n}\r\nlogin-form {\r\n    width: 300px;\r\n    margin: auto;\r\n    border-radius: 4px;\r\n    border: 1px solid #ccc;\r\n    box-shadow: 1px 1px 3px -1px rgba(0, 0, 0, 0.5);\r\n    padding: 16px 0;\r\n    background-color: #fff;\r\n    display: flex;\r\n}\r\nlogin-form > form {\r\n    display: flex;\r\n    flex-direction: column;\r\n    flex: 1;\r\n}\r\ntable {\r\n    border-spacing: 0;\r\n    width: 100%;\r\n}\r\ntable > thead > tr > th,\r\ntable > tbody > tr > td {\r\n    padding: 4px 8px;\r\n    text-align: start;\r\n    overflow: hidden;\r\n    max-width: 0;\r\n    white-space: nowrap;\r\n    text-overflow: ellipsis;\r\n    border-bottom: 1px solid rgb(221, 219, 218);\r\n}\r\ntable > thead > tr > th > a,\r\ntable > tbody > tr > td > a {\r\n    display: block;\r\n    margin: -4px -8px;\r\n    padding: 4px 8px;\r\n}\r\ntable > thead > tr > th {\r\n    background-color: rgb(250, 250, 249);\r\n    line-height: 24px;\r\n}\r\ntable > tbody > tr > td {\r\n    line-height: 21px;\r\n}\r\ntable > tbody > tr:last-child > td {\r\n    border-bottom: none;\r\n}\r\ntable > tbody > tr:hover > td {\r\n    background-color: rgb(243, 242, 242);\r\n    box-shadow: rgb(221, 219, 218) 0px -1px 0px 0px inset, rgb(221, 219, 218) 0px 1px 0px 0px inset;\r\n}\r\ntable > tbody > tr > td:hover {\r\n    background-color: #fff;\r\n}\r\ntable > tbody > tr.selected > td {\r\n    background-color: rgb(243, 242, 242);\r\n}\r\ninput-field {\r\n    display: block;\r\n    position: relative;\r\n    padding: 22px 12px 0 12px;\r\n}\r\ninput-field > input {\r\n    display: block;\r\n    border: solid rgb(221, 219, 218);\r\n    width: 100%;\r\n    border-width: 0 0 1px 0;\r\n    font-size: 14px;\r\n    line-height: 22px;\r\n    padding: 0 4px;\r\n    box-sizing: border-box;\r\n}\r\ninput-field > select {\r\n    display: block;\r\n    width: 100%;\r\n    border: solid rgb(221, 219, 218);\r\n    border-width: 0 0 1px 0;\r\n    padding: 3px 4px 2px 4px;    \r\n}\r\ninput-field > textarea {\r\n    display: block;\r\n    border: 1px solid rgb(221, 219, 218);\r\n    border-radius: 4px;\r\n    font-size: 14px;\r\n    padding: 4px;\r\n    box-sizing: border-box;\r\n    min-width: 100%;\r\n    max-width: 100%;\r\n}\r\ninput-field > label {\r\n    position: absolute;\r\n    top: 8px;\r\n    left: 16px;\r\n    color: #ccc;\r\n    font-size: 11px;\r\n}\r\ninput-field > input::placeholder {\r\n    color: #ccc;\r\n}\r\ninput-field > input:placeholder-shown + label {\r\n    display: none;\r\n}\r\nbody > content:last-of-type,\r\nbody > columns:last-of-type {\r\n    margin-bottom: 12px;\r\n}\r\nbutton.green {\r\n    background-color:lightgreen;\r\n}\r\n.cols-2 {\r\n    columns: 2;\r\n    column-gap: 0;\r\n}\r\n	text/css	/assets/slds.css	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
2ae98d59-3e80-4be4-aa65-822f11656514	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="/assets/slds.css">\n        <script src="/ccc/cc-globalnav"></script>\n        <script>\n\n            async function createpackage() {\n                var packagename = window.prompt('Name des neuen Paketes');\n                if(!packagename) return;\n                await fetch('/api-data/packages', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ name: packagename }) });\n                loadpackages();\n            }\n\n            async function deletepackage(id) {\n                if (!confirm('Soll das Paket mit der Id "' + id + '" wirklich gelöscht werden?')) return;\n                await fetch('/api-packages/' + id, { method: 'DELETE' });\n                loadpackages();\n            }\n\n            async function loadpackages() {\n                var packages = await (await fetch('/api-data/list/packages')).json();\n                packages.sort((a, b) => a.name > b.name ? 1 : -1);\n                var tbody = document.querySelector('tbody');\n                tbody.innerHTML = '';\n                for (var package of packages) {\n                    var tr = document.createElement('tr');\n                    tr.innerHTML = '<td><a href="/setup/tables/content/edit?packages/' + package.id + '">' + package.name + '</a></td><td>' + package.description + '</td><td><a href="/setup/packages/entities?' + package.id + '">Daten</a></td><td><a href="/setup/packages/fields?' + package.id + '">Felder</a></td><td><a href="#" onclick="deletepackage(\\'' + package.id + '\\');">Löschen</a></td><td><a href="/api-packages/download/' + package.id + '" target="_blank">Download</a></td>';\n                    tbody.appendChild(tr);\n                }\n            }\n\n            async function upload(files) {\n                var data = new FormData();\n                for (var file of files) {\n                    data.append('file', file, file.name);\n                    var result = await fetch('/api/packageupload/', { method: 'POST', body: data });\n                    console.log(await result.text());\n                }\n                loadpackages();\n            }\n\n            window.addEventListener('load', loadpackages);\n\n        </script>\n    </head>\n    <body>\n        <cc-globalnav selectedurl="/setup/packages"></cc-globalnav>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/local_shipping/v4/24px.svg"/>\n            <subtitle>Setup</subtitle>\n            <page-title>Pakete</page-title>\n            <button onclick="createpackage();">Neues Paket</button>\n            <button>\n                <label for="upload">\n                    <span>Upload</span>\n                    <input type="file" name="upload" id="upload" accept="application/zip" onchange="upload(this.files);" />\n                </label>\n            </button>\n        </header>\n        <content>\n            <table>\n                <thead><tr><th>Name</th><th>Beschreibung</th><th></th><th></th><th></th><th></th></tr></thead>\n                <tbody></tbody>\n            </table>\n        </content>\n    </body>\n</html>	text/html	/setup/packages	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
13e992a1-d200-41f8-b2db-b9201a7704fe	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="/assets/slds.css">\n        <script>\n\n            async function login(evt) {\n                var username = evt.target.username.value;\n                var password = evt.target.password.value;\n                evt.preventDefault();\n                var result = await (await fetch('/api-auth/login', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ username: username, password: password }) })).json();\n                console.log(result);\n            }\n\n            function init() {\n                document.querySelector('form').addEventListener('submit', login);\n            }\n\n            window.addEventListener('load', init);\n\n        </script>\n    </head>\n    <body>\n        <login-form>\n            <form method="POST" action="#">\n                <form-title>Login</form-title>\n                <input-field>\n                    <input name="username" type="text" placeholder="Benutzername" />\n                    <label>Benutzername</label>\n                </input-field>\n                <input-field>\n                    <input name="password" type="password" placeholder="Passwort" />\n                    <label>Passwort</label>\n                </input-field>\n                <button-row>\n                    <button type="submit">Anmelden</button>\n                    <a href="/register">Registrieren</a>\n                </button-row>\n            </form>\n        </login-form>\n    </body>\n</html>	text/html	/login	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
c7f65743-ccc5-4dce-86ec-6ace01fb01c6	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="/assets/slds.css">\n        <script src="/ccc/cc-globalnav"></script>\n        <script src="/ccc/cc-applist"></script>\n    </head>\n    <body>\n        <cc-globalnav></cc-globalnav>\n        <content style="display:flex;">\n            <cc-applist></cc-applist>\n        </content>\n    </body>\n</html>\n	text/html	/	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
b344c26c-d088-4116-ab52-035cdde82a9e	// Siehe https://developers.google.com/web/updates/2017/01/webcomponents-org\n// Und https://googlechromelabs.github.io/howto-components/howto-checkbox/#demo\n// ccc steht für CloudCoreComponent\n(function() {\n\n    var template = document.createElement('template');\n    template.innerHTML = `\n    <style>\n        :host {\n            border-bottom: 3px solid #0070d2;\n            display: flex;\n            background-color: white;\n        }\n        :host > launcherbutton:before {\n            content: "𝍖";\n            display: flex;\n            font-size: 21px;\n            padding: 3px 14px;\n            cursor: pointer;\n        }\n        :host > label {\n            font-size: 18px;\n            padding-right: 24px;\n            line-height: 32px;\n        }\n        :host > tablist {\n            display: flex;\n        }\n        :host > tablist > tab {\n            padding: 0 12px;\n            line-height: 30px;\n            border-style: solid;\n            border-width: 3px 0;\n            border-color: transparent;\n            margin-bottom: -3px;\n        }\n        :host > tablist > tab > a, \n        :host > tablist > tab > a:hover {\n            text-decoration: none;\n            color: #080707;\n            padding: 0 12px;\n            line-height: 30px;\n            margin: 0 -12px;\n            display: block;\n        }\n        :host > tablist > tab:hover {\n            border-bottom-color: rgba(0, 0, 0, 0.4);\n            background-color: rgba(0, 112, 210, 0.1);\n        }\n        :host > tablist > tab[selected] {\n            border-top-color: #0070d2;\n            background-color: rgba(0, 112, 210, 0.1);\n        }\n    </style>\n    `;\n\n    class GlobalNav extends HTMLElement {\n\n        static get observedAttributes() {\n            return ['selectedurl'];\n        }\n\n        constructor() {\n            super();\n            this.tabs = [];\n            this.attachShadow({mode: 'open'});\n            this.shadowRoot.appendChild(template.content.cloneNode(true));\n            this.launcherButton = document.createElement('launcherbutton');\n            this.launcherButton.addEventListener('click', () => { location.href = '/'; });\n            this.shadowRoot.appendChild(this.launcherButton);\n            this.label = document.createElement('label');\n            this.label.innerHTML = 'Setup';\n            this.shadowRoot.appendChild(this.label);\n            this.tabList = document.createElement('tablist');\n            this.shadowRoot.appendChild(this.tabList);\n        }\n\n        async connectedCallback() {\n            var tabs = await (await fetch('/api-data/list/tabs')).json();\n            tabs.sort((t1, t2) => t1.label > t2.label ? 1 : -1);\n            for (var tab of tabs) {\n                tab.tabElement = this.addTab(tab);\n                this.tabs.push(tab);\n            }\n            if (this.selectedurl) this.setselectedurl(this.selectedurl);\n        }\n\n        setselectedurl(selectedurl) {\n            this.selectedurl = selectedurl;\n            for (var tab of this.tabs) {\n                if (tab.url === selectedurl) {\n                    tab.tabElement.setAttribute('selected', 'selected');\n                } else {\n                    tab.tabElement.removeAttribute('selected');\n                }\n            }\n        }\n\n        attributeChangedCallback(name, _, newValue) {\n            if (name === 'selectedurl') this.setselectedurl(newValue);\n        }\n\n        addTab(tab) {\n            var tabElement = document.createElement('tab');\n            var a = document.createElement('a');\n            a.innerHTML = tab.label;\n            a.setAttribute('href', tab.url);\n            tabElement.appendChild(a);\n            this.tabList.appendChild(tabElement);\n            return tabElement;\n        }\n\n    }\n\n    window.customElements.define('cc-globalnav', GlobalNav);\n\n})();	text/javascript	/ccc/cc-globalnav	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
d07d257b-89f0-40b9-9ddf-865f12422d3f	// Liste von Apps auf Startseite\n(function() {\n\n    var template = document.createElement('template');\n    template.innerHTML = `\n    <style>\n        :host {\n            display: flex;\n            align-items: center;\n            margin: auto;\n            align-self: center;\n        }\n        :host > a {\n            padding: .5rem;\n            border-radius: .25rem;\n            border: 1px solid #dddbda;\n            box-shadow: 0 2px 2px rgba(0,0,0,.05);\n            margin: 1rem;\n            background: #fff;\n            cursor: pointer;\n            display: flex;\n            width: 250px;\n            height: 125px;\n            text-decoration: none;\n            color: #080707;\n            position: relative;\n        }\n        :host > a:hover {\n            border: 1px solid #1589ee;\n            box-shadow: inset 0 0 0 1px #1589ee;\n        }\n        :host > a > symbol {\n            display: flex;\n            justify-content: center;\n            margin: auto 14px auto 6px;\n            color: #fff;\n            font-size: 1.5rem;\n            font-weight: 400;\n            background-color: #706e6b;\n            border-radius: .25rem;\n            width: 48px;\n            height: 48px;\n            line-height: 48px;\n        }\n        :host > a > content {\n            padding: 0 .75rem;\n            flex: 1;\n            margin: auto;\n            max-height: 100%;\n        }\n        :host > a > content::before {\n            content: '';\n            background-color: #dddbda;\n            display: block;\n            width: 1px;\n            position: absolute;\n            top: .75rem;\n            bottom: .75rem;\n            left: 76px;\n        }\n        :host > a:hover > content::before {\n            background-color: #1589ee;\n        }\n        :host > a > content > h1 {\n            margin: 0;\n            padding: 0;\n            font-size: 1rem;\n            font-weight: 700;\n        }\n        :host > a > content > p {\n            margin: 0;\n            padding: 0;\n            font-size: .75rem;\n            line-height: 1.5;\n            color: #3e3e3c;\n            overflow: hidden;\n            display: -webkit-box;\n            -webkit-line-clamp: 5;\n            -webkit-box-orient: vertical;\n        }\n    </style>\n    `;\n\n    class AppList extends HTMLElement {\n\n        constructor() {\n            super();\n            this.attachShadow({mode: 'open'});\n            this.rootElement = template.content.cloneNode(true);\n            this.shadowRoot.appendChild(this.rootElement);\n        }\n\n        // Event wird ausgelöst, wenn Komponente in HTML eingefügt wird\n        async connectedCallback() {\n            var apps = await (await fetch('/api-data/list/apps')).json();\n            apps.sort((first, second) => first.label > second.label ? 1 : -1);\n            for (var app of apps) this.addApp(app);\n        }\n\n        addApp(app) {\n            var appElement = document.createElement('a');\n            appElement.href = app.url;\n            appElement.app = app;\n            var initialen = app.label.split(' ').map(i => i.substring(0, 1));\n            console.log(app.label, initialen);\n            appElement.innerHTML = '<symbol>' + initialen + '</symbol><content><h1>' + app.label + '</h1><p>' + app.description + '</p></content>';\n            this.shadowRoot.appendChild(appElement);\n        }\n\n    }\n\n    window.customElements.define('cc-applist', AppList);\n\n})();	text/javascript	/ccc/cc-applist	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
3fb94059-5ed1-435a-9d9f-cec39a5fe86f	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="/assets/slds.css">\n        <script>\n\n            async function register(evt) {\n                var username = evt.target.username.value;\n                var password = evt.target.password.value;\n                evt.preventDefault();\n                var result = await (await fetch('/api-auth/register', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ username: username, password: password }) })).json();\n                console.log(result);\n            }\n\n            function init() {\n                document.querySelector('form').addEventListener('submit', register);\n            }\n\n            window.addEventListener('load', init);\n\n        </script>\n    </head>\n    <body>\n        <login-form>\n            <form method="POST" action="#">\n                <form-title>Registrierung</form-title>\n                <input-field>\n                    <input name="username" type="text" placeholder="Benutzername" />\n                    <label>Benutzername</label>\n                </input-field>\n                <input-field>\n                    <input name="password" type="text" placeholder="Passwort" />\n                    <label>Passwort</label>\n                </input-field>\n                <button-row>\n                    <button type="submit">Registrieren</button>\n                    <a href="/login">Anmelden</a>\n                </button-row>\n            </form>\n        </login-form>\n    </body>\n</html>	text/html	/register	6f6b93ae-94e5-45b0-904f-83a8b37e1627	t
\.


--
-- Name: packages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudcore
--

SELECT pg_catalog.setval('public.packages_id_seq', 1, false);


--
-- Name: routers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudcore
--

SELECT pg_catalog.setval('public.routers_id_seq', 6, true);


--
-- Name: tabs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudcore
--

SELECT pg_catalog.setval('public.tabs_id_seq', 2, true);


--
-- Name: views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudcore
--

SELECT pg_catalog.setval('public.views_id_seq', 26, true);


--
-- Name: apps apps_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.apps
    ADD CONSTRAINT apps_pkey PRIMARY KEY (id);


--
-- Name: packageentities packageentities_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.packageentities
    ADD CONSTRAINT packageentities_pkey PRIMARY KEY (id);


--
-- Name: packagefields packagefields_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.packagefields
    ADD CONSTRAINT packagefields_pkey PRIMARY KEY (id);


--
-- Name: routers routers_url_key; Type: CONSTRAINT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.routers
    ADD CONSTRAINT routers_url_key UNIQUE (url);


--
-- Name: routers routers_url_key1; Type: CONSTRAINT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.routers
    ADD CONSTRAINT routers_url_key1 UNIQUE (url);


--
-- Name: routers routers_url_key2; Type: CONSTRAINT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.routers
    ADD CONSTRAINT routers_url_key2 UNIQUE (url);


--
-- Name: users username; Type: CONSTRAINT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT username UNIQUE (username);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: views views_url_key; Type: CONSTRAINT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_url_key UNIQUE (url);


--
-- Name: views views_url_key1; Type: CONSTRAINT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_url_key1 UNIQUE (url);


--
-- Name: views views_url_key2; Type: CONSTRAINT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_url_key2 UNIQUE (url);


--
-- PostgreSQL database dump complete
--

