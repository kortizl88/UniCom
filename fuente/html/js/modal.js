jQuery("#abrir_modal").click(function() {
	var contenedor_modal = "#" + jQuery(this).attr("modal");
	jQuery(contenedor_modal).css('top', get_header_height());
	jQuery(contenedor_modal).fadeIn("normal");
});

jQuery("#cerrar_modal").click(function() {
	jQuery(".modal").fadeOut("fast");
});



function get_header_height(){
	var header_height  	= jQuery("header").outerHeight();
	var nav_height 		= jQuery("nav").outerHeight();
	var final 			= header_height + nav_height;
	return final;
}


