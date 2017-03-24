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

    (function () {
        $('.a-block-items').each(function () {
            var b_banner = $(this).children();
            // var b_banner = b_banner.slice(-1,1);

            var b_banner_count = b_banner.length;

            var b_duration = 5000;
            // var b_counter_max = Math.round(30 * 60 * 1000 / b_duration);

            var b_current = [b_banner.eq(0), b_banner.eq(1), b_banner.eq(2)];
            var b_prev = [];
            var b_next;
            var b_counter = 0;
            var b_do_slider;

            console.log(b_banner.eq(2).next().length);

            function b_animate() {
                // if (b_counter < b_counter_max) {

                for (var i=0; i<b_current.length; i++){
                    b_current[i].css('display', 'none')
                    // b_next = b_current[i].next().next().next()

                    for (var y=0; y<3; y++) {
                        b_next = b_current[i].next();
                        b_current[i] = (b_next.length ? b_next : b_banner.eq(0));
                    }

                    // var b_off = 0;
                    // while (b_next.length != 0 && b_off < 3) {
                    //     b_next = b_current[i].next()
                    //     console.log(b_next.length);
                    //     b_off++;
                    // }

                    // console.log(b_next);
                    b_current[i].css('display', 'block');
                    // b_current[i] = b_next;
                    // b_current[i].css('display', 'block');
                    // b_current[i] = (b_next.length)
                }


                // if (b_prev.length) {
                //     b_prev.css('display', 'none');
                // }
                // b_current.css('display', 'block');
                // b_prev = b_current;
                // b_next = b_current.next();
                //
                // b_current = (b_next.length ? b_next : b_banner.eq(0));
                //
                // b_counter++;

                // } else {
                //     clearInterval(b_do_slider);
                // }
            }

            // load_from_file animation
            if (b_banner_count > 3) {
                b_do_slider = setInterval(b_animate, b_duration);
            }
        });
    })();

});
