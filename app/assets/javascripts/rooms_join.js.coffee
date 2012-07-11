# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(->
  # Define the whole code as the function init. Only execute init when the page is #rooms_join (see the end of the file for this execution)
  init = ->
    # Get room_id and user_id from attributes rendered in the page
    room_id = $("#question_container").attr("room_id");

    client = new Pusher('9a81f498ef1031e46675');
    channel = client.subscribe("presence-room_"+room_id);
    # Listen to the "pusher:member_removed" event which keep tracks of user leaving the room
    channel.bind('pusher:member_removed', (member) ->
      # Send a POST request to rooms#kick, which kick the user from the room
      # Performance might be not ideal because everyone in the room will kick this member at the same time (we need only one)
      $.ajax({
        type: "POST",
        url : "/rooms/kick",
        data: {
          user_id: member.id
        },
        success: (data) ->
          update_users();
      });
    );
    # Listen to the "users_change" event which keeps track of users joining/leaving the room
    channel.bind("users_change", (data) ->
      update_users();
      true;
    );

    # Listen to the "show_explanation" event which keeps track of whether to show explanation or not
    channel.bind("show_explanation", (data) ->
      # Get the choice_id by finding the "btn-primary" class
      choice_id = $("#current_question .each_choice.btn-primary").attr("id");
      show_explanation(data.question_id, choice_id);
      true;
    );
    
    # Update the histories
    channel.bind("update_hitories", (data) ->
      update_histories(data.history_id);
      true;
    );
    
    update_histories=(history_id)->
      $.ajax({
        type: "POST",
        url: "/histories/show_history",
        data: {
          history_id: history_id
        },
        success: (data) ->
          $("#history").append(data);
      });
      true;

    # Listen to the "next_question" event which keeps track of whether to show next question
    channel.bind("next_question", (data) ->
      change_question(data.question_id);
      true;
    );
    # Input: none
    # Effect: update the user list to div#top_nav
    update_users = ->
      $.ajax({
        type: "POST",
        url: "/rooms/user_list",
        success: (data) ->
          $("#top_nav").html(data);
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
          choice_id: choice_id
        },
        success: (data) ->
          $(".choices").html(data);
      });
      # Show the ready button
      $("#ready").show();
      # Remove the confirm button
      $("#confirm").remove();

    confirm_answer = (choice_id) ->
      # Send a POST request to "/rooms/choose" (rooms#choose)
      $.ajax({
        type: "POST",
        url: "/rooms/choose/",
        data: {
          choice_id: choice_id
        },
        success: (data) ->
          $("#next").attr("question_id",data.next_question_id);
        dataType: "json"
      });
      # Hide the confirm button
      $(this).hide();
      # Remove question_active class so that the choices are not clickable
      $("#current_question").removeClass("question_active");
      # Disable the button for each choice
      $(".each_choice").addClass("disabled");
    
    expire = -> confirm_answer(0);
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
      $("#confirm").show();
      true;
    );

    # User confirming the answer
    $(".question_active#current_question #confirm").live("click", ->
      # Get the choice_id by finding the "btn-primary" class
      choice_id = $(".question_active#current_question .each_choice.btn-primary").attr("id");
      confirm_answer(choice_id);

      # Send a POST request to "/rooms/choose" (rooms#choose)
      $.ajax({
        type: "POST",
        url: "/rooms/choose/",
        data: {
          choice_id: choice_id
        },
        success: (data) ->
          $("#next").attr("question_id",data.next_question_id);
        dataType: "json"
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
      });
      true;
    );

    $("#timer").countdown({
      until: 10,
      compact: true,
      format: 'S',
      description: '',
      onExpiry: expire
    });
    true;


    # Show all the previous histories
    update_previous_histories= ->
      $.ajax({
        type: "POST",
        url: "/rooms/show_histories",
        data: {
          room_id: room_id
        },
        success: (data) ->
          $("#history").html(data);
      });
      true;
  
    update_previous_histories();
  
    true;

  # Only execute the above code if the page is rooms_join
  if $("#rooms_join").length
    init();

);
