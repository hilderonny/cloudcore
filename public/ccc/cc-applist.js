// Liste von Apps auf Startseite
(function() {

    var template = document.createElement('template');
    template.innerHTML = `
    <style>
        :host {
            display: flex;
            align-items: center;
            margin: auto;
            align-self: center;
        }
        :host > a {
            padding: .5rem;
            border-radius: .25rem;
            border: 1px solid #dddbda;
            box-shadow: 0 2px 2px rgba(0,0,0,.05);
            margin: 1rem;
            background: #fff;
            cursor: pointer;
            display: flex;
            width: 250px;
            height: 125px;
            text-decoration: none;
            color: #080707;
            position: relative;
        }
        :host > a:hover {
            border: 1px solid #1589ee;
            box-shadow: inset 0 0 0 1px #1589ee;
        }
        :host > a > symbol {
            display: flex;
            justify-content: center;
            margin: auto 14px auto 6px;
            color: #fff;
            font-size: 1.5rem;
            font-weight: 400;
            background-color: #706e6b;
            border-radius: .25rem;
            width: 48px;
            height: 48px;
            line-height: 48px;
        }
        :host > a > content {
            padding: 0 .75rem;
            flex: 1;
            margin: auto;
            max-height: 100%;
        }
        :host > a > content::before {
            content: '';
            background-color: #dddbda;
            display: block;
            width: 1px;
            position: absolute;
            top: .75rem;
            bottom: .75rem;
            left: 76px;
        }
        :host > a:hover > content::before {
            background-color: #1589ee;
        }
        :host > a > content > h1 {
            margin: 0;
            padding: 0;
            font-size: 1rem;
            font-weight: 700;
        }
        :host > a > content > p {
            margin: 0;
            padding: 0;
            font-size: .75rem;
            line-height: 1.5;
            color: #3e3e3c;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 5;
            -webkit-box-orient: vertical;
        }
    </style>
    `;

    class AppList extends HTMLElement {

        constructor() {
            super();
            this.attachShadow({mode: 'open'});
            this.rootElement = template.content.cloneNode(true);
            this.shadowRoot.appendChild(this.rootElement);
        }

        // Event wird ausgelöst, wenn Komponente in HTML eingefügt wird
        async connectedCallback() {
            var apps = Object.values(await (await fetch('/api/data/list/apps')).json());
            apps.sort((first, second) => first.label > second.label ? 1 : -1);
            for (var app of apps) this.addApp(app);
        }

        addApp(app) {
            var appElement = document.createElement('a');
            appElement.href = app.url;
            appElement.app = app;
            var initialen = app.label.split(' ').map(i => i.substring(0, 1));
            appElement.innerHTML = '<symbol>' + initialen + '</symbol><content><h1>' + app.label + '</h1><p>' + app.description + '</p></content>';
            this.shadowRoot.appendChild(appElement);
        }

    }

    window.customElements.define('cc-applist', AppList);

})();