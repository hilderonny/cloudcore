var monacoEditor;

var app = new Vue({
    el: '#app',
    data: {
        views: [],
        currentView: null,
    },
    methods: {
        listViews: async function() {
            this.views = await (await fetch('/api/data/list/views/id,url')).json();
        },
        loadView: async function(view) {
            this.currentView = (await (await fetch('/api/data/views/' + view.id)).json())[0];
            monacoEditor.setValue(this.currentView.content);
            var language = monaco.languages.getLanguages().find(l => l.mimetypes && (l.mimetypes.indexOf(this.currentView.contenttype) >= 0));
            monaco.editor.setModelLanguage(monacoEditor.getModel(), language ? language.id : 'plaintext');
        },
    },
    created: function () {
        // MonacoEditor initialisieren
        require.config({ paths: { 'vs': '/monaco-editor/min/vs' }});
        require(['vs/editor/editor.main'], function() {
            monacoEditor = monaco.editor.create(document.getElementById('editor'), {
                value: [
                    'function x() {',
                    '\tconsole.log("Hello world!");',
                    '}'
                ].join('\n'),
                language: 'javascript'
            });
        });        
        // Views auflisten
        this.listViews();
    },
});
