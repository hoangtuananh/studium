$(->
  init = ->
    client = new Pusher('9a81f498ef1031e46675');
    channel = client.subscribe('rooms');
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
    rooms_create = channel.bind("create", (data) ->
      update_room_list();
      true;
    );
    true;
  if $("#rooms_index").length
    init();
);
