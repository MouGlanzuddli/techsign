$(function() {
    $("#keywordInput").autocomplete({
      source: function(request, response) {
        $.ajax({
          url: "CompanySearchSuggestionServlet",
          dataType: "json",
          data: {
            term: request.term
          },
          success: function(data) {
            response(data);
          }
        });
      },
      minLength: 1,
      select: function(event, ui) {
        $("#keywordInput").val(ui.item.value);
        return false;
      }
    });
  });
 