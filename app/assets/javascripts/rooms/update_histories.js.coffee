$(->
  # Get room_id and user_id from attributes rendered in the page
  room_id = $("#question_container").attr("room_id");

  client = new Pusher('9a81f498ef1031e46675');
  channel = client.subscribe("presence-room_"+room_id);

  # Update the histories
  channel.bind("update_histories", (data) ->
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

  if $("#rooms_join").length
    # Update the histories of the room
    update_previous_histories();
);
