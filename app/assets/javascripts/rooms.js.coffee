# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(->
    client = new Faye.Client("http://localhost:9292/faye");

    user_id = $("#question_container").attr("user_id");
    room_id = $("#question_container").attr("room_id");

    # Subscribe to the "/rooms/choose/..." channel which keeps track of users choosing answer
    rooms_question = client.subscribe("/rooms/choose/"+room_id, (data) ->
      true;
    );

    # Subscribe to the "/rooms/users_change/.." channel which keeps track of users joining/leaving the room
    rooms_users_change = client.subscribe("/rooms/users_change/"+room_id, (data) ->
      update_users();
      true;
    );

    # Input:
    # Effect: update the user list to div#online
    update_users = ->
      $.ajax({
        type: "POST",
        url: "/rooms/user_list",
        data: {
          room_id: room_id
        },
        success: (data) ->
          $("#online").html(data);
          true;
      });
      true;

    # Input: question_id
    # Effect: changes HTML content of #current_question to show the new question
    change_question = (question_id) ->
      $.ajax({
        type: "POST",
        url: "/rooms/show_question",
        data: {
          question_id: question_id
        },
        success: (data) ->
          $("#question_container").html(data);
      });
      true;

    # Input: question_id and choice_id
    # Effect: render the explanation for the given question
    show_explanation = (question_id,choice_id) ->
      $.ajax({
        type: "POST",
        url: "/rooms/show_explanation",
        data: {
          question_id: question_id,
          choice_id: choice_id
        },
        success: (data) ->
          $(".choices").html(data);
      });

    
    # Set question the first time
    current_question_id = $("#question_container").attr("question_id");
    change_question(current_question_id);
    # Update the user list the first time
    update_users();

    # User clicking on a choice
    # Add class "btn-primary" to the chosen choice
    $(".question_active#current_question .choices .each_choice").live("click", ->
      choice_id = $(this).attr("id");
      $(this).siblings().removeClass("btn-primary");
      $(this).addClass("btn-primary");
      true;
    );

    # User confirming the answer
    $(".question_active#current_question #confirm").live("click", ->
      # Get the choice_id by finding the "btn-primary" class
      choice_id = $(".question_active#current_question .each_choice.btn-primary").attr("id");
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
          $("#next").attr("question_id",data.next_question_id);
          show_explanation(data.current_question_id,data.choice_id);
        dataTye: "json"
      });
      # Hide the confirm button
      $(this).hide();
      # Remove question_active class so that the choices are not clickable
      $("#current_question").removeClass("question_active");
      # Show the next button
      $("#next").show();

      true;
    );
    # User clicking "Next"
    $("#next").live("click", ->
      change_question($(this).attr("question_id"));
    );
    true;
);
