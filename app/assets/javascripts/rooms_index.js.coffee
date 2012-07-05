$(->
  client = new Faye.Client("http://localhost:9292/faye");
  
  # Subscribe to the "rooms/create" channel
  rooms_create = client.subscribe("/rooms/create", (data) ->
    $.ajax({
      type: "POST",
      url: "/rooms/show_new_room_item/"
      data: {
        room_id: data.room_id
      },
      success: (data) ->
        $("#room_list").append(data);
        true;
    });
    true;
  );
);
