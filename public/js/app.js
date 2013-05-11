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
  /*
  $('form[method="put"]').on('submit', function(e, f){
	var $btn = $(this).find('.btn.btn-primary');
        console.log(e, f, this);
	e.preventDefault();
        $.ajax({
            type: 'put',
            url: $(this).attr('action'), // <- replace this with your url here
            beforeSend: function() {
              $btn.button('loading');
            },
            success: function(response) {
              $btn.button('complete');
              setTimeout(function(){ $btn.button('reset'); }, 2000);
              flash(response);
            }
        });
	return false;
  });
  $('[data-method]').click(function(){
        var parent = $(this).closest('tr');
        $.ajax({
            type: $(this).data('method'),
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
  */
});
