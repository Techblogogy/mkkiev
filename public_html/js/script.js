$(function () {

    $('.slider').fps_slider({max_count: 18, slider_max_time: 0});
    $('#rusyada-turk-is-dunyasi,#aile-saglik,#turk-mutfagi,#popular').fps_slider({slider_id: '#business_news-content', pagination_id: '#business_news-navbar', max_count: 7});
    $('#tureckij-biznes-v-rossii').fps_slider({slider_id: '#business_news-content', pagination_id: '#business_news-navbar', max_count: 5});
    $('.namaz-city-right_arrow').click(function () {
        var namaz = $(this).parents('.namaz-item');
        if (namaz.is(':last-child')) {
            namaz.siblings().first().show();
        } else {
            namaz.next().show();
        }
        namaz.hide();
    });
    $('.namaz-city-left_arrow').click(function () {
        var namaz = $(this).parents('.namaz-item');
        if (namaz.is(':first-child')) {
            namaz.siblings().last().show();
        } else {
            namaz.prev().show();
        }
        namaz.hide();
    })
});