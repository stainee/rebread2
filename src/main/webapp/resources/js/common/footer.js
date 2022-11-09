
const topbtn = $("#remote");
$(window).scroll( function() {
	if ($( this ).scrollTop() > 200 ) {
        topbtn.fadeIn();
	} else {
        topbtn.fadeOut();
	}
} );

topbtn.click( function() {
	$( 'html, body' ).animate({scrollTop:0},400);
	return false;
} );