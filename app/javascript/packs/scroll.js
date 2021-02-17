import $ from 'jquery'
  
$(document).ready(function() {
  if ($('.pagination').length) {
    $(window).scroll(function() {
      var url = $('.pagination .next_page').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        $('.pagination').html('<img class="mx-auto d-block mb-5" width="64" height="64" src="/loader.gif" alt="Loading..." title="Loading..." />');
        return $.getScript(url);
      }
    });
    return $(window).scroll();
  }
});