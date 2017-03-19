if(typeof(console) === 'undefined') {var console = {}; console.log = function() {};}
(function($) {
$.fn.fps_slider = function(options) {  
	var settings = {  
		slider_id: '#fps_slider',
		pagination_id: '#fps_pagination',
		pagination_current_class: 'js-current',
		slider_duration: 3, //seconds
		slider_max_count: 18,
		slider_max_time: 60 // minutes
	};
	if(options) {
		$.extend(settings, options);
	}
	return this.each(function() {
		var obj = $(this),
			slider = $(settings.slider_id, obj),
			slider_children = slider.children(),
			pagination_children = $(settings.pagination_id, obj).children(),
			slider_count = ((slider_children.length + 1) > settings.slider_max_count ? settings.slider_max_count : (slider_children.length - 1)),
			current = 1,
			previous = 0,
			counter = 0,
			counter_max = Math.round(settings.slider_max_time*60*1000/settings.slider_duration*1000),
			do_slider;
		function animate() {
			if(counter < counter_max) {
				slider_children.eq(previous).hide();
				slider_children.eq(current).show();
				pagination_children.removeClass(settings.pagination_current_class);
				pagination_children.eq(current).addClass(settings.pagination_current_class);
				current = (current >= slider_count ? 0 : current + 1);
				previous = (previous >= slider_count ? 0 : previous + 1);
				counter++;
			} else {
				clearInterval(do_slider);  
			}
		}
		if(slider_count >= 1) {
			// load_from_file animation
			do_slider = setInterval(animate, settings.slider_duration*1000);
			// slider interactions
			slider.bind('mouseenter.fps_slider', function() {
                clearInterval(do_slider);
			}).bind('mouseleave.fps_slider', function() {
				do_slider = setInterval(animate, settings.slider_duration*1000);
			});
			// pagination interactions
			pagination_children.each(function(index, element){
				$(this).bind('mouseenter.fps_slider', function() {
					clearInterval(do_slider);
					slider_children.eq(previous).hide();
					slider_children.eq(index).show();
					$(this).siblings().removeClass(settings.pagination_current_class);
					$(this).addClass(settings.pagination_current_class);
				}).bind('mouseleave.fps_slider', function() {
					previous = index;
					current = (index >= slider_count ? 0 : index + 1);
					do_slider = setInterval(animate, settings.slider_duration*1000);
					if(counter >= counter_max) {
						counter = 0;
					}
				});
			});
			var slider_article = slider.filter('.slider-article');
			$('<div class="slider-nav_left">←</div>').click(function() {
				var	article_pagination_index = previous - 1;
				if(article_pagination_index < 0 ) {
					article_pagination_index = slider_count - 1;
				}
				pagination_children.eq(article_pagination_index).trigger('mouseenter.fps_slider').trigger('mouseleave.fps_slider');
			}).appendTo(slider_article);
			$('<div class="slider-nav_right">→</div>').click(function() {
				var	article_pagination_index = previous + 1;
				if(article_pagination_index > slider_count - 1) {
					article_pagination_index = 0
				}
				console.log(article_pagination_index);
				pagination_children.eq(article_pagination_index).trigger('mouseenter.fps_slider').trigger('mouseleave.fps_slider');;
			}).appendTo(slider_article);
		}
	});	
};
})(jQuery);