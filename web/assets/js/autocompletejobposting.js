$(function () {
    $(".autocomplete-keyword").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: "JobSkillSuggestionServlet",
                dataType: "json",
                data: {
                    term: request.term
                },
                success: function (data) {
                    response(data);
                }
            });
        },
        minLength: 1,
        select: function (event, ui) {
            $(this).val(ui.item.value);
            return false;
        }
    });
    

});