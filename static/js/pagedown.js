$(function(){
    var obj = $('#id_content');
    if (obj.length) {
        var content = obj.val();
        if (content) {
            content = content.replace(/<!--more-->/g, '<hr>').replace(/\r\n|\r/g, '\n');
            content = toMarkdown(content);
        }
        obj.prev('.required').after('<br class="clear">');
        obj.after('<div id="epiceditor" style="height:400px;"></div><br class="clear">');
        obj.hide();
        var md = HTML2Markdown(html);
        content.replaceWith('<div class="wmd"><div class="wmd-panel"><div id="wmd-button-bar"></div><textarea class="wmd-input" id="wmd-input">' + md
            + '</textarea></div><div id="wmd-preview" class="wmd-panel wmd-preview"></div></div>');
        var converter = Markdown.getSanitizingConverter();
        var editor = new Markdown.Editor(converter);
        editor.run();
    }
});