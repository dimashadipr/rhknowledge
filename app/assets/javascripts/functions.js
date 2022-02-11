$(function () {
  $('[data-toggle="tooltip"]').tooltip();
  // $('.select2').select2();
});

function jsAlert(flash){
  $.each(flash, function(idx, values) {
    type    = values[0];
    message = values[1];
    title   = type.toLowerCase().replace(/\b[a-z]/g, function(letter) {
      return letter.toUpperCase();
    });


    if (type == 'error') type = 'danger';
    if (type == 'notice') type = 'info';

    var bg = 'bg-'+type;

    $(document).Toasts('create', {
      icon: 'fas fa-envelope fa-lg',
      class: bg,
      position: 'topRight',
      title: title,
      body: message,
      autohide: true,
      delay: 2000,
    });
  });
}


