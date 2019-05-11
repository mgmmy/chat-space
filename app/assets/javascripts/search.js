$(function() {
  var searchList = $('#user-search-result');
  var memberList = $('#chat-group-users');
  var userIds = $('#user_ids').attr('value');

  function appendUser(user) {
    if (userIds.indexOf(user.id) == -1) {
      var html = `<div class="chat-group-user clearfix">
                    <p class="chat-group-user__name">${ user.name }</p>
                    <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${ user.id }" data-user-name="${ user.name }">追加</a>
                  </div>`
        searchList.append(html);
    }
  }

  function appendErrMsgToHTML(msg) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${ msg }</p>
                </div>`
    searchList.append(html)
  }

  function appendMember(name, id) {
    var html = `<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-${ id }'>
                  <input name='group[user_ids][]' type='hidden' value='${ id }'>
                  <p class='chat-group-user__name'>${ name }</p>
                  <div class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</div>
                </div>`
      memberList.append(html);
  }

  $('.chat-group-form__input').on('keyup', function() {
    var preWord;
    var input = $('#user-search-field').val();
    if (input !== preWord && input.length !== 0) {
      $.ajax({
        type: 'GET',
        url: '/users/search',
        data: { keyword: input },
        dataType: 'json'
      })
      .done(function(users) {
        if (users.length !== 0) {
          users.forEach(function(user) {
            setTimeout(function() {
              appendUser(user);
            }, 150)
          });
        }
        else {
          appendErrMsgToHTML("一致するユーザーが見つかりません");
        }
      })
      .fail(function() {
        alert("ユーザー検索に失敗しました");
      })
    }
    preWord = input
    $('#user-search-result').empty();
  });

  $('#user-search-result').on('click', '.user-search-add', function() {
    var userName = $(this).prev().text();
    var userId = $(this).data('userId');
    $(this).parent().remove();
    appendMember(userName, userId);
  });

  $('#chat-group-users').on('click', '.user-search-remove', function() {
    $(this).parent().remove();
  });
});
