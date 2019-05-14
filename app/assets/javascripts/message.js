$(function(){
  function buildPostMessage(message) {
    var img = ""
    if (message.image.url !== null) {
      img = `<img src="${ message.image.url }">`
    }
    var html = `<div class="messages__message" data-message_id="${ message.id }">
                  <div class="messages__message__upper-info">
                    <p class="messages__message__upper-info__user">
                      ${ message.user_name }
                    </p>
                    <p class="messages__message__upper-info__date">
                      ${ message.created_at }
                    </p>
                  </div>
                  <div class="messages__message__lower-message">
                    <p class="messages__message__lower-message__text">${ message.text }</p>
                    ${ img }
                  </div>
                </div>`
    return html;
  }
  $('#new-message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var href = $(this).attr('action')
    $.ajax({
      url: href,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(message){
      var html = buildPostMessage(message);
      $('.messages').append(html);
      $('#new-message')[0].reset();
      $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight });
      $('.new-message__submit-btn').attr('disabled', false);
    })
    .fail(function(){
      alert('error');
      $('.new-message__submit-btn').attr('disabled', false);
    })
  })

  var reloadMessages = function() {
    var lastMessageId = $('.messages__message:last').data('message_id');
    console.log(lastMessageId);
    var groupId = $('.chat-main__header__current-group').data('group_id');
    $.ajax({
      url: '/groups/' + groupId + '/api/messages',
      type: 'GET',
      data: { id: lastMessageId },
      dataType: 'json'
    })
    .done(function(messages) {
      if (messages.length !== 0) {
        messages.forEach(function(message) {
          var html = buildPostMessage(message);
          $('.messages').append(html);
          $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight });
        });
      }
    })
    .fail(function() {
      console.log('error');
    })
  };
  setInterval(reloadMessages, 5000);
});
