# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(->
    client = new Faye.Client("http://localhost:9292/faye");

    # Subscribe to the "/rooms/question_choose" channel
    rooms_question = client.subscribe("/rooms/question_choose", (data) ->
      alert(data.user_id+" chose "+data.choice_id);
      true;
    );

    # Define the change_question function that takes a question_id and changes HTML content of #current_question
    change_question = (question_id) ->
      $.ajax({
        type: "POST",
        url: "/rooms/show_question",
        data: {
          question_id: question_id
        },
        success: (data) ->
          $("div#question_container").html(data);
      });
      true;

    # Set question the first time
    current_question_id = $("div#question_container").attr("question_id");
    change_question(current_question_id);

    # When an user chooses an answer
    $("div.current_question .choice a").live("click", ->
      choice_id = $(this).parents(".choice").attr("id");
      user_id = $(this).parents("#question_container").attr("user_id");
      room_id = $(this).parents("#question_container").attr("room_id");

      # Publish to the channel "/rooms/question_choose"
      client.publish("/rooms/question_choose", {
        choice_id: choice_id,
        user_id: user_id
      });

      # Send a POST request to "/rooms/choose" (rooms#choose)
      $.ajax({
        type: "POST",
        url: "/rooms/choose/",
        data: {
          choice_id: choice_id,
          room_id: room_id,
          user_id: user_id
        },
        success: (data) ->
          change_question(data.id);
        dataTye: "json"
      });

      true;
    );
    true;
);
