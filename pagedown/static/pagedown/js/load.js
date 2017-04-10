if (typeof(console) === "undefined") { var console = {}; console.log = function() {}; }
(function () {

    // fileuplader

    var django_media_url = "http://media." + window.location.hostname.replace(/^www./, "") + "/";
    var upload_image_link;

    var uploader = new qq.FileUploader({
        element: document.getElementById("file-uploader"),
        action: "/upload/image/",
        multiple: false,
        acceptFiles: ["jpg", "gif", "jpeg", "png"],
        uploadButtonText: "Загрузить рисунок",
        sizeLimit: 375767,
        onComplete: function(id, fileName, responseJSON) {
            if (responseJSON.success) {
                fileName = URLify(fileName).replace(/(jpe?g|png|gif)$/, '.$1');
                upload_image_link = django_media_url + "images/upload/" + fileName;
                document.getElementById("wmd-image-button").click();
            }
        },
        onSubmit: function(id, fileName) {
            fileName = URLify(fileName).replace(/(jpe?g|png|gif)$/, '.$1');
        }
    });

    // PageDown

    var options = {
        strings: Markdown.local.localStrings,
        helpButton: { handler: function () {
            var obj = document.getElementById("wmd-preview");
            if (obj.style.display == "block") {
                obj.style.display = "none";
            } else {
                obj.style.display = "block";
            }
        }}
    };

    var converter;
    try {
        converter = Markdown.getSanitizingConverter();
    } catch(err) {
        converter = new Markdown.Converter();
    }
    var editor = new Markdown.Editor(converter, "", options);

    editor.hooks.set("insertImageDialog", function (linkEnteredCallback) {
        if (upload_image_link) {
            editor.ui.prompt('Uploaded image:', upload_image_link, linkEnteredCallback);
            upload_image_link = null;
            return true;
        }
        return false;
    });

    editor.run();

    var form = document.getElementById("article_form");
    form = form ? form : document.getElementById("news_form");
    form = form ? form : document.getElementById("blog_form");
    form = form ? form : document.getElementById("photogallery_form");
    form = form ? form : document.getElementById("videogallery_form");
    form = form ? form : document.getElementById("headline_form");
    form = form ? form : document.getElementById("flatpage_form");

    function addMarkdownToContent() {
        var preview = document.getElementById("wmd-preview").innerHTML;
        var content = document.getElementById("id_content");
        content.value = preview.replace(/<hr>/g, '<!--more-->');
    }

    try {
        form.addEventListener("submit", addMarkdownToContent, false);
    } catch(e) {
        form.attachEvent("onsubmit", addMarkdownToContent); //Internet Explorer 8-
    }

})();
/*var converter = new Markdown.Converter();
converter.hooks.chain("preConversion", function (text) {
    return text.replace(/\b(a\w*)/gi, "*$1*");
});
converter.hooks.chain("plainLinkText", function (url) {
    return "This is a link to " + url.replace(/^https?:\/\//, "");
});
var help = function () { alert("Do you need help?"); }
var options = {
    helpButton: { handler: help },
    strings: { quoteexample: "whatever you"re quoting, put it right here" }
};
var editor = new Markdown.Editor(converter, "", options);
editor.run();*/