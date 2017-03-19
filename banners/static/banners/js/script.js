$(function () {
    $('.js-banner').click(function () {
        var id = $(this).attr('id');
        if (id) {
            $.get('/banners/click/' + id + '/');
        }
        return true;
    });

    (function () {
        $('.js-change_banner').each(function () {
            var b_banner = $(this).children();
            var b_banner_count = b_banner.length;
            var b_duration = 10000;
            var b_current = b_banner.eq(0);
            var b_prev = [];
            var b_next;
            var b_counter = 0;
            var b_counter_max = Math.round(30 * 60 * 1000 / b_duration);
            var b_do_slider;

            function b_animate() {
                if (b_counter < b_counter_max) {
                    if (b_prev.length) {
                        b_prev.css('display', 'none');
                    }
                    b_current.css('display', 'block');
                    b_prev = b_current;
                    b_next = b_current.next();
                    b_current = (b_next.length ? b_next : b_banner.eq(0));
                    b_counter++;
                } else {
                    clearInterval(b_do_slider);
                }
            }

            // load_from_file animation
            if (b_banner_count > 1) {
                b_do_slider = setInterval(b_animate, b_duration);
            }
        });
    })();

});