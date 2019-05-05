$(function(){
  function buildHTML(message) {
    var img = ""
    if (message.image.url !== null) {
      img = `<img src="${ message.image.url }">`
    }
    var html = `<div class="messages__message">
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
    .done(function(data){
      var html = buildHTML(data);
      $('.messages').append(html)
      $('.new-message__input-box__text').val('')
      $('.new-message__input-box__image-label__input').val('')
      $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight });
      $('.new-message__submit-btn').attr('disabled', false);
    })
    .fail(function(){
      alert('error');
      $('.new-message__submit-btn').attr('disabled', false);
    })
  })
});
