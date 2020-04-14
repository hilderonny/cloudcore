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
    name text
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
    url text
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
    label text
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
-- Name: test; Type: TABLE; Schema: public; Owner: cloudcore
--

CREATE TABLE public.test (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "boolean" boolean,
    "int" integer,
    json json,
    "numeric" numeric,
    "real" real,
    text text,
    uuid uuid
);


ALTER TABLE public.test OWNER TO cloudcore;

--
-- Name: views; Type: TABLE; Schema: public; Owner: cloudcore
--

CREATE TABLE public.views (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    content text,
    contenttype text,
    url text
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
-- Data for Name: packageentities; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.packageentities (id, tablename, packageid, entityid) FROM stdin;
57a1ff1f-454e-493a-8a2e-b990713d2342	views	f9c96884-4637-4a7e-b8ef-104d9a7bf93b	9c8c25ec-2fe7-4ad3-bd63-1935f743e1cd
b59d1a9e-cd67-4051-851f-8c8bac247572	routers	f9c96884-4637-4a7e-b8ef-104d9a7bf93b	80e51228-ea90-47b7-955e-c486ccfc8caa
39fc876c-e261-41f8-9ad4-94594e38e3ba	views	f9c96884-4637-4a7e-b8ef-104d9a7bf93b	52cf145b-f648-4f4a-85af-d9086b51764b
\.


--
-- Data for Name: packagefields; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.packagefields (id, fieldname, tablename, packageid) FROM stdin;
905a5187-15ef-49b9-a26a-e41e772bf9e5	label	tabs	f9c96884-4637-4a7e-b8ef-104d9a7bf93b
d7d1b0a3-ef81-4f4b-bab7-a6f02b6f2fe7	name	packages	f9c96884-4637-4a7e-b8ef-104d9a7bf93b
94b3561d-e88e-4e4e-ac5f-a06df09ad295	packageid	packageentities	f9c96884-4637-4a7e-b8ef-104d9a7bf93b
f8539966-ab0e-4075-a053-526132481170	entityid	packageentities	f9c96884-4637-4a7e-b8ef-104d9a7bf93b
\.


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.packages (id, name) FROM stdin;
f9c96884-4637-4a7e-b8ef-104d9a7bf93b	tp
\.


--
-- Data for Name: routers; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.routers (id, code, url) FROM stdin;
d2e9ebbe-e7de-4be4-96e9-bf75c835f665	var router = require('express').Router();\n\nrouter.get('/hubbele/:tablename', async (req, res) => {\n    var result = await req.db.query("SELECT * FROM information_schema.tables WHERE table_name = $1;", [req.params.tablename]);\n    res.json(result.rows);\n});\n\nrouter.get('/eins', async (req, res) => {\n    res.send("ODIN");\n});\n\nrouter.get('/zwei/:zahl', async (req, res) => {\n    res.send("TWO " + req.params.zahl);\n});\n\nmodule.exports = router;\n	/fubbele
0d689490-685b-4260-9bc5-7ab712666b6e	/**\r\n * Dieser Router soll Datenbankbackups erstellen.\r\n */\r\nvar childprocess = require('child_process');\r\nvar router = require('express').Router();\r\n\r\nrouter.get('/', (_, res) => {\r\n    var resultbuffer = childprocess.execSync('pg_dump'); // Benutzt die Einstellungen aus den Environment Variablen\r\n    res.setHeader("Content-Type","text/plain");\r\n    res.send(resultbuffer);\r\n});\r\n\r\nmodule.exports = router;\r\n	/backup
80e51228-ea90-47b7-955e-c486ccfc8caa	var router = require('express').Router();\n\n// Tabellen\n\n// GET /api/tables/\nrouter.get('/', async (req, res) => {\n    var result = await req.db.query("SELECT * FROM information_schema.tables WHERE table_schema != 'pg_catalog' AND table_schema != 'information_schema';");\n    res.json(result.rows);\n});\n\n// POST /api/tables/:tablename\nrouter.post('/:tablename', async (req, res) => {\n    res.json(await req.db.query("CREATE TABLE " + req.params.tablename + " (id UUID PRIMARY KEY DEFAULT uuid_generate_v4());"));\n});\n\nmodule.exports = router;	/api-tables
c11bd450-76b4-45cb-afce-619cbdcaadd6	var router = require('express').Router();\n\nrouter.post('/', async (req, res) => {\n    var query = req.body.query;\n    var result = await req.db.query(query);\n    res.json(result.error ? result.error : result.rows);\n});\n\nmodule.exports = router;	/api-sqlconsole
a3a9d900-6fa8-4818-8838-4a4f41a2caab	// select table_name, column_name from information_schema.columns where table_schema='public' and not column_name = 'id';\nvar router = require('express').Router();\n\nrouter.get('/allfields', async (req, res) => {\n    var result = await req.db.query("select table_name, column_name from information_schema.columns where table_schema='public' and not column_name = 'id';");\n    var tablemap = {};\n    for (var row of result.rows) {\n        if (!tablemap[row.table_name]) tablemap[row.table_name] = [];\n        tablemap[row.table_name].push(row.column_name);\n    }\n    res.json(tablemap);\n});\n\nrouter.get('/packagefields/:packageid', async (req, res) => {\n    var result = await req.db.query("select * from packagefields where packageid = '" + req.params.packageid + "';");\n    res.json(result.error || result.rows);\n});\n\nrouter.get('/packageentities/:packageid', async (req, res) => {\n    var result = await req.db.query("select * from packageentities where packageid = '" + req.params.packageid + "';");\n    res.json(result.error || result.rows);\n});\n\nrouter.delete('/:packageid', async (req, res) => {\n    await req.db.query("DELETE FROM packagefields WHERE packageid = '" + req.params.packageid + "';");\n    await req.db.query("DELETE FROM packageentities WHERE packageid = '" + req.params.packageid + "';");\n    await req.db.query("DELETE FROM packages WHERE id = '" + req.params.packageid + "';");\n    res.send();\n});\n\nrouter.get('/download/:packageid', async (req, res) => {\n    var packageid = req.params.packageid;\n    var json = { entities: {} };\n    var package = (await req.db.query("select id, name from packages where id='" + packageid + "';")).rows[0];\n    json.id = package.id;\n    json.name = package.name;\n    var packagefields = (await req.db.query("select tablename, fieldname from packagefields where packageid = '" + req.params.packageid + "';")).rows.reduce((map, field) => {\n        if (Object.keys(map).indexOf(field.tablename) < 0) map[field.tablename] = [];\n        map[field.tablename].push(field.fieldname);\n        return map;\n    }, {});\n    var columndefs = (await req.db.query("select column_name, table_name, data_type from information_schema.columns where table_schema='public';")).rows.reduce((map, column) => {\n        if (packagefields[column.table_name] && packagefields[column.table_name].indexOf(column.column_name) >= 0) {\n            if (Object.keys(map).indexOf(column.table_name) < 0) map[column.table_name] = {};\n            map[column.table_name][column.column_name] = column.data_type;\n        }\n        return map;\n    }, {});\n    json.fields = columndefs;\n    var packageentities = (await req.db.query("select tablename, entityid from packageentities where packageid = '" + req.params.packageid + "';")).rows.reduce((map, entity) => {\n        if (Object.keys(map).indexOf(entity.tablename) < 0) map[entity.tablename] = [];\n        map[entity.tablename].push(entity.entityid);\n        return map;\n    }, {});\n    for (var [tablename, entityids] of Object.entries(packageentities)) {\n        var query = "select * from \\"" + tablename + "\\" where id in (" + entityids.map(id => "'" + id + "'").join(',') + ");";\n        json.entities[tablename] = (await req.db.query(query)).rows;\n    }\n    res.json(json);\n});\n\nmodule.exports = router;	/api-packages
\.


--
-- Data for Name: tabs; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.tabs (id, url, label) FROM stdin;
cae375cc-28f5-4fbe-97a3-a3175a28b924	/setup/tables	Tabellen
da5b9bd2-2784-4a74-bf07-f32281efb363	/setup/editor	Editor
4b380de5-7264-4a52-81aa-ee83e4160176	/setup/packages	Pakete
10da6bd3-e1f8-4eb3-8251-148ccd08efbc	/setup/sqlconsole	SQL Konsole
\.


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.test (id, "boolean", "int", json, "numeric", "real", text, uuid) FROM stdin;
47f43c75-f042-46d5-9f2b-ecffff33f2c3	t	1234	{"a":"b","c":234}	123.45	1.23450005	hullu bullu	963477e8-b1e7-41c9-9eb8-b843b9313efc
\.


--
-- Data for Name: views; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.views (id, content, contenttype, url) FROM stdin;
c7f65743-ccc5-4dce-86ec-6ace01fb01c6	<p><a href="/vger">VGER</a></p>\n<p><a href="/setup/editor">Editor</a></p>\n<p><a href="/setup/tables">Tabellen</a></p>\n	text/html	/
b344c26c-d088-4116-ab52-035cdde82a9e	// Siehe https://developers.google.com/web/updates/2017/01/webcomponents-org\n// Und https://googlechromelabs.github.io/howto-components/howto-checkbox/#demo\n// ccc steht für CloudCoreComponent\n(function() {\n\n    var template = document.createElement('template');\n    template.innerHTML = `\n    <style>\n        :host {\n            border-bottom: 3px solid #0070d2;\n            display: flex;\n            background-color: white;\n        }\n        :host > launcherbutton:before {\n            content: "⸬";\n            display: flex;\n            font-size: 21px;\n            padding: 0 14px;\n        }\n        :host > label {\n            font-size: 18px;\n            padding-right: 24px;\n            line-height: 32px;\n        }\n        :host > tablist {\n            display: flex;\n        }\n        :host > tablist > tab {\n            padding: 0 12px;\n            line-height: 30px;\n            border-style: solid;\n            border-width: 3px 0;\n            border-color: transparent;\n            margin-bottom: -3px;\n        }\n        :host > tablist > tab > a, \n        :host > tablist > tab > a:hover {\n            text-decoration: none;\n            color: #080707;\n            padding: 0 12px;\n            line-height: 30px;\n            margin: 0 -12px;\n            display: block;\n        }\n        :host > tablist > tab:hover {\n            border-bottom-color: rgba(0, 0, 0, 0.4);\n            background-color: rgba(0, 112, 210, 0.1);\n        }\n        :host > tablist > tab[selected] {\n            border-top-color: #0070d2;\n            background-color: rgba(0, 112, 210, 0.1);\n        }\n    </style>\n    `;\n\n    class GlobalNav extends HTMLElement {\n\n        static get observedAttributes() {\n            return ['selectedurl'];\n        }\n\n        constructor() {\n            super();\n            this.tabs = [];\n            this.attachShadow({mode: 'open'});\n            this.shadowRoot.appendChild(template.content.cloneNode(true));\n            this.launcherButton = document.createElement('launcherbutton');\n            this.shadowRoot.appendChild(this.launcherButton);\n            this.label = document.createElement('label');\n            this.label.innerHTML = 'Setup';\n            this.shadowRoot.appendChild(this.label);\n            this.tabList = document.createElement('tablist');\n            this.shadowRoot.appendChild(this.tabList);\n        }\n\n        async connectedCallback() {\n            var tabs = await (await fetch('/api/data/list/tabs')).json();\n            tabs.sort((t1, t2) => t1.label > t2.label ? 1 : -1);\n            for (var tab of tabs) {\n                tab.tabElement = this.addTab(tab);\n                this.tabs.push(tab);\n            }\n            if (this.selectedurl) this.setselectedurl(this.selectedurl);\n        }\n\n        setselectedurl(selectedurl) {\n            this.selectedurl = selectedurl;\n            for (var tab of this.tabs) {\n                if (tab.url === selectedurl) {\n                    tab.tabElement.setAttribute('selected', 'selected');\n                } else {\n                    tab.tabElement.removeAttribute('selected');\n                }\n            }\n        }\n\n        attributeChangedCallback(name, _, newValue) {\n            if (name === 'selectedurl') this.setselectedurl(newValue);\n        }\n\n        addTab(tab) {\n            var tabElement = document.createElement('tab');\n            var a = document.createElement('a');\n            a.innerHTML = tab.label;\n            a.setAttribute('href', tab.url);\n            tabElement.appendChild(a);\n            this.tabList.appendChild(tabElement);\n            return tabElement;\n        }\n\n    }\n\n    window.customElements.define('cc-globalnav', GlobalNav);\n\n})();	text/javascript	/ccc/cc-globalnav
d4d1f905-b12a-4d78-b6e7-0820d8ba4de4	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            var tablename;\r\n\r\n            function createcolumn() {\r\n                location.href = '/setup/tables/columns/create?' + tablename;\r\n            }\r\n\r\n            async function deletecolumn(columnname) {\r\n                if (!confirm('Really delete column "' + columnname + '"?')) return;\r\n                await fetch('/api/schema/columns/' + tablename + '/' + columnname, { method: 'DELETE' });\r\n                loadcolumns();\r\n            }\r\n\r\n            async function loadcolumns() {\r\n                var columns = await (await fetch('/api/schema/columns/' + tablename)).json();\r\n                var tbody = document.querySelector('tbody');\r\n                tbody.innerHTML = '';\r\n                for (var column of columns) {\r\n                    if (column.table_schema !== 'public') continue;\r\n                    var tr = document.createElement('tr');\r\n                    tr.innerHTML = '<td>' + column.column_name + '</td><td>' + column.data_type + '</td><td><a href="#" onclick="deletecolumn(\\'' + column.column_name + '\\');">Delete</a></td>';\r\n                    tbody.appendChild(tr);\r\n                }\r\n            }\r\n\r\n            window.addEventListener('load', () => {\r\n                tablename = location.search.substring(1);\r\n                document.getElementById('tablename').innerHTML = tablename;\r\n                loadcolumns();\r\n            });\r\n        \r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup &gt; <a href="/setup/tables">Tabellen</a></subtitle>\r\n            <page-title><span id="tablename"></span> - Spalten</page-title>\r\n            <button onclick="createcolumn();">Neue Spalte</button>\r\n        </header>\r\n        <content>\r\n            <table>\r\n                <thead><tr><th>Name</th><th>Datentyp</th><th></th></tr></thead>\r\n                <tbody></tbody>\r\n            </table>\r\n        </content>\r\n    </body>\r\n</html>\r\n	text/html	/setup/tables/columns
bac21733-0859-4457-a613-9300d7ec3de7	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            async function createtable() {\r\n                var tablename = window.prompt('Name der neuen Tabelle');\r\n                if(!tablename) return;\r\n                await fetch('/api/schema/tables/' + tablename, { method: 'POST' });\r\n                loadtables();\r\n            }\r\n\r\n            async function deletetable(tablename) {\r\n                if (!confirm('Soll die Tabelle "' + tablename + '" wirklich gelöscht werden?')) return;\r\n                await fetch('/api/schema/tables/' + tablename, { method: 'DELETE' });\r\n                loadtables();\r\n            }\r\n\r\n            async function loadtables() {\r\n                var tables = await (await fetch('/api/schema/tables')).json();\r\n                tables.sort((a, b) => a.table_name > b.table_name ? 1 : -1);\r\n                var tbody = document.querySelector('tbody');\r\n                tbody.innerHTML = '';\r\n                for (var table of tables) {\r\n                    var tr = document.createElement('tr');\r\n                    tr.innerHTML = '<td>' + table.table_name + '</td><td><a href="/setup/tables/content?' + table.table_name + '">Daten</a></td><td><a href="/setup/tables/columns?' + table.table_name + '">Felder</a></td><td><a href="#" onclick="deletetable(\\'' + table.table_name + '\\');">Löschen</a></td>';\r\n                    tbody.appendChild(tr);\r\n                }\r\n            }\r\n\r\n            window.addEventListener('load', loadtables);\r\n\r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup</subtitle>\r\n            <page-title>Tabellen</page-title>\r\n            <button onclick="createtable();">Neue Tabelle</button>\r\n            <button onclick="window.open('/backup/', '_blank');">Dump</button>\r\n        </header>\r\n        <content>\r\n            <table>\r\n                <thead><tr><th>Name</th><th></th><th></th><th></th></tr></thead>\r\n                <tbody></tbody>\r\n            </table>\r\n        </content>\r\n    </body>\r\n</html>	text/html	/setup/tables
9c8c25ec-2fe7-4ad3-bd63-1935f743e1cd	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="/assets/slds.css">\n        <script src="/ccc/cc-globalnav"></script>\n        <script src="/monaco-editor/min/vs/loader.js"></script>\n        <script>\n        var monacoEditor;\n        var currentView;\n        var currentRouter;\n\n        function openInNewTab() {\n            if (!currentView) return;\n            window.open(currentView.url, '_blank');\n        }\n\n        async function del() {\n            if (currentView) {\n                if (!confirm('Soll die View wirklich gelöscht werden?')) return;\n                await fetch('/api/data/views/' + currentView.id, { method: 'DELETE' });\n                location.href = '?';\n            } else if (currentRouter) {\n                if (!confirm('Soll der Router wirklich gelöscht werden?')) return;\n                await fetch('/api/data/routers/' + currentRouter.id, { method: 'DELETE' });\n                location.href = '?';\n            }\n        }\n\n        async function createView() {\n            var url = prompt('Welche URL?', '/');\n            if (!url) return;\n            var contenttype = prompt('Welcher Content Type?', 'text/html');\n            if (!contenttype) return;\n            var id = (await (await fetch('/api/data/views', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ url: url, contenttype: contenttype, content: '' }) })).json())[0].id;\n            location.href = '?views/' + id;\n        }\n\n        async function createRouter() {\n            var url = prompt('Welche URL?', '/');\n            if (!url) return;\n            var id = (await (await fetch('/api/data/routers', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ url: url, code: '' }) })).json())[0].id;\n            location.href = '?routers/' + id;\n        }\n\n        async function save() {\n            if (currentView) {\n                var content = monacoEditor.getValue();\n                await fetch('/api/data/views/' + currentView.id, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ content: content }) });\n            } else if (currentRouter) {\n                var code = monacoEditor.getValue();\n                await fetch('/api/data/routers/' + currentRouter.id, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ code: code }) });\n            }\n            var button = document.querySelector('#savebutton');\n            button.classList.add('green');\n            setTimeout(() => {\n                button.classList.remove('green');\n            }, 1000);\n        }\n\n        async function loadView(id) {\n            currentRouter = false;\n            currentView = (await (await fetch('/api/data/views/' + id)).json())[0];\n            monacoEditor.setValue(currentView.content);\n            var language = monaco.languages.getLanguages().find(l => l.mimetypes && (l.mimetypes.indexOf(currentView.contenttype) >= 0));\n            monaco.editor.setModelLanguage(monacoEditor.getModel(), language ? language.id : 'plaintext');\n            document.querySelectorAll('content table .selected').forEach(e => e.classList.remove('selected'));\n            document.getElementById('view-' + id).classList.add('selected');\n            window.history.pushState(null, null, '?views/' + id);\n        }\n\n        async function loadRouter(id) {\n            currentView = false;\n            currentRouter = (await (await fetch('/api/data/routers/' + id)).json())[0];\n            monacoEditor.setValue(currentRouter.code);\n            monaco.editor.setModelLanguage(monacoEditor.getModel(), 'javascript');\n            document.querySelectorAll('content table .selected').forEach(e => e.classList.remove('selected'));\n            document.getElementById('router-' + id).classList.add('selected');\n            window.history.pushState(null, null, '?routers/' + id);\n        }\n\n        async function listViewsAndRouters() {\n            var views = await (await fetch('/api/data/list/views/id,url')).json();\n            views.sort((v1, v2) => v1.url > v2.url ? 1 : -1);\n            var viewlist = document.getElementById('views');\n            viewlist.innerHTML = '';\n            for (var view of views) {\n                viewlist.innerHTML += '<tr id="view-' + view.id + '"><td><a href="#" onclick="loadView(\\'' + view.id + '\\');">' + view.url + '</a></td></tr>';\n            }\n            var routers = await (await fetch('/api/data/list/routers/id,url')).json();\n            routers.sort((r1, r2) => r1.url > r2.url ? 1 : -1);\n            var routerlist = document.getElementById('routers');\n            routerlist.innerHTML = '';\n            for (var router of routers) {\n                routerlist.innerHTML += '<tr id="router-' + router.id + '"><td><a href="#" onclick="loadRouter(\\'' + router.id + '\\');">' + router.url + '</a></td></tr>';\n            }\n        }\n\n        window.addEventListener('load', function() {\n            // MonacoEditor initialisieren\n            require.config({ paths: { 'vs': '/monaco-editor/min/vs' }});\n            require(['vs/editor/editor.main'], function() {\n                monacoEditor = monaco.editor.create(document.getElementById('editor'));\n                if (location.search.length > 1) {\n                    var parts = location.search.substring(1).split('/');\n                    if (parts[0] === 'views') {\n                        loadView(parts[1]);\n                    } else {\n                        loadRouter(parts[1]);\n                    }\n                };\n                monacoEditor.addCommand(monaco.KeyMod.CtrlCmd | monaco.KeyCode.KEY_S, save);\n            });        \n            listViewsAndRouters();\n        });\n\n        window.addEventListener('resize', function() {\n            if (monacoEditor) monacoEditor.layout();\n        });\n\n        </script>\n    </head>\n    <body>\n        <cc-globalnav selectedurl="/setup/editor"></cc-globalnav>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/code/v4/24px.svg"/>\n            <subtitle>Setup</subtitle>\n            <page-title>Editor</page-title>\n            <button onclick="createView();">+ View</button>\n            <button onclick="createRouter();">+ Router</button>\n            <button onclick="save();" id="savebutton">Speichern</button>\n            <button onclick="del();">Löschen</button>\n            <button onclick="openInNewTab();">Öffnen</button>\n            <button>\n                <select onchange="monaco.editor.setTheme(this.value);">\n                    <option value="vs">Hell</option>\n                    <option value="vs-dark">Dunkel</option>\n                    <option value="hc-black">Hoher Kontrast</option>\n                </select>\n            </button>\n        </header>\n        <columns class="two-fix-flex">\n            <content style="width:300px;">\n                <table>\n                    <thead><tr><th>Views</th></tr></thead>\n                    <tbody id="views"></tbody>\n                </table>\n                <table>\n                    <thead><tr><th>Routers</th></tr></thead>\n                    <tbody id="routers"></tbody>\n                </table>\n            </content>\n            <content id="editor" style="overflow: hidden;"></content>\n        </columns>\n    </body>\n</html>	text/html	/setup/editor
77c30dd7-0131-425b-a264-2150d0615f02	html,\r\nbody {\r\n    margin: 0;\r\n    padding: 0;\r\n    width: 100%;\r\n    height: 100%;\r\n    overflow: hidden;\r\n}\r\nbody {\r\n    display: flex;\r\n    flex-direction: column;\r\n    font-family: sans-serif;\r\n    font-size: 13px;\r\n    color: #080707;\r\n    background-image: url(https://www.lightningdesignsystem.com/assets/images/themes/oneSalesforce/banner-brand-default.png), linear-gradient(0, rgba(176, 196, 223, 1), 85%, #195594);\r\n    background-repeat: repeat-x;\r\n    position: relative;\r\n    overflow: auto;\r\n}\r\nbody::after {\r\n    content: "";\r\n    background-image: linear-gradient(0, rgba(176, 196, 223, 1), 90%, transparent\r\n    );\r\n    height: 100%;\r\n    top: 0;\r\n    position: absolute;\r\n    left: 0;\r\n    width: 100%;\r\n    z-index: -1;\r\n}\r\na {\r\n    color: rgb(0, 109, 204);\r\n    text-decoration: none;\r\n}\r\na:hover {\r\n    text-decoration: underline;\r\n}\r\nheader {\r\n    margin: 12px 12px 0 12px;\r\n    border-radius: 4px;\r\n    border: 1px solid #ccc;\r\n    box-shadow: 1px 1px 3px -1px rgba(0, 0, 0, 0.5);\r\n    padding: 16px;\r\n    background-color: rgb(243, 242, 242);\r\n    display: flex;\r\n    position: relative;\r\n}\r\nheader > img {\r\n    filter: invert(1);\r\n    background-color: coral;\r\n    border-radius: 3px;\r\n    padding: 7px;\r\n    margin-right: 16px;\r\n}\r\nheader > page-title {\r\n    display: block;\r\n    flex: 1;\r\n    font-size: 18px;\r\n    font-weight: bold;\r\n    line-height: 38px;\r\n    overflow: hidden;\r\n    white-space: nowrap;\r\n    text-overflow: ellipsis;\r\n}\r\nheader > subtitle {\r\n    position: absolute;\r\n    left: 70px;\r\n    color: rgb(62, 62, 60);\r\n}\r\nheader > subtitle + page-title {\r\n    line-height: 22px;\r\n    margin-top: 16px;\r\n}\r\nheader > button {\r\n    background-color: #fff;\r\n    padding: 0 16px;\r\n    border: solid rgb(221, 219, 218);\r\n    line-height: 30px;\r\n    margin: 4px 0;\r\n    border-width: 1px 1px 1px 0;\r\n    color: rgb(27, 82, 151);\r\n    font-size: 13px;\r\n    cursor: pointer;\r\n}\r\nheader > button > select {\r\n    border: none;\r\n    display: block;\r\n    background-color: transparent;\r\n    padding: 7px 16px;\r\n    margin: 0 -16px;\r\n    color: rgb(27, 82, 151);    \r\n}\r\nheader > button:hover {\r\n    background-color: rgb(243, 242, 242);\r\n}\r\nheader > button:first-of-type {\r\n    border-left-width: 1px;\r\n    border-top-left-radius: 4px;\r\n    border-bottom-left-radius: 4px;\r\n    margin-left: 16px;\r\n}\r\nheader > button:last-of-type {\r\n    border-right-width: 1px;\r\n    border-top-right-radius: 4px;\r\n    border-bottom-right-radius: 4px;\r\n}\r\ncolumns {\r\n    display: flex;\r\n    flex: 1;\r\n}\r\ncolumns.two-fix-flex > *:first-child {\r\n    flex: unset;\r\n    margin-right: 0;\r\n}\r\ncontent {\r\n    margin: 12px 12px 0 12px;\r\n    border-radius: 4px;\r\n    border: 1px solid #ccc;\r\n    box-shadow: 1px 1px 3px -1px rgba(0, 0, 0, 0.5);\r\n    flex: 1;\r\n    overflow: auto;\r\n    background-color: #fff;\r\n}\r\ntable {\r\n    border-spacing: 0;\r\n    width: 100%;\r\n}\r\ntable > thead > tr > th,\r\ntable > tbody > tr > td {\r\n    padding: 4px 8px;\r\n    text-align: start;\r\n    overflow: hidden;\r\n    max-width: 0;\r\n    white-space: nowrap;\r\n    text-overflow: ellipsis;\r\n    border-bottom: 1px solid rgb(221, 219, 218);\r\n}\r\ntable > thead > tr > th > a,\r\ntable > tbody > tr > td > a {\r\n    display: block;\r\n    margin: -4px -8px;\r\n    padding: 4px 8px;\r\n}\r\ntable > thead > tr > th {\r\n    background-color: rgb(250, 250, 249);\r\n    line-height: 24px;\r\n}\r\ntable > tbody > tr > td {\r\n    line-height: 21px;\r\n}\r\ntable > tbody > tr:last-child > td {\r\n    border-bottom: none;\r\n}\r\ntable > tbody > tr:hover > td {\r\n    background-color: rgb(243, 242, 242);\r\n    box-shadow: rgb(221, 219, 218) 0px -1px 0px 0px inset, rgb(221, 219, 218) 0px 1px 0px 0px inset;\r\n}\r\ntable > tbody > tr > td:hover {\r\n    background-color: #fff;\r\n}\r\ntable > tbody > tr.selected > td {\r\n    background-color: rgb(243, 242, 242);\r\n}\r\ninput-field {\r\n    display: block;\r\n    position: relative;\r\n    padding: 22px 12px 0 12px;\r\n}\r\ninput-field > input {\r\n    display: block;\r\n    border: solid rgb(221, 219, 218);\r\n    width: 100%;\r\n    border-width: 0 0 1px 0;\r\n    font-size: 14px;\r\n    line-height: 22px;\r\n    padding: 0 4px;\r\n    box-sizing: border-box;\r\n}\r\ninput-field > select {\r\n    display: block;\r\n    width: 100%;\r\n    border: solid rgb(221, 219, 218);\r\n    border-width: 0 0 1px 0;\r\n    padding: 3px 4px 2px 4px;    \r\n}\r\ninput-field > textarea {\r\n    display: block;\r\n    border: 1px solid rgb(221, 219, 218);\r\n    border-radius: 4px;\r\n    font-size: 14px;\r\n    padding: 4px;\r\n    box-sizing: border-box;\r\n    min-width: 100%;\r\n    max-width: 100%;\r\n}\r\ninput-field > label {\r\n    position: absolute;\r\n    top: 8px;\r\n    left: 16px;\r\n    color: #ccc;\r\n    font-size: 11px;\r\n}\r\ninput-field > input::placeholder {\r\n    color: #ccc;\r\n}\r\ninput-field > input:placeholder-shown + label {\r\n    display: none;\r\n}\r\nbody > content:last-of-type,\r\nbody > columns:last-of-type {\r\n    margin-bottom: 12px;\r\n}\r\nbutton.green {\r\n    background-color:lightgreen;\r\n}\r\n.cols-2 {\r\n    columns: 2;\r\n    column-gap: 0;\r\n}\r\n	text/css	/assets/slds.css
52cf145b-f648-4f4a-85af-d9086b51764b	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="assets/slds.css">\n        <script src="/ccc/cc-globalnav"></script>\n    </head>\n    <body>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\n            <subtitle><a href="#">Setup</a> &gt; <a href="#">Setup</a> &gt; Setup</subtitle>\n            <page-title>Tables</page-title>\n            <button>New</button>\n        </header>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\n            <page-title>Title with very long text. I do not know how long it can get so stay away from me!</page-title>\n            <button>New</button>\n            <button>Save</button>\n            <button>Save</button>\n            <button>Delete</button>\n        </header>\n        <content>\n            <table>\n                <thead>\n                    <tr>\n                        <th>Header 1</th>\n                        <th>Header 2</th>\n                        <th>Header 3</th>\n                        <th>Header 4</th>\n                        <th>Header 5</th>\n                        <th>Header 6</th>\n                        <th>Header 7</th>\n                    </tr>\n                </thead>\n                <tbody>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                </tbody>\n            </table>\n        </content>\n        <content>\n            <input-field>\n                <input placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n        </content>\n        <content class="cols-2">\n            <input-field>\n                <input placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <select>\n                    <option value="integer">INTEGER</option>\n                    <option value="varchar" selected="">VARCHAR</option>\n                </select>\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <textarea></textarea>\n                <label>Fullibulli</label>\n            </input-field>\n        </content>\n    </body>\n</html>	text/html	/layouttest
6f3433f6-12ea-4f23-b121-2731bc26150e	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            var tablename;\r\n\r\n            async function createcolumn() {\r\n                var name = document.querySelector('#columnname').value;\r\n                var datatype = document.querySelector('#datatype').value;\r\n                await fetch('/api/schema/columns/' + tablename + '/' + name + '/' + datatype, { method: 'POST' });\r\n                location.href = '/setup/tables/columns?' + tablename;\r\n            }\r\n\r\n            window.addEventListener('load', () => {\r\n                tablename = location.search.substring(1);\r\n                document.getElementById('tablename').innerHTML = tablename;\r\n                document.getElementById('columnslink').setAttribute('href', '/setup/tables/columns?' + tablename);\r\n            });\r\n\r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup &gt; <a href="/setup/tables">Tabellen</a> &gt; <a href="#" id="columnslink"><span id="tablename"></span> - Spalten</a></subtitle>\r\n            <page-title>Neue Spalte</page-title>\r\n            <button onclick="createcolumn();">Erstellen</button>\r\n        </header>\r\n        <content>\r\n            <input-field>\r\n                <input id="columnname" placeholder="Name" />\r\n                <label>Name</label>\r\n            </input-field>\r\n            <input-field>\r\n                <select id="datatype">\r\n                    <option value="boolean">BOOLEAN</option>\r\n                    <option value="int">INT</option>\r\n                    <option value="json">JSON</option>\r\n                    <option value="numeric">NUMERIC</option>\r\n                    <option value="real">REAL</option>\r\n                    <option value="text" selected>TEXT</option>\r\n                    <option value="uuid">UUID</option>\r\n                </select>\r\n                <label>Datentyp</label>\r\n            </input-field>\r\n        </content>\r\n    </body>\r\n</html>\r\n	text/html	/setup/tables/columns/create
2ae98d59-3e80-4be4-aa65-822f11656514	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="/assets/slds.css">\n        <script src="/ccc/cc-globalnav"></script>\n        <script>\n\n            async function createpackage() {\n                var packagename = window.prompt('Name des neuen Paketes');\n                if(!packagename) return;\n                await fetch('/api/data/packages', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ name: packagename }) });\n                loadpackages();\n            }\n\n            async function deletepackage(id) {\n                if (!confirm('Soll das Paket mit der Id "' + id + '" wirklich gelöscht werden?')) return;\n                await fetch('/api-packages/' + id, { method: 'DELETE' });\n                loadpackages();\n            }\n\n            async function loadpackages() {\n                var packages = await (await fetch('/api/data/list/packages')).json();\n                packages.sort((a, b) => a.name > b.name ? 1 : -1);\n                var tbody = document.querySelector('tbody');\n                tbody.innerHTML = '';\n                for (var package of packages) {\n                    var tr = document.createElement('tr');\n                    tr.innerHTML = '<td>' + package.name + '</td><td><a href="/setup/packages/entities?' + package.id + '">Daten</a></td><td><a href="/setup/packages/fields?' + package.id + '">Felder</a></td><td><a href="#" onclick="deletepackage(\\'' + package.id + '\\');">Löschen</a></td><td><a href="/api-packages/download/' + package.id + '" target="_blank">Download</a></td>';\n                    tbody.appendChild(tr);\n                }\n            }\n\n            window.addEventListener('load', loadpackages);\n\n        </script>\n    </head>\n    <body>\n        <cc-globalnav selectedurl="/setup/packages"></cc-globalnav>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/local_shipping/v4/24px.svg"/>\n            <subtitle>Setup</subtitle>\n            <page-title>Pakete</page-title>\n            <button onclick="createpackage();">Neues Paket</button>\n        </header>\n        <content>\n            <table>\n                <thead><tr><th>Name</th><th></th><th></th><th></th><th></th></tr></thead>\n                <tbody></tbody>\n            </table>\n        </content>\n    </body>\n</html>	text/html	/setup/packages
7aa3d0b9-35cd-49f7-9db0-667a3b2a02a3	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            var tablename;\r\n\r\n            function createcontent() {\r\n                location.href = '/setup/tables/content/edit?' + tablename;\r\n            }\r\n\r\n            function htmlencode(str) {\r\n                return ('' + str).replace(/</g, '&lt;').replace(/>/g, '&gt;')\r\n            }\r\n\r\n            async function deletecontent(id) {\r\n                if (!confirm('Soll der Inhalt mit der Id "' + id + '" wirklich gelöscht werden?')) return;\r\n                await fetch('/api/data/' + tablename + '/' + id, { method: 'DELETE' });\r\n                loadcontent();\r\n            }\r\n\r\n            async function loadcontent() {\r\n                var content = await (await fetch('/api/data/list/' + tablename)).json();\r\n                var tbody = document.querySelector('tbody');\r\n                tbody.innerHTML = '';\r\n                console.log(content);\r\n                var columns = {};\r\n                var maxlength = 1000;\r\n                for (var entity of content) {\r\n                    var tr = document.createElement('tr');\r\n                    tbody.appendChild(tr);\r\n                    for (var key of Object.keys(entity)) {\r\n                        columns[key] = true;\r\n                    }\r\n                    tr.innerHTML = Object.values(entity).map(v => {\r\n                        var text = htmlencode(v && v.length > maxlength ? v.substring(0, maxlength) : v);\r\n                        return '<td title="' + text.replace(/\\"/g, '&quot;') + '">' + text + '</td>';\r\n                    }).join('');\r\n                    tr.innerHTML += '<td><a href="/setup/tables/content/edit?' + tablename + '/' + entity.id + '">Bearbeiten</a></td><td><a href="#" onclick="deletecontent(\\'' + entity.id + '\\');">Löschen</a></td>';\r\n                }\r\n                var thead = document.querySelector('thead');\r\n                thead.innerHTML = '<tr>' + Object.keys(columns).map(c => '<th>' + c + '</th>').join('') + '<th></th><th></th></tr>';\r\n            }\r\n\r\n            window.addEventListener('load', () => {\r\n                tablename = location.search.substring(1);\r\n                document.getElementById('tablename').innerHTML = tablename;\r\n                loadcontent();\r\n            });\r\n        \r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup &gt; <a href="/setup/tables">Tabellen</a></subtitle>\r\n            <page-title><span id="tablename"></span> - Inhalt</page-title>\r\n            <button onclick="createcontent();">Neuer Inhalt</button>\r\n        </header>\r\n        <content>\r\n            <table>\r\n                <thead></thead>\r\n                <tbody></tbody>\r\n            </table>\r\n        </content>\r\n    </body>\r\n</html>\r\n	text/html	/setup/tables/content
956dda69-6cc6-406a-aa38-75a021581cf6	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="/assets/slds.css">\n        <style>\n            textarea {\n                border: none;\n                width: 100%;\n                height: 100%;\n                padding: 4px;\n                font-family: monospace;\n                background-color: black;\n                color: lightgreen;\n                font-size: 14px;\n            }\n            #output {\n                white-space: pre;\n                font-family: monospace;\n            }\n        </style>\n        <script src="/ccc/cc-globalnav"></script>\n        <script>\n\n            async function run() {\n                var tf = document.getElementById('input');\n                var sql = tf.value;\n                var result = await (await fetch('/api-sqlconsole/', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ query: sql }) })).json();\n                var output = document.getElementById('output');\n                output.innerText = sql + '\\n\\n' + JSON.stringify(result, null, 2);\n                tf.focus();\n            }\n\n            window.addEventListener('load', () => { document.getElementById('input').focus(); });\n\n        </script>\n    </head>\n    <body>\n        <cc-globalnav selectedurl="/setup/sqlconsole"></cc-globalnav>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/local_shipping/v4/24px.svg"/>\n            <subtitle>Setup</subtitle>\n            <page-title>SQL Konsole</page-title>\n            <button onclick="run();">Ausführen</button>\n        </header>\n        <content>\n            <textarea id="input"></textarea>\n        </content>\n        <content id="output"></content>\n    </body>\n</html>	text/html	/setup/sqlconsole
81731013-bfd2-442e-85b2-5cf182da71cb	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="/assets/slds.css">\n        <script src="/ccc/cc-globalnav"></script>\n        <script>\n\n            var package, allfields;\n\n            function selecttable() {\n                var selectedtable = document.getElementById('tables').value;\n                var fieldsselect = document.getElementById('fields');\n                fieldsselect.innerHTML = '';\n                for (var field of allfields[selectedtable]) {\n                    fieldsselect.innerHTML += '<option value="' + field + '">' + field + '</option>';\n                }\n            }\n\n            async function addfield() {\n                var selectedtable = document.getElementById('tables').value;\n                var selectedfield = document.getElementById('fields').value;\n                await fetch('/api/data/packagefields', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ tablename: selectedtable, fieldname: selectedfield, packageid: package.id }) });\n                load();\n            }\n\n            async function deletepackagefield(id) {\n                await fetch('/api/data/packagefields/' + id, { method: 'DELETE' });\n                load();\n            }\n\n            async function load() {\n                var packageid = location.search.substring(1);\n                package = (await (await fetch('/api/data/packages/' + packageid)).json())[0];\n                document.getElementById('packagename').innerHTML = package.name;\n                allfields = await (await fetch('/api-packages/allfields')).json();\n                var tablesselect = document.getElementById('tables');\n                tablesselect.innerHTML = '';\n                for (table of Object.keys(allfields)) {\n                    tablesselect.innerHTML += '<option value="' + table + '">' + table + '</option>';\n                }\n                tablesselect.selectedIndex = 0;\n                selecttable();\n                var packagefields = await (await fetch('/api-packages/packagefields/' + packageid)).json();\n                packagefields.sort((a, b) => a.tablename === b.tablename ? (a.fieldname > b.fieldname ? 1 : -1) : (a.tablename > b.tablename ? 1 : -1));\n                var tbody = document.querySelector('tbody');\n                tbody.innerHTML = '';\n                for (var packagefield of packagefields) {\n                    var tr = document.createElement('tr');\n                    tr.innerHTML = '<td>' + packagefield.tablename + '</td><td>' + packagefield.fieldname + '</td><td><a href="#" onclick="deletepackagefield(\\'' + packagefield.id + '\\');">Löschen</a></td>';\n                    tbody.appendChild(tr);\n                }\n\n            }\n\n            window.addEventListener('load', load);\n\n        </script>\n    </head>\n    <body>\n        <cc-globalnav selectedurl="/setup/packages"></cc-globalnav>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/local_shipping/v4/24px.svg"/>\n            <subtitle>Setup &gt; <a href="/setup/packages">Pakete</a></subtitle>\n            <page-title><span id="packagename"></span> - Felder</page-title>\n            <button>\n                <select id="tables" onchange="selecttable();"></select>\n            </button>\n            <button>\n                <select id="fields"></select>\n            </button>\n            <button onclick="addfield();">Hinzufügen</button>\n        </header>\n        <content>\n            <table>\n                <thead><tr><th>Tabelle</th><th>Feld</th><th></th></tr></thead>\n                <tbody></tbody>\n            </table>\n        </content>\n    </body>\n</html>	text/html	/setup/packages/fields
a583b281-22f3-44fd-9db0-d4e2b9a1bc14	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            var tablename, entityid;\r\n\r\n            async function save() {\r\n                var content = {};\r\n                for (var key  of keys) {\r\n                    content[key] = document.getElementById(key).value;\r\n                }\r\n                if (entityid) {\r\n                    await fetch('/api/data/' + tablename + '/' + entityid, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(content) });\r\n                } else {\r\n                    entityid = (await (await fetch('/api/data/' + tablename, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(content) })).json())[0].id;\r\n                    location.href += '/' + entityid;\r\n                }\r\n            }\r\n\r\n            async function loadcontent() {\r\n                var content;\r\n                if (entityid) {\r\n                    content = (await (await fetch('/api/data/' + tablename + '/' + entityid)).json())[0];\r\n                } else {\r\n                    content = {};\r\n                    var columns = await (await fetch('/api/schema/columns/' + tablename)).json();\r\n                    for (var column of columns) {\r\n                        if (column.table_schema !== 'public') continue;\r\n                        content[column.column_name] = '';\r\n                    }\r\n                }\r\n                delete content.id;\r\n                var contentelement = document.querySelector('content');\r\n                contentelement.innerHTML = '';\r\n                keys = Object.keys(content);\r\n                for (var key of keys) {\r\n                    var inputfield = document.createElement('input-field');\r\n                    inputfield.innerHTML = '<textarea id="' + key + '"></textarea><label>' + key + '</label>';\r\n                    contentelement.appendChild(inputfield);\r\n                    var value = content[key];\r\n                    if (typeof(value) === 'object') value = JSON.stringify(value);\r\n                    document.getElementById(key).value = value;\r\n                }\r\n            }\r\n\r\n            window.addEventListener('load', () => {\r\n                var urlparts = location.search.substring(1).split('/');\r\n                tablename = urlparts[0];\r\n                entityid = urlparts[1];\r\n                document.getElementById('tablename').innerHTML = tablename;\r\n                document.getElementById('contentlink').setAttribute('href', '/setup/tables/content?' + tablename);\r\n                loadcontent();\r\n            });\r\n\r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup &gt; <a href="/setup/tables">Tabellen</a> &gt; <a href="#" id="contentlink"><span id="tablename"></span> - Inhalt</a></subtitle>\r\n            <page-title>Inhalt bearbeiten</page-title>\r\n            <button onclick="save();">Speichern</button>\r\n        </header>\r\n        <content>\r\n        </content>\r\n    </body>\r\n</html>\r\n	text/html	/setup/tables/content/edit
d467c535-8c83-4b8a-a638-cdaf9375bedc	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="/assets/slds.css">\n        <script src="/ccc/cc-globalnav"></script>\n        <script>\n\n            var package;\n\n            function htmlencode(str) {\n                return ('' + str).replace(/</g, '&lt;').replace(/>/g, '&gt;')\n            }\n\n            async function selecttable() {\n                var selectedtable = document.getElementById('tables').value;\n                var content = await (await fetch('/api/data/list/' + selectedtable)).json();\n                var tbody = document.querySelector('#availableentities tbody');\n                tbody.innerHTML = '';\n                var columns = {};\n                var maxlength = 1000;\n                for (var entity of content) {\n                    var tr = document.createElement('tr');\n                    tbody.appendChild(tr);\n                    for (var key of Object.keys(entity)) {\n                        columns[key] = true;\n                    }\n                    tr.innerHTML = Object.values(entity).map(v => {\n                        var text = htmlencode(v && v.length > maxlength ? v.substring(0, maxlength) : v);\n                        return '<td title="' + text.replace(/\\"/g, '&quot;') + '">' + text + '</td>';\n                    }).join('');\n                    tr.innerHTML += '<td><a href="#" onclick="addentity(\\'' + entity.id + '\\');">Hinzufügen</a></td>';\n                }\n                var thead = document.querySelector('#availableentities thead');\n                thead.innerHTML = '<tr>' + Object.keys(columns).map(c => '<th>' + c + '</th>').join('') + '<th></th><th></th></tr>';\n            }\n\n            async function addentity(entityid) {\n                var selectedtable = document.getElementById('tables').value;\n                await fetch('/api/data/packageentities', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ tablename: selectedtable, entityid: entityid, packageid: package.id }) });\n                load();\n            }\n\n            async function deletepackageentity(id) {\n                await fetch('/api/data/packageentities/' + id, { method: 'DELETE' });\n                load();\n            }\n\n            async function load() {\n                var packageid = location.search.substring(1);\n                package = (await (await fetch('/api/data/packages/' + packageid)).json())[0];\n                document.getElementById('packagename').innerHTML = package.name;\n                var tables = await (await fetch('/api/schema/tables')).json();\n                tables.sort((a, b) => a.table_name > b.table_name ? 1 : -1);\n                var tablesselect = document.getElementById('tables');\n                tablesselect.innerHTML = '';\n                for (table of tables) {\n                    tablesselect.innerHTML += '<option value="' + table.table_name + '">' + table.table_name + '</option>';\n                }\n                tablesselect.selectedIndex = 0;\n                selecttable();\n                var packageentities = await (await fetch('/api-packages/packageentities/' + packageid)).json();\n                packageentities.sort((a, b) => a.tablename > b.tablename ? 1 : -1);\n                var tbody = document.querySelector('#packageentities tbody');\n                tbody.innerHTML = '';\n                for (var packageentity of packageentities) {\n                    var tr = document.createElement('tr');\n                    tr.innerHTML = '<td>' + packageentity.tablename + '</td><td><a href="/setup/tables/content/edit?' + packageentity.tablename + '/' + packageentity.entityid + '">' + packageentity.entityid + '</a></td><td><a href="#" onclick="deletepackageentity(\\'' + packageentity.id + '\\');">Entfernen</a></td>';\n                    tbody.appendChild(tr);\n                }\n            }\n\n            window.addEventListener('load', load);\n\n        </script>\n    </head>\n    <body>\n        <cc-globalnav selectedurl="/setup/packages"></cc-globalnav>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/local_shipping/v4/24px.svg"/>\n            <subtitle>Setup &gt; <a href="/setup/packages">Pakete</a></subtitle>\n            <page-title><span id="packagename"></span> - Daten</page-title>\n            <button>\n                <select id="tables" onchange="selecttable();"></select>\n            </button>\n        </header>\n        <content>\n            <table id="availableentities">\n                <thead></thead>\n                <tbody></tbody>\n            </table>\n        </content>\n        <content>\n            <table id="packageentities">\n                <thead><tr><th>Tabelle</th><th>Datensatz</th><th></th></tr></thead>\n                <tbody></tbody>\n            </table>\n        </content>\n    </body>\n</html>	text/html	/setup/packages/entities
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
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


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

