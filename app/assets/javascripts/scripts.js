$(document).ready(function() {

    $('#tournament-upload').click(function() {
        $('#tourney-form').toggle();
        $('#fox-waveshine').removeClass('hidden');
    });

    $('#search-smashers').change(function() {
        var tag = $(this).val().toLowerCase();
        if(tag == "") {
            $('.smasher').each(function() {
                if($(this).is(":visible"))
                    $(this).slideToggle();
            })
        } else {
            checkSmashers(tag);
        }
    });

    $('input[name="smashers[][name]"]').change(function() {
        var tag_to_check = $(this).val(),
            dom = $(this),
            status = false;

        $.ajax ({
            type: 'GET',
            url: "/smashers/doesExist",
            dataType: "json",
            data: { tag: tag_to_check},
            success: function(data) {
                if(data["does_exist"] == "true") {
                    sign = '<span class="glyphicon glyphicon-ok alert alert-player alert-success" aria-hidden="true"></span>';
                    dom.parent().parent().find(".tag-status").html(sign);
                } else {
                    sign = '<span class="glyphicon glyphicon-warning-sign alert alert-player alert-warning" aria-hidden="true"></span>';
                    dom.parent().parent().find(".tag-status").html(sign);
                }
            }
        });
    });
});

function isSmasher(tag_to_check) {
    var ret;


    return ret;
}

function checkSmashers(tag_to_check) {
    tag_to_check = tag_to_check.toLowerCase();
    var smashers = $('.smasher');

    smashers.each(function(index) {
        tag = $(this).text().toLowerCase();
        if(tag.indexOf(tag_to_check) < 0 && $(this).is(":visible"))
            $(this).slideToggle();
        else if(tag.indexOf(tag_to_check) >= 0 && $(this).is(":hidden"))
            $(this).slideToggle();
    });
}