if (typeof(console) === 'undefined') {var console = {}; console.log = function() {};}
$(function() {
    var url, title;
    if (window.location.pathname == '/admin/headlines/headline/') {
        url = '/admin/articles/article/';
        title = 'Все статьи';
    } else {
        url = '/admin/headlines/headline/';
        title = 'Maншет';
    }
    $('<input>').attr('type', 'button').val(title).addClass('default')
        .css({float:'right', margin:'3px 4px 0 0'})
        .click(function() { window.location = url; })
        .appendTo($('.change-list .paginator'));
});
