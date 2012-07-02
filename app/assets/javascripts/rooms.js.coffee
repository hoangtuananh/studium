# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(->
    client = new Faye.Client('http://localhost:9292/faye');

    rooms_question = client.subscribe('/rooms/question', (data) ->
      alert(data.user_id+" chose "+data.choice_id);
    );
);
