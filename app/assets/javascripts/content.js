$(function() {
  if ($('#content_description').length) {
    var content_description = markdown.toHTML($('#content_description').html());
    $('#content_description').html(content_description);
  }

  // ContentMessageDialog --------------------
  if ($('#showContentMessageDialog').length) {

    $('#showContentMessageDialog').on('shown.bs.modal', function() {
      $('#message').focus();
    });

    $('#content_message_save_btn').on('click', function() {
      var content_id = ($('#content_id').length) ? $('#content_id').val() : '';
      if (content_id == null || content_id == '') {
        return false;
      }
      var message = $('#message').val();
      var user_name = $('#user_name').val();
      $.ajax({
        type: 'POST',
        url: '/message/create',
        data: { content_id: content_id, body: message, user_name: user_name },
        success: function(data, dataType) {
          if (typeof data != 'undefined' && data != null) {
            var data = {
              id: data.id,
              message: markdown.toHTML(data.body),
              user_name: data.user_name,
              updated_at: Anithre.Utility.formatDate(new Date(data.updated_at), '%Y-%m-%d %H:%M:%S')
            };
            $('.content-message').prepend($('#content_each_message').render(data));
          }
        },
        error: function(xhr, textStatus, errorThrown) {
          alert('error');
        }
      });

      $('#showContentMessageDialog').modal('hide');
    });
  }
});
