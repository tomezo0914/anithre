$(function() {
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
      $.ajax({
        type: 'POST',
        url: '/message/create',
        data: { content_id: content_id, body: message },
        success: function(data, dataType) {
          if (typeof data != 'undefined' && data != null) {
            var data = {
              id: data.id,
              message: data.body,
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
