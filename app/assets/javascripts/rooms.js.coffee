# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(->
    user_id = $("#question_container").attr("user_id");
    room_id = $("#question_container").attr("room_id");

    client = new Pusher("9a81f498ef1031e46675");
    channel = client.subscribe("room_"+room_id);
    channel.bind("test", (data) ->
      alert(data);
      true;
    );
    # Subscribe to the "/rooms/users_change/.." channel which keeps track of users joining/leaving the room
    rooms_users_change = channel.bind("users_change", (data) ->
      update_users();
      true;
    );

    # Subscribe to the "/rooms/show_explanation/.." channel which keeps track of whether to show explanation or not
    rooms_show_explanation = channel.bind("show_explanation", (data) ->
      show_explanation(data.question_id, data.choice_id);
      true;
    );

    # Subscribe to the "/rooms/next_question/.." channel which keeps track of whether to show next question
    rooms_show_next_question = channel.bind("next_question", (data) ->
      change_question(data.question_id);
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
          room_id: room_id,
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

      # Send a POST request to "/rooms/choose" (rooms#choose)
      $.ajax({
        type: "POST",
        url: "/rooms/choose/",
        data: {
          choice_id: choice_id,
          room_id: room_id
        },
        success: (data) ->
          $("#next").attr("question_id",data.next_question_id);
          #show_explanation(data.current_question_id,data.choice_id);
        dataTye: "json"
      });
      # Hide the confirm button
      $(this).hide();
      # Remove question_active class so that the choices are not clickable
      $("#current_question").removeClass("question_active");
      # Disable the button for each choice
      $(".each_choice").addClass("disabled");
      # Show the ready button
      $("#ready").show();

      true;
    );
    # User clicking "ready"
    $("#ready").live("click", ->
      $.ajax({
        type: "POST",
        url: "/rooms/ready",
        data: {
          room_id: room_id,
        },
      });
      true;
    );
    true;
);
