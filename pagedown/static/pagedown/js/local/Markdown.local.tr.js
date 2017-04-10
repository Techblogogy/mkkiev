// Usage:
//
// var myConverter = new Markdown.Converter(myEditor, null, { strings: Markdown.local.strings });

(function () {
    Markdown.local = Markdown.local || {};
    Markdown.local.localStrings = {
        bold: "kalın <strong> Ctrl+B",
        boldexample: "Kalın metin",

        italic: "Italik <em> Ctrl+I",
        italicexample: "Italik metin",

        link: "Bağlantı <a> Ctrl+L",
        linkdescription: "Bağlantıyı girin",
        linkdialog: "<p><b>Bağlantıyı girin</b></p><p>http://example.com/ \"ek tanım\"</p>",

        quote: "Alıntı <blockquote> Ctrl+Q",
        quoteexample: "Alıntı",

        code: "Kod <pre><code> Ctrl+K",
        codeexample: "Kodu girin",

        image: "Resim <img> Ctrl+G",
        imagedescription: "resim tanımı girin",
        imagedialog: "<p><b>Resim girin</b></p><p>http://example.com/images/some-image.jpg \"ek tanım\"</p>",

        olist: "Sıralı liste <ol> Ctrl+O",
        ulist: "Sırasız liste <ul> Ctrl+U",
        litem: "Liste eleman",

        heading: "Başlık <h1>/<h2> Ctrl+H",
        headingexample: "Başlık",

        hr: "Metin kesme <hr> Ctrl+R",

        undo: "Undo - Ctrl+Z",
        redo: "Redo - Ctrl+Y",
        redomac: "Redo - Ctrl+Shift+Z",

        help: "Önizleme"
    };
})();