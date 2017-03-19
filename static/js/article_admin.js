$(function() {
   $('.inline-group').wrap('<fieldset class="module aligned collapse collapsed"></fieldset>')
   $.each($('.inline-group .module h2'), function() {
       label = '<h2>' + $(this).html() + '</h2>';
       $(this).parent().parent().parent().before(label);
       $(this).remove();
   });
});