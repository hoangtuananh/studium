function remove_question(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_question(link, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_questions", "g");
  $(link).parent().before(content);
}
