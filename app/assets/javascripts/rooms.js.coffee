# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(->
    client = new Faye.Client("http://localhost:9292/faye");

    user_id = $("#question_container").attr("user_id");
    room_id = $("#question_container").attr("room_id");

    # Subscribe to the "/rooms/choose/..." channel which keeps track of users choosing answer
    rooms_question = client.subscribe("/rooms/choose/"+room_id, (data) ->
      alert(data.user_id+" chose "+data.choice_id);
      true;
    );

    # Subscribe to the "/rooms/join/.." channel which keeps track of online users
    rooms_join = client.subscribe("/rooms/join/"+room_id, (data) ->
      $(".online ul").append("<li>"+data.first_name+" "+data.last_name+"</li>");
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

    # User clicking on a choice
    # Add class "selected" to the chosen choice
    $("#current_question .choices li").live("click", ->
      choice_id = $(this).attr("id");
      $(this).addClass("selected");
      true;
    );

    # User confirming the answer
    $("#current_question #confirm").live("click", ->
      # Get the choice_id by finding the "selected" class
      choice_id = $("#current_question li.selected").attr("id");
      # Publish to the channel "/rooms/question_choose"
      client.publish("/rooms/choose/"+room_id, {
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
