document.addEventListener('turbolinks:load', function(event) {
  $(window).scroll(function() {
    if ($(document).scrollTop() > 20) {
      $('div.header-line, div.ins-logo').hide();
      $('header').addClass('scroll-header');
    } else {
      $("div.header-line, div.ins-logo").css('display', 'inline-block')
      $('header').removeClass('scroll-header');
    }
  });

  $('#edit-left-menu .edit-tab a').on('click', function(e) {
    e.preventDefault();
    $('.edit-form').hide();
    $('#edit-left-menu .edit-tab').removeClass('active');
    $(this).parent().addClass('active');
    $('.' + $(this).data('edit')).show();
  });
});
