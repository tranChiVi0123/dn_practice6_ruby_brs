import $ from 'jquery'

$(document).ready(function () {
  $("#btn-unfollow").click((e)=>{
    $.ajax({
      url: "/relationships/"+$("#followed_id").val(),
      method: "DELETE",
      data: {
        followed_id: $("#followed_id").val()
      },
      success: (res)=>{
        $("#btn-unfollow").hide(1);
        $("#btn-follow").show(1);
      }
    })
  });

  $("#btn-follow").click((e)=>{
    $.ajax({
      url: "/relationships",
      method: "POST",
      data: {
        followed_id: $("#followed_id").val()
      },
      success: (res)=>{
        $("#btn-unfollow").show(1);
        $("#btn-follow").hide(1);
      }
    })
  });
});
