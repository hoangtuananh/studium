$(->
  client = new Faye.Client("http://localhost:9292/faye");
  
  # Subscribe to the "rooms/create" channel
  rooms_create = client.subscribe("/rooms/create", (data) ->
    $("#room_list").append("<li><a href='/rooms/join/"+data.id+"'>"+data.title+"</a></li>");
    true;
  );
);
