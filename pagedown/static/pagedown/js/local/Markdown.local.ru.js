// Usage:
//
// var myConverter = new Markdown.Converter(myEditor, null, { strings: Markdown.local.strings });

(function () {
    Markdown.local = Markdown.local || {};
    Markdown.local.localStrings = {
        bold: "Жирный <strong> Ctrl+B",
        boldexample: "жирный текст",

        italic: "Выделение <em> Ctrl+I",
        italicexample: "наклонный текст",

        link: "Ссылка <a> Ctrl+L",
        linkdescription: "Введите ссылку",
        linkdialog: "<p><b>Введите ссылку</b></p><p>http://example.com/ \"optional title\"</p>",

        quote: "Цитата <blockquote> Ctrl+Q",
        quoteexample: "Цитата",

        code: "Код <pre><code> Ctrl+K",
        codeexample: "введите код",

        image: "Рисунок <img> Ctrl+G",
        imagedescription: "введите описание рисунка",
        imagedialog: "<p><b>Вставте рисунок</b></p><p>http://example.com/images/diagram.jpg \"дополнительный заголовок\"</p>",

        olist: "Упорядоченный список <ol> Ctrl+O",
        ulist: "Неупорядоченный список <ul> Ctrl+U",
        litem: "Элемент списка",

        heading: "Заголовок <h1>/<h2> Ctrl+H",
        headingexample: "Heading",

        hr: "Отсечение текста <hr> Ctrl+R",

        undo: "Undo - Ctrl+Z",
        redo: "Redo - Ctrl+Y",
        redomac: "Redo - Ctrl+Shift+Z",

        help: "Предосмотр текста"
    };
})();