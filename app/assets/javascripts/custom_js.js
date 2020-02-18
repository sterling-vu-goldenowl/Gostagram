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

  $('.post-photo').on('load', function() {
    $('.micropost-content-container').css('height', $('.owl-item .active').height() - $('.micropost-user-title').height() - $('.micropost-bottom').height() - 3 );
  });

  $('.owl-demo').owlCarousel({
    items : 1,
    itemsDesktop : false,
    itemsDesktopSmall : false,
    itemsTablet: false,
    itemsMobile : false,
    autoPlay : 3000,
    stopOnHover : true,
    navigation : true,
    paginationSpeed : 1000,
    goToFirstSpeed : 2000,
    autoHeight : true,
    transitionStyle : "fade"
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

  $('.menu-overlay').hide();

  $('.delete-cmt-btn').on('click', function(e) {
    var comment_id = $(this).data('id');
    $('#comment-menu-'+ comment_id).show();
  });

  $('.close-comment').on('click', function(e) {
    e.preventDefault();
    var comment_id = $(this).data('id');
    $('.menu-overlay').hide();
  });

  $('#edit-left-menu .edit-tab a').on('click', function(e) {
    e.preventDefault();
    $('.edit-form').hide();
    $('#edit-left-menu .edit-tab').removeClass('active');
    $(this).parent().addClass('active');
    $('.' + $(this).data('edit')).show();
  });
});
