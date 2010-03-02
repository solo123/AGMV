var timeout = 500;
var closetimer = 0;
var ddmenuitem = 0;

function jsddm_open() {
    jsddm_canceltimer();
    jsddm_close();
    ddmenuitem = $(this).find('ul').eq(0).css('visibility', 'visible');
}

function jsddm_close()
{ if (ddmenuitem) ddmenuitem.css('visibility', 'hidden'); }

function jsddm_timer()
{ closetimer = window.setTimeout(jsddm_close, timeout); }

function jsddm_canceltimer() {
    if (closetimer) {
        window.clearTimeout(closetimer);
        closetimer = null;
    }
}




function create_menu() {
    $('#main_menu').html("<div class='loading'>loading menu ...</div>");
    
    LoadWebServiceString("../AdminService/MenuService.asmx/MainMenuUl", function(msg) {
        $('#main_menu').html(msg.d);
        $('#jsddm').superfish();
/*
        $('#jsddm > li').bind('mouseover', jsddm_open);
        $('#jsddm > li').bind('mouseout', jsddm_timer);
*/
        // command
        $('#jsddm a[url]').click(function() {
            var url = $(this).attr('url');
            //$('#main_container').html("<div class='loading'>Loading...</div>").load(url);
            window.location.href = url;
        });
    });
}

function LoadWebServiceString(serviceUrl, callback) {
    $.ajax({
        type: "POST",
        url: serviceUrl,
        data: "{}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(msg) {
            // Do interesting things here.
            callback(msg);
        },
        error: function(xml, status) {
            if (status == 'error') {
                try {
                    var json = eval('(' + xml.responseText + ')');
                    //alert("ERROR: " + json.Message + '\n' + json.StackTrace);
                    $('#result').html("ERROR: " + json.Message + '\n' + json.StackTrace);
                } catch (e) { }
            } else {
                alert(status);
            }
        }
    });
}
    
    