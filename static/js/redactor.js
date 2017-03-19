function getCookie(name) {
	var cookieValue = null;
	if (document.cookie && document.cookie != '') {
		var cookies = document.cookie.split(';');
		for (var i = 0; i < cookies.length; i++) {
			var cookie = jQuery.trim(cookies[i]);
			// Does this cookie string begin with the name we want?
			if (cookie.substring(0, name.length + 1) == (name + '=')) {
				cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
				break;
			}
		}
	}
	return cookieValue;
}
$(function(){
    $("#id_content").css({height:'300px',width:'100%'}).redactor({
    	path:'/js/redactor/',
		image_upload: '/upload/image/',
		imageUploadFunction: false, // callback function
		file_upload: '/upload/file/',	
		file_download: '/upload/file/?file=',		
		file_delete: '/upload/file/?delete=',		
		fileUploadFunction: false, // callback function
    	toolbar:'article',
    	css:['redactor.css']
    });
});