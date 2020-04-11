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


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: packages; Type: TABLE; Schema: public; Owner: cloudcore
--

CREATE TABLE public.packages (
    id integer NOT NULL
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
    id integer NOT NULL,
    code character varying,
    url character varying(255)
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
    id integer NOT NULL,
    url character varying,
    label character varying
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
    id integer NOT NULL,
    furz character varying,
    kaggn integer
);


ALTER TABLE public.test OWNER TO cloudcore;

--
-- Name: test_id_seq; Type: SEQUENCE; Schema: public; Owner: cloudcore
--

CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_id_seq OWNER TO cloudcore;

--
-- Name: test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cloudcore
--

ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;


--
-- Name: views; Type: TABLE; Schema: public; Owner: cloudcore
--

CREATE TABLE public.views (
    id integer NOT NULL,
    content character varying,
    contenttype character varying(255),
    url character varying(255)
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
-- Name: packages id; Type: DEFAULT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.packages ALTER COLUMN id SET DEFAULT nextval('public.packages_id_seq'::regclass);


--
-- Name: routers id; Type: DEFAULT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.routers ALTER COLUMN id SET DEFAULT nextval('public.routers_id_seq'::regclass);


--
-- Name: tabs id; Type: DEFAULT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.tabs ALTER COLUMN id SET DEFAULT nextval('public.tabs_id_seq'::regclass);


--
-- Name: test id; Type: DEFAULT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);


--
-- Name: views id; Type: DEFAULT; Schema: public; Owner: cloudcore
--

ALTER TABLE ONLY public.views ALTER COLUMN id SET DEFAULT nextval('public.views_id_seq'::regclass);


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.packages (id) FROM stdin;
\.


--
-- Data for Name: routers; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.routers (id, code, url) FROM stdin;
1	var router = require('express').Router();\n\nrouter.get('/hubbele/:tablename', async (req, res) => {\n    var result = await req.db.query("SELECT * FROM information_schema.tables WHERE table_name = $1;", [req.params.tablename]);\n    res.json(result.rows);\n});\n\nrouter.get('/eins', async (req, res) => {\n    res.send("ODIN");\n});\n\nrouter.get('/zwei/:zahl', async (req, res) => {\n    res.send("TWO " + req.params.zahl);\n});\n\nmodule.exports = router;\n	/fubbele
4	/**\r\n * Dieser Router soll Datenbankbackups erstellen und wieder reinladen.\r\n * Ich gehe dabei nach dieser Anleitung hier vor, welche ich in einen GET-Request kapsele und einfach raus gebe:\r\n * https://www.jaygould.co.uk/2019-03-26-automated-postgresql-backups-node-shell/\r\n * \r\n * pg_dump cloudcore > export.sql\r\n * \r\n * In NodeJS wird die Ausgabe entweder in einen String gepiped (geht nur bei kleinen Datenbanken) und sofort\r\n * zurück gegeben, oder in eine temporäre Datei, auf die der Client dann umgelitten wird (bzw. auf router.get('/downloadlatest'),\r\n * welches die letzte temporäre Datei zurück gibt)\r\n */\r\nvar childprocess = require('child_process');\r\nvar router = require('express').Router();\r\n\r\nrouter.get('/', (req, res) => {\r\n    var resultbuffer = childprocess.execSync('pg_dump');\r\n    //var result = resultbuffer.toString();\r\n    //res.send(result);\r\n    res.setHeader("Content-Type","text/plain");\r\n    res.send(resultbuffer);\r\n});\r\n\r\nmodule.exports = router;\r\n	/backup
\.


--
-- Data for Name: tabs; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.tabs (id, url, label) FROM stdin;
1	/setup/tables	Tabellen
2	/setup/editor	Editor
\.


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.test (id, furz, kaggn) FROM stdin;
\.


--
-- Data for Name: views; Type: TABLE DATA; Schema: public; Owner: cloudcore
--

COPY public.views (id, content, contenttype, url) FROM stdin;
1	<p><a href="/vger">VGER</a></p>\n<p><a href="/setup/editor">Editor</a></p>\n<p><a href="/setup/tables">Tabellen</a></p>\n	text/html	/
14	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            async function createtable() {\r\n                var tablename = window.prompt('Name der neuen Tabelle');\r\n                if(!tablename) return;\r\n                await fetch('/api/schema/tables/' + tablename, { method: 'POST' });\r\n                loadtables();\r\n            }\r\n\r\n            async function deletetable(tablename) {\r\n                if (!confirm('Soll die Tabelle "' + tablename + '" wirklich gelöscht werden?')) return;\r\n                await fetch('/api/schema/tables/' + tablename, { method: 'DELETE' });\r\n                loadtables();\r\n            }\r\n\r\n            async function loadtables() {\r\n                var tables = await (await fetch('/api/schema/tables')).json();\r\n                tables.sort((a, b) => a.table_name > b.table_name ? 1 : -1);\r\n                var tbody = document.querySelector('tbody');\r\n                tbody.innerHTML = '';\r\n                for (var table of tables) {\r\n                    var tr = document.createElement('tr');\r\n                    tr.innerHTML = '<td>' + table.table_name + '</td><td><a href="/setup/tables/content?' + table.table_name + '">Daten</a></td><td><a href="/setup/tables/columns?' + table.table_name + '">Felder</a></td><td><a href="#" onclick="deletetable(\\'' + table.table_name + '\\');">Löschen</a></td>';\r\n                    tbody.appendChild(tr);\r\n                }\r\n            }\r\n\r\n            window.addEventListener('load', loadtables);\r\n\r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup</subtitle>\r\n            <page-title>Tabellen</page-title>\r\n            <button onclick="createtable();">Neue Tabelle</button>\r\n        </header>\r\n        <content>\r\n            <table>\r\n                <thead><tr><th>Name</th><th></th><th></th><th></th></tr></thead>\r\n                <tbody></tbody>\r\n            </table>\r\n        </content>\r\n    </body>\r\n</html>	text/html	/setup/tables
20	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script src="/monaco-editor/min/vs/loader.js"></script>\r\n        <script>\r\n        var monacoEditor;\r\n        var currentView;\r\n        var currentRouter;\r\n\r\n        function openInNewTab() {\r\n            if (!currentView) return;\r\n            window.open(currentView.url, '_blank');\r\n        }\r\n\r\n        async function del() {\r\n            if (currentView) {\r\n                if (!confirm('Soll die View wirklich gelöscht werden?')) return;\r\n                await fetch('/api/data/views/' + currentView.id, { method: 'DELETE' });\r\n                location.href = '?';\r\n            } else if (currentRouter) {\r\n                if (!confirm('Soll der Router wirklich gelöscht werden?')) return;\r\n                await fetch('/api/data/routers/' + currentRouter.id, { method: 'DELETE' });\r\n                location.href = '?';\r\n            }\r\n        }\r\n\r\n        async function createView() {\r\n            var url = prompt('Welche URL?', '/');\r\n            if (!url) return;\r\n            var contenttype = prompt('Welcher Content Type?', 'text/plain');\r\n            if (!contenttype) return;\r\n            var id = (await (await fetch('/api/data/views', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ url: url, contenttype: contenttype, content: '' }) })).json())[0].id;\r\n            location.href = '?views/' + id;\r\n        }\r\n\r\n        async function createRouter() {\r\n            var url = prompt('Welche URL?', '/');\r\n            if (!url) return;\r\n            var id = (await (await fetch('/api/data/routers', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ url: url, code: '' }) })).json())[0].id;\r\n            location.href = '?routers/' + id;\r\n        }\r\n\r\n        async function save() {\r\n            if (currentView) {\r\n                var content = monacoEditor.getValue();\r\n                await fetch('/api/data/views/' + currentView.id, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ content: content }) });\r\n            } else if (currentRouter) {\r\n                var code = monacoEditor.getValue();\r\n                await fetch('/api/data/routers/' + currentRouter.id, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ code: code }) });\r\n            }\r\n            var button = document.querySelector('#savebutton');\r\n            button.classList.add('green');\r\n            setTimeout(() => {\r\n                button.classList.remove('green');\r\n            }, 1000);\r\n        }\r\n\r\n        async function loadView(id) {\r\n            currentRouter = false;\r\n            currentView = (await (await fetch('/api/data/views/' + id)).json())[0];\r\n            monacoEditor.setValue(currentView.content);\r\n            var language = monaco.languages.getLanguages().find(l => l.mimetypes && (l.mimetypes.indexOf(currentView.contenttype) >= 0));\r\n            monaco.editor.setModelLanguage(monacoEditor.getModel(), language ? language.id : 'plaintext');\r\n            document.querySelectorAll('content table .selected').forEach(e => e.classList.remove('selected'));\r\n            document.getElementById('view-' + id).classList.add('selected');\r\n            window.history.pushState(null, null, '?views/' + id);\r\n        }\r\n\r\n        async function loadRouter(id) {\r\n            currentView = false;\r\n            currentRouter = (await (await fetch('/api/data/routers/' + id)).json())[0];\r\n            monacoEditor.setValue(currentRouter.code);\r\n            monaco.editor.setModelLanguage(monacoEditor.getModel(), 'javascript');\r\n            document.querySelectorAll('content table .selected').forEach(e => e.classList.remove('selected'));\r\n            document.getElementById('router-' + id).classList.add('selected');\r\n            window.history.pushState(null, null, '?routers/' + id);\r\n        }\r\n\r\n        async function listViewsAndRouters() {\r\n            var views = await (await fetch('/api/data/list/views/id,url')).json();\r\n            views.sort((v1, v2) => v1.url > v2.url ? 1 : -1);\r\n            var viewlist = document.getElementById('views');\r\n            viewlist.innerHTML = '';\r\n            for (var view of views) {\r\n                viewlist.innerHTML += '<tr id="view-' + view.id + '"><td><a href="#" onclick="loadView(' + view.id + ');">' + view.url + '</a></td></tr>';\r\n            }\r\n            var routers = await (await fetch('/api/data/list/routers/id,url')).json();\r\n            routers.sort((r1, r2) => r1.url > r2.url ? 1 : -1);\r\n            var routerlist = document.getElementById('routers');\r\n            routerlist.innerHTML = '';\r\n            for (var router of routers) {\r\n                routerlist.innerHTML += '<tr id="router-' + router.id + '"><td><a href="#" onclick="loadRouter(' + router.id + ');">' + router.url + '</a></td></tr>';\r\n            }\r\n        }\r\n\r\n        window.addEventListener('load', function() {\r\n            // MonacoEditor initialisieren\r\n            require.config({ paths: { 'vs': '/monaco-editor/min/vs' }});\r\n            require(['vs/editor/editor.main'], function() {\r\n                monacoEditor = monaco.editor.create(document.getElementById('editor'));\r\n                if (location.search.length > 1) {\r\n                    var parts = location.search.substring(1).split('/');\r\n                    if (parts[0] === 'views') {\r\n                        loadView(parts[1]);\r\n                    } else {\r\n                        loadRouter(parts[1]);\r\n                    }\r\n                };\r\n                monacoEditor.addCommand(monaco.KeyMod.CtrlCmd | monaco.KeyCode.KEY_S, save);\r\n            });        \r\n            listViewsAndRouters();\r\n        });\r\n\r\n        window.addEventListener('resize', function() {\r\n            if (monacoEditor) monacoEditor.layout();\r\n        });\r\n\r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/editor"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/code/v4/24px.svg"/>\r\n            <subtitle>Setup</subtitle>\r\n            <page-title>Editor</page-title>\r\n            <button onclick="createView();">+ View</button>\r\n            <button onclick="createRouter();">+ Router</button>\r\n            <button onclick="save();" id="savebutton">Speichern</button>\r\n            <button onclick="del();">Löschen</button>\r\n            <button onclick="openInNewTab();">Öffnen</button>\r\n            <button>\r\n            <select onchange="monaco.editor.setTheme(this.value);">\r\n                <option value="vs">Hell</option>\r\n                <option value="vs-dark">Dunkel</option>\r\n                <option value="hc-black">Hoher Kontrast</option>\r\n            </select>\r\n            </button>\r\n        </header>\r\n        <columns class="two-fix-flex">\r\n            <content style="width:300px;">\r\n                <table>\r\n                    <thead><tr><th>Views</th></tr></thead>\r\n                    <tbody id="views"></tbody>\r\n                </table>\r\n                <table>\r\n                    <thead><tr><th>Routers</th></tr></thead>\r\n                    <tbody id="routers"></tbody>\r\n                </table>\r\n            </content>\r\n            <content id="editor" style="overflow: hidden;"></content>\r\n        </columns>\r\n    </body>\r\n</html>	text/html	/setup/editor
26	// Siehe https://developers.google.com/web/updates/2017/01/webcomponents-org\n// Und https://googlechromelabs.github.io/howto-components/howto-checkbox/#demo\n// ccc steht für CloudCoreComponent\n(function() {\n\n    var template = document.createElement('template');\n    template.innerHTML = `\n    <style>\n        :host {\n            border-bottom: 3px solid #0070d2;\n            display: flex;\n            background-color: white;\n        }\n        :host > launcherbutton:before {\n            content: "⸬";\n            display: flex;\n            font-size: 21px;\n            padding: 0 14px;\n        }\n        :host > label {\n            font-size: 18px;\n            padding-right: 24px;\n            line-height: 32px;\n        }\n        :host > tablist {\n            display: flex;\n        }\n        :host > tablist > tab {\n            padding: 0 12px;\n            line-height: 30px;\n            border-style: solid;\n            border-width: 3px 0;\n            border-color: transparent;\n            margin-bottom: -3px;\n        }\n        :host > tablist > tab > a, \n        :host > tablist > tab > a:hover {\n            text-decoration: none;\n            color: #080707;\n            padding: 0 12px;\n            line-height: 30px;\n            margin: 0 -12px;\n            display: block;\n        }\n        :host > tablist > tab:hover {\n            border-bottom-color: rgba(0, 0, 0, 0.4);\n            background-color: rgba(0, 112, 210, 0.1);\n        }\n        :host > tablist > tab[selected] {\n            border-top-color: #0070d2;\n            background-color: rgba(0, 112, 210, 0.1);\n        }\n    </style>\n    `;\n\n    class GlobalNav extends HTMLElement {\n\n        static get observedAttributes() {\n            return ['selectedurl'];\n        }\n\n        constructor() {\n            super();\n            this.tabs = [];\n            this.attachShadow({mode: 'open'});\n            this.shadowRoot.appendChild(template.content.cloneNode(true));\n            this.launcherButton = document.createElement('launcherbutton');\n            this.shadowRoot.appendChild(this.launcherButton);\n            this.label = document.createElement('label');\n            this.label.innerHTML = 'Setup';\n            this.shadowRoot.appendChild(this.label);\n            this.tabList = document.createElement('tablist');\n            this.shadowRoot.appendChild(this.tabList);\n        }\n\n        async connectedCallback() {\n            var tabs = await (await fetch('/api/data/list/tabs')).json();\n            tabs.sort((t1, t2) => t1.label > t2.label ? 1 : -1);\n            for (var tab of tabs) {\n                tab.tabElement = this.addTab(tab);\n                this.tabs.push(tab);\n            }\n            if (this.selectedurl) this.setselectedurl(this.selectedurl);\n        }\n\n        setselectedurl(selectedurl) {\n            this.selectedurl = selectedurl;\n            for (var tab of this.tabs) {\n                if (tab.url === selectedurl) {\n                    tab.tabElement.setAttribute('selected', 'selected');\n                } else {\n                    tab.tabElement.removeAttribute('selected');\n                }\n            }\n        }\n\n        attributeChangedCallback(name, _, newValue) {\n            if (name === 'selectedurl') this.setselectedurl(newValue);\n        }\n\n        addTab(tab) {\n            var tabElement = document.createElement('tab');\n            var a = document.createElement('a');\n            a.innerHTML = tab.label;\n            a.setAttribute('href', tab.url);\n            tabElement.appendChild(a);\n            this.tabList.appendChild(tabElement);\n            return tabElement;\n        }\n\n    }\n\n    window.customElements.define('cc-globalnav', GlobalNav);\n\n})();	text/javascript	/ccc/cc-globalnav
18	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            var tablename, entityid;\r\n\r\n            async function save() {\r\n                var content = {};\r\n                for (var key  of keys) {\r\n                    content[key] = document.getElementById(key).value;\r\n                }\r\n                if (entityid) {\r\n                    await fetch('/api/data/' + tablename + '/' + entityid, { method: 'PUT', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(content) });\r\n                } else {\r\n                    entityid = (await (await fetch('/api/data/' + tablename, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(content) })).json())[0].id;\r\n                    location.href += '/' + entityid;\r\n                }\r\n            }\r\n\r\n            async function loadcontent() {\r\n                var content;\r\n                if (entityid) {\r\n                    content = (await (await fetch('/api/data/' + tablename + '/' + entityid)).json())[0];\r\n                } else {\r\n                    content = {};\r\n                    var columns = await (await fetch('/api/schema/columns/' + tablename)).json();\r\n                    for (var column of columns) {\r\n                        if (column.table_schema !== 'public') continue;\r\n                        content[column.column_name] = '';\r\n                    }\r\n                }\r\n                delete content.id;\r\n                var contentelement = document.querySelector('content');\r\n                contentelement.innerHTML = '';\r\n                keys = Object.keys(content);\r\n                for (var key of keys) {\r\n                    var inputfield = document.createElement('input-field');\r\n                    inputfield.innerHTML = '<textarea id="' + key + '"></textarea><label>' + key + '</label>';\r\n                    contentelement.appendChild(inputfield);\r\n                    document.getElementById(key).value = content[key];\r\n                }\r\n            }\r\n\r\n            window.addEventListener('load', () => {\r\n                var urlparts = location.search.substring(1).split('/');\r\n                tablename = urlparts[0];\r\n                entityid = urlparts[1];\r\n                document.getElementById('tablename').innerHTML = tablename;\r\n                document.getElementById('contentlink').setAttribute('href', '/setup/tables/content?' + tablename);\r\n                loadcontent();\r\n            });\r\n\r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup &gt; <a href="/setup/tables">Tabellen</a> &gt; <a href="#" id="contentlink"><span id="tablename"></span> - Inhalt</a></subtitle>\r\n            <page-title>Inhalt bearbeiten</page-title>\r\n            <button onclick="save();">Speichern</button>\r\n        </header>\r\n        <content>\r\n        </content>\r\n    </body>\r\n</html>\r\n	text/html	/setup/tables/content/edit
15	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            var tablename;\r\n\r\n            function createcolumn() {\r\n                location.href = '/setup/tables/columns/create?' + tablename;\r\n            }\r\n\r\n            async function deletecolumn(columnname) {\r\n                if (!confirm('Really delete column "' + columnname + '"?')) return;\r\n                await fetch('/api/schema/columns/' + tablename + '/' + columnname, { method: 'DELETE' });\r\n                loadcolumns();\r\n            }\r\n\r\n            async function loadcolumns() {\r\n                var columns = await (await fetch('/api/schema/columns/' + tablename)).json();\r\n                var tbody = document.querySelector('tbody');\r\n                tbody.innerHTML = '';\r\n                for (var column of columns) {\r\n                    if (column.table_schema !== 'public') continue;\r\n                    var tr = document.createElement('tr');\r\n                    tr.innerHTML = '<td>' + column.column_name + '</td><td>' + column.data_type + '</td><td><a href="#" onclick="deletecolumn(\\'' + column.column_name + '\\');">Delete</a></td>';\r\n                    tbody.appendChild(tr);\r\n                }\r\n            }\r\n\r\n            window.addEventListener('load', () => {\r\n                tablename = location.search.substring(1);\r\n                document.getElementById('tablename').innerHTML = tablename;\r\n                loadcolumns();\r\n            });\r\n        \r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup &gt; <a href="/setup/tables">Tabellen</a></subtitle>\r\n            <page-title><span id="tablename"></span> - Spalten</page-title>\r\n            <button onclick="createcolumn();">Neue Spalte</button>\r\n        </header>\r\n        <content>\r\n            <table>\r\n                <thead><tr><th>Name</th><th>Datentyp</th><th></th></tr></thead>\r\n                <tbody></tbody>\r\n            </table>\r\n        </content>\r\n    </body>\r\n</html>\r\n	text/html	/setup/tables/columns
16	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            var tablename;\r\n\r\n            async function createcolumn() {\r\n                var name = document.querySelector('#columnname').value;\r\n                var datatype = document.querySelector('#datatype').value;\r\n                await fetch('/api/schema/columns/' + tablename + '/' + name + '/' + datatype, { method: 'POST' });\r\n                location.href = '/setup/tables/columns?' + tablename;\r\n            }\r\n\r\n            window.addEventListener('load', () => {\r\n                tablename = location.search.substring(1);\r\n                document.getElementById('tablename').innerHTML = tablename;\r\n                document.getElementById('columnslink').setAttribute('href', '/setup/tables/columns?' + tablename);\r\n            });\r\n\r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup &gt; <a href="/setup/tables">Tabellen</a> &gt; <a href="#" id="columnslink"><span id="tablename"></span> - Spalten</a></subtitle>\r\n            <page-title>Neue Spalte</page-title>\r\n            <button onclick="createcolumn();">Erstellen</button>\r\n        </header>\r\n        <content>\r\n            <input-field>\r\n                <input id="columnname" placeholder="Name" />\r\n                <label>Name</label>\r\n            </input-field>\r\n            <input-field>\r\n                <select id="datatype">\r\n                    <option value="integer">INTEGER</option>\r\n                    <option value="varchar" selected="">VARCHAR</option>\r\n                </select>\r\n                <label>Datentyp</label>\r\n            </input-field>\r\n        </content>\r\n    </body>\r\n</html>\r\n	text/html	/setup/tables/columns/create
13	html,\r\nbody {\r\n    margin: 0;\r\n    padding: 0;\r\n    width: 100%;\r\n    height: 100%;\r\n    overflow: hidden;\r\n}\r\nbody {\r\n    display: flex;\r\n    flex-direction: column;\r\n    font-family: sans-serif;\r\n    font-size: 13px;\r\n    color: #080707;\r\n    background-image: url(https://www.lightningdesignsystem.com/assets/images/themes/oneSalesforce/banner-brand-default.png), linear-gradient(0, rgba(176, 196, 223, 1), 85%, #195594);\r\n    background-repeat: repeat-x;\r\n    position: relative;\r\n    overflow: auto;\r\n}\r\nbody::after {\r\n    content: "";\r\n    background-image: linear-gradient(0, rgba(176, 196, 223, 1), 90%, transparent\r\n    );\r\n    height: 100%;\r\n    top: 0;\r\n    position: absolute;\r\n    left: 0;\r\n    width: 100%;\r\n    z-index: -1;\r\n}\r\na {\r\n    color: rgb(0, 109, 204);\r\n    text-decoration: none;\r\n}\r\na:hover {\r\n    text-decoration: underline;\r\n}\r\nheader {\r\n    margin: 12px 12px 0 12px;\r\n    border-radius: 4px;\r\n    border: 1px solid #ccc;\r\n    box-shadow: 1px 1px 3px -1px rgba(0, 0, 0, 0.5);\r\n    padding: 16px;\r\n    background-color: rgb(243, 242, 242);\r\n    display: flex;\r\n    position: relative;\r\n}\r\nheader > img {\r\n    filter: invert(1);\r\n    background-color: coral;\r\n    border-radius: 3px;\r\n    padding: 7px;\r\n    margin-right: 16px;\r\n}\r\nheader > page-title {\r\n    display: block;\r\n    flex: 1;\r\n    font-size: 18px;\r\n    font-weight: bold;\r\n    line-height: 38px;\r\n    overflow: hidden;\r\n    white-space: nowrap;\r\n    text-overflow: ellipsis;\r\n}\r\nheader > subtitle {\r\n    position: absolute;\r\n    left: 70px;\r\n    color: rgb(62, 62, 60);\r\n}\r\nheader > subtitle + page-title {\r\n    line-height: 22px;\r\n    margin-top: 16px;\r\n}\r\nheader > button {\r\n    background-color: #fff;\r\n    padding: 0 16px;\r\n    border: solid rgb(221, 219, 218);\r\n    line-height: 30px;\r\n    margin: 4px 0;\r\n    border-width: 1px 1px 1px 0;\r\n    color: rgb(27, 82, 151);\r\n    font-size: 13px;\r\n    cursor: pointer;\r\n}\r\nheader > button > select {\r\n    border: none;\r\n    display: block;\r\n    background-color: transparent;\r\n    padding: 7px 16px;\r\n    margin: 0 -16px;\r\n    color: rgb(27, 82, 151);    \r\n}\r\nheader > button:hover {\r\n    background-color: rgb(243, 242, 242);\r\n}\r\nheader > button:first-of-type {\r\n    border-left-width: 1px;\r\n    border-top-left-radius: 4px;\r\n    border-bottom-left-radius: 4px;\r\n    margin-left: 16px;\r\n}\r\nheader > button:last-of-type {\r\n    border-right-width: 1px;\r\n    border-top-right-radius: 4px;\r\n    border-bottom-right-radius: 4px;\r\n}\r\ncolumns {\r\n    display: flex;\r\n    flex: 1;\r\n}\r\ncolumns.two-fix-flex > *:first-child {\r\n    flex: unset;\r\n    margin-right: 0;\r\n}\r\ncontent {\r\n    margin: 12px 12px 0 12px;\r\n    border-radius: 4px;\r\n    border: 1px solid #ccc;\r\n    box-shadow: 1px 1px 3px -1px rgba(0, 0, 0, 0.5);\r\n    flex: 1;\r\n    overflow: auto;\r\n    background-color: #fff;\r\n}\r\ntable {\r\n    border-spacing: 0;\r\n    width: 100%;\r\n}\r\ntable > thead > tr > th,\r\ntable > tbody > tr > td {\r\n    padding: 4px 8px;\r\n    text-align: start;\r\n    overflow: hidden;\r\n    max-width: 0;\r\n    white-space: nowrap;\r\n    text-overflow: ellipsis;\r\n    border-bottom: 1px solid rgb(221, 219, 218);\r\n}\r\ntable > thead > tr > th > a,\r\ntable > tbody > tr > td > a {\r\n    display: block;\r\n    margin: -4px -8px;\r\n    padding: 4px 8px;\r\n}\r\ntable > thead > tr > th {\r\n    background-color: rgb(250, 250, 249);\r\n    line-height: 24px;\r\n}\r\ntable > tbody > tr > td {\r\n    line-height: 21px;\r\n}\r\ntable > tbody > tr:last-child > td {\r\n    border-bottom: none;\r\n}\r\ntable > tbody > tr:hover > td {\r\n    background-color: rgb(243, 242, 242);\r\n    box-shadow: rgb(221, 219, 218) 0px -1px 0px 0px inset, rgb(221, 219, 218) 0px 1px 0px 0px inset;\r\n}\r\ntable > tbody > tr > td:hover {\r\n    background-color: #fff;\r\n}\r\ntable > tbody > tr.selected > td {\r\n    background-color: rgb(243, 242, 242);\r\n}\r\ninput-field {\r\n    display: block;\r\n    position: relative;\r\n    padding: 22px 12px 0 12px;\r\n}\r\ninput-field > input {\r\n    display: block;\r\n    border: solid rgb(221, 219, 218);\r\n    width: 100%;\r\n    border-width: 0 0 1px 0;\r\n    font-size: 14px;\r\n    line-height: 22px;\r\n    padding: 0 4px;\r\n    box-sizing: border-box;\r\n}\r\ninput-field > select {\r\n    display: block;\r\n    width: 100%;\r\n    border: solid rgb(221, 219, 218);\r\n    border-width: 0 0 1px 0;\r\n    padding: 3px 4px 2px 4px;    \r\n}\r\ninput-field > textarea {\r\n    display: block;\r\n    border: 1px solid rgb(221, 219, 218);\r\n    border-radius: 4px;\r\n    font-size: 14px;\r\n    padding: 4px;\r\n    box-sizing: border-box;\r\n    min-width: 100%;\r\n    max-width: 100%;\r\n}\r\ninput-field > label {\r\n    position: absolute;\r\n    top: 8px;\r\n    left: 16px;\r\n    color: #ccc;\r\n    font-size: 11px;\r\n}\r\ninput-field > input::placeholder {\r\n    color: #ccc;\r\n}\r\ninput-field > input:placeholder-shown + label {\r\n    display: none;\r\n}\r\nbody > content:last-of-type,\r\nbody > columns:last-of-type {\r\n    margin-bottom: 12px;\r\n}\r\nbutton.green {\r\n    background-color:lightgreen;\r\n}\r\n.cols-2 {\r\n    columns: 2;\r\n    column-gap: 0;\r\n}\r\n	text/css	/assets/slds.css
17	<!DOCTYPE html>\r\n<html>\r\n    <head>\r\n        <link rel="stylesheet" href="/assets/slds.css">\r\n        <script src="/ccc/cc-globalnav"></script>\r\n        <script>\r\n\r\n            var tablename;\r\n\r\n            function createcontent() {\r\n                location.href = '/setup/tables/content/edit?' + tablename;\r\n            }\r\n\r\n            function htmlencode(str) {\r\n                return ('' + str).replace(/</g, '&lt;').replace(/>/g, '&gt;')\r\n            }\r\n\r\n            async function deletecontent(id) {\r\n                if (!confirm('Soll der Inhalt mit der Id "' + id + '" wirklich gelöscht werden?')) return;\r\n                await fetch('/api/data/' + tablename + '/' + id, { method: 'DELETE' });\r\n                loadcontent();\r\n            }\r\n\r\n            async function loadcontent() {\r\n                var content = await (await fetch('/api/data/list/' + tablename)).json();\r\n                var tbody = document.querySelector('tbody');\r\n                tbody.innerHTML = '';\r\n                console.log(content);\r\n                var columns = {};\r\n                var maxlength = 1000;\r\n                for (var entity of content) {\r\n                    var tr = document.createElement('tr');\r\n                    tbody.appendChild(tr);\r\n                    for (var key of Object.keys(entity)) {\r\n                        columns[key] = true;\r\n                    }\r\n                    tr.innerHTML = Object.values(entity).map(v => {\r\n                        var text = htmlencode(v && v.length > maxlength ? v.substring(0, maxlength) : v);\r\n                        return '<td title="' + text.replace(/\\"/g, '&quot;') + '">' + text + '</td>';\r\n                    }).join('');\r\n                    tr.innerHTML += '<td><a href="/setup/tables/content/edit?' + tablename + '/' + entity.id + '">Bearbeiten</a></td><td><a href="#" onclick="deletecontent(' + entity.id + ');">Löschen</a></td>';\r\n                }\r\n                var thead = document.querySelector('thead');\r\n                thead.innerHTML = '<tr>' + Object.keys(columns).map(c => '<th>' + c + '</th>').join('') + '<th></th><th></th></tr>';\r\n            }\r\n\r\n            window.addEventListener('load', () => {\r\n                tablename = location.search.substring(1);\r\n                document.getElementById('tablename').innerHTML = tablename;\r\n                loadcontent();\r\n            });\r\n        \r\n        </script>\r\n    </head>\r\n    <body>\r\n        <cc-globalnav selectedurl="/setup/tables"></cc-globalnav>\r\n        <header>\r\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\r\n            <subtitle>Setup &gt; <a href="/setup/tables">Tabellen</a></subtitle>\r\n            <page-title><span id="tablename"></span> - Inhalt</page-title>\r\n            <button onclick="createcontent();">Neuer Inhalt</button>\r\n        </header>\r\n        <content>\r\n            <table>\r\n                <thead></thead>\r\n                <tbody></tbody>\r\n            </table>\r\n        </content>\r\n    </body>\r\n</html>\r\n	text/html	/setup/tables/content
12	<!DOCTYPE html>\n<html>\n    <head>\n        <link rel="stylesheet" href="assets/slds.css">\n        <script src="/ccc/cc-globalnav"></script>\n    </head>\n    <body>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\n            <subtitle><a href="#">Setup</a> &gt; <a href="#">Setup</a> &gt; Setup</subtitle>\n            <page-title>Tables</page-title>\n            <button>New</button>\n        </header>\n        <header>\n            <img src="https://fonts.gstatic.com/s/i/materialicons/table_chart/v4/24px.svg"/>\n            <page-title>Title with very long text. I do not know how long it can get so stay away from me!</page-title>\n            <button>New</button>\n            <button>Save</button>\n            <button>Save</button>\n            <button>Delete</button>\n        </header>\n        <content>\n            <table>\n                <thead>\n                    <tr>\n                        <th>Header 1</th>\n                        <th>Header 2</th>\n                        <th>Header 3</th>\n                        <th>Header 4</th>\n                        <th>Header 5</th>\n                        <th>Header 6</th>\n                        <th>Header 7</th>\n                    </tr>\n                </thead>\n                <tbody>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                    <tr><td><a href="#">Content blubberei mit ganz lagmen Text</a></td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td><td>Content blubberei mit ganz lagmen Text</td></tr>\n                </tbody>\n            </table>\n        </content>\n        <content>\n            <input-field>\n                <input placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n        </content>\n        <content class="cols-2">\n            <input-field>\n                <input placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <input value="Hoppsassa" placeholder="Trallala" />\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <select>\n                    <option value="integer">INTEGER</option>\n                    <option value="varchar" selected="">VARCHAR</option>\n                </select>\n                <label>Trallala</label>\n            </input-field>\n            <input-field>\n                <textarea></textarea>\n                <label>Fullibulli</label>\n            </input-field>\n        </content>\n    </body>\n</html>	text/html	/layouttest
\.


--
-- Name: packages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudcore
--

SELECT pg_catalog.setval('public.packages_id_seq', 1, false);


--
-- Name: routers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudcore
--

SELECT pg_catalog.setval('public.routers_id_seq', 5, true);


--
-- Name: tabs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudcore
--

SELECT pg_catalog.setval('public.tabs_id_seq', 2, true);


--
-- Name: test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudcore
--

SELECT pg_catalog.setval('public.test_id_seq', 1, false);


--
-- Name: views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudcore
--

SELECT pg_catalog.setval('public.views_id_seq', 26, true);


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

