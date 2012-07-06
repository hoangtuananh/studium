$(->
  client = new Faye.Client("http://localhost:9292/faye");
  update_room_list = ->
    $.ajax({
      type: "POST",
      url: "/rooms/room_list.html"
      success: (data) ->
        $("#room_list").html(data);
        true;
    });
    true;
  
  update_room_list();
  # Subscribe to the "rooms/create" channel
  rooms_create = client.subscribe("/rooms/create", (data) ->
    update_room_list();
    true;
  );
);
