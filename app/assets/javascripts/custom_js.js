document.addEventListener('turbolinks:load', function(event) {

  $(window).scroll(function() {
    if ($(document).scrollTop()) {
      $('div.header-line, div.ins-logo').hide();
      $('header').addClass('scroll-header');
    } else {
      $("div.header-line, div.ins-logo").css('display', 'inline-block')
      $('header').removeClass('scroll-header');
    }
  });

  $('img.close-btn').on('click', function(e) {
    e.preventDefault();
    $('#search-results').hide();
  });

  $('.post-photo').on('load', function() {
    $('.micropost-content-container').css('height', $('.post-photo').height() - $('.micropost-user-title').height() - $('.micropost-bottom').height() - 3);
  });

  $('.owl-demo').owlCarousel({
    navigation : true, // Show next and prev buttons
    slideSpeed : 300,
    paginationSpeed : 400,
    items : 1,
    itemsDesktop : false,
    itemsDesktopSmall : false,
    itemsTablet: false,
    itemsMobile : false
  });

  $('#micropost_menu').hide();

  $('.overlay-btn').on('click', function(e) {
    // e.preventDefault();
    $('#micropost_menu').show();
  });

  $('.close-overlay').on('click', function(e) {
    e.preventDefault();
    $('#micropost_menu').hide();
  });

  $('#edit-left-menu .edit-tab a').on('click', function(e) {
    e.preventDefault();
    $('.edit-form').hide();
    $('#edit-left-menu .edit-tab').removeClass('active');
    $(this).parent().addClass('active');
    $('.' + $(this).data('edit')).show();
  });
});
