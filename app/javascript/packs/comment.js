import $ from 'jquery'

$(document).ready(function () {
  $("#btn_submit_cmt").click((e) => {
    $.ajax({
      url: "/comment",
      method: "POST",
      data: {
        content: $("#txt_comment_content").val(),
        review_id: $("#reviewId").val()
      }
    })
  })

  $(".btn-reply").click((e) => {
    $(`div[name="reply-box-${e.target.id}"]`).show(200);
    $(`a[name="btn-reply-${e.target.id}"]`).hide(200);
  })

  $(".btn-cancel-reply").click((e) => {
    $(`div[name="reply-box-${e.target.id}"]`).hide(200);
    $(`a[name="btn-reply-${e.target.id}"]`).show(200);
  })

  $(".btn-submit-reply").click((e) => {
    $.ajax({
      url: "/reply",
      method: "POST",
      data: {
        content_reply: $(`textarea[name="txt-reply-content-${e.target.id}"`).val(),
        comment_id: e.target.id
      }
    })
  })
});

