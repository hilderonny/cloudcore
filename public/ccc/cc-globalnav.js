// Siehe https://developers.google.com/web/updates/2017/01/webcomponents-org
// Und https://googlechromelabs.github.io/howto-components/howto-checkbox/#demo
// ccc steht für CloudCoreComponent
(function() {

    var template = document.createElement('template');
    template.innerHTML = `
    <style>
        :host {
            border-bottom: 3px solid #0070d2;
            display: flex;
            background-color: white;
        }
        :host > launcherbutton:before {
            content: "𝍖";
            display: flex;
            font-size: 21px;
            padding: 3px 14px;
            cursor: pointer;
        }
        :host > label {
            font-size: 18px;
            padding-right: 24px;
            line-height: 32px;
        }
        :host > tablist {
            display: flex;
        }
        :host > tablist > tab {
            padding: 0 12px;
            line-height: 30px;
            border-style: solid;
            border-width: 3px 0;
            border-color: transparent;
            margin-bottom: -3px;
        }
        :host > tablist > tab > a, 
        :host > tablist > tab > a:hover {
            text-decoration: none;
            color: #080707;
            padding: 0 12px;
            line-height: 30px;
            margin: 0 -12px;
            display: block;
        }
        :host > tablist > tab:hover {
            border-bottom-color: rgba(0, 0, 0, 0.4);
            background-color: rgba(0, 112, 210, 0.1);
        }
        :host > tablist > tab[selected] {
            border-top-color: #0070d2;
            background-color: rgba(0, 112, 210, 0.1);
        }
    </style>
    `;

    class GlobalNav extends HTMLElement {

        static get observedAttributes() {
            return ['selectedurl'];
        }

        constructor() {
            super();
            this.tabs = [];
            this.attachShadow({mode: 'open'});
            this.shadowRoot.appendChild(template.content.cloneNode(true));
            this.launcherButton = document.createElement('launcherbutton');
            this.launcherButton.addEventListener('click', () => { location.href = '/'; });
            this.shadowRoot.appendChild(this.launcherButton);
            this.label = document.createElement('label');
            this.label.innerHTML = 'Setup';
            this.shadowRoot.appendChild(this.label);
            this.tabList = document.createElement('tablist');
            this.shadowRoot.appendChild(this.tabList);
        }

        async connectedCallback() {
            var tabs = Object.values(await (await fetch('/api/data/list/tabs')).json());
            tabs.sort((t1, t2) => t1.label > t2.label ? 1 : -1);
            for (var tab of tabs) {
                tab.tabElement = this.addTab(tab);
                this.tabs.push(tab);
            }
            if (this.selectedurl) this.setselectedurl(this.selectedurl);
        }

        setselectedurl(selectedurl) {
            this.selectedurl = selectedurl;
            for (var tab of this.tabs) {
                if (tab.url === selectedurl) {
                    tab.tabElement.setAttribute('selected', 'selected');
                } else {
                    tab.tabElement.removeAttribute('selected');
                }
            }
        }

        attributeChangedCallback(name, _, newValue) {
            if (name === 'selectedurl') this.setselectedurl(newValue);
        }

        addTab(tab) {
            var tabElement = document.createElement('tab');
            var a = document.createElement('a');
            a.innerHTML = tab.label;
            a.setAttribute('href', tab.url);
            tabElement.appendChild(a);
            this.tabList.appendChild(tabElement);
            return tabElement;
        }

    }

    window.customElements.define('cc-globalnav', GlobalNav);

})();