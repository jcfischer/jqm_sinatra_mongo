function post_event(form, back_page) {
    var the_form = $(form);
    // find the action of the form and post its contents
    $.post(the_form.attr('action'), the_form.serialize(), function (data) {
        console.log("data saved");
        // return to previous page
        $.mobile.changePage(back_page, { transition:"slide", reverse:true});
    });

}

$('#new_page').live('pageinit', function (event) {
    console.log("page #new was created")
    $('#event_form').submit(function () {
        console.log("submit event of form");
        post_event('#event_form', '#list_page');
        return false;  // to prevent actual submit from happening
    });
    $('#save_button').click(function () {
        console.log('click even of header button');
        post_event('#event_form', '#list_page');
        return false;
    })
});


// from: https://gist.github.com/921920
// based on discussion here: http://forum.jquery.com/topic/forcing-fresh-content

// force certain pages to be refreshed every time. mark such pages with
// 'data-cache="never"'
//
jQuery('div').live('pagehide', function (event, ui) {
    var page = jQuery(event.target);

    if (page.attr('data-cache') == 'never') {
        page.remove();
    }
    ;

});



