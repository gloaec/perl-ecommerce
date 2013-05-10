$(function(){
  var nowTemp = new Date();
  var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

  function flash(obj){
    $.each(obj, function(k, v){
      $('#main').prepend(
        $('<div>').addClass('alert alert-'+k)
        .append($('<a>').addClass('close').attr({'data-dismiss':'alert','href':'#'}).html('&times;'))
        .append(v)
      );
    });
  }

  $('input[type="date"]').datepicker();
  $('[data-method]').click(function(){
        var parent = $(this).closest('tr');
        $.ajax({
            type: 'delete',
            url: this.href, // <- replace this with your url here
            beforeSend: function() {
              parent.animate({'backgroundColor':'#fb6c6c'},300);
            },
            success: function(response) {
                parent.fadeOut(300,function() {
                    parent.remove();
                });
                flash(response);
            }
        });     
        return false;
  });
});
