jQuery(document).ready(function() { content_height(); });
jQuery(window).resize(function()  { content_height(); });
function content_height(){
	var window_height 	= jQuery(window).height();
	var header_height  	= jQuery("#headd").outerHeight();
	var nav_height 		= jQuery("#menu").outerHeight();
	var foot 			=jQuery("footer").outerHeight();
	var slider			= jQuery("#slider").outerHeight();
	var final			= window_height - (header_height + nav_height + slider);
	var tabler 			= window_height - (header_height);
	var content 		=jQuery(".content").outerHeight();

	jQuery("#bolitas").height(final);

	if (tabler < content) {
		jQuery("footer").removeClass("abs");
	}

}

