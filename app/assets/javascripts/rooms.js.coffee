# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(->
    client = new Faye.Client("http://localhost:9292/faye");

    rooms_question = client.subscribe("/rooms/question_choose", (data) ->
      #alert(data.user_id+" chose "+data.choice_id);
    );

    $("div.current_question .choice a").click(->
      choice_id = $(this).parents(".choice").attr("id");
      user_id = $(this).parents(".current_question").attr("user_id");
      room_id = $(this).parents(".current_question").attr("room_id");

      client.publish("/rooms/question_choose", {
        choice_id: choice_id,
        user_id: user_id
      });
      $.ajax({
        type: "POST",
        url: "/choose/",
        data: {
          choice_id: choice_id,
          room_id: room_id,
          user_id: user_id
        },
        success: (data) ->
          alert(data);
        dataTye: "json"
      });

      true;
    );
);
