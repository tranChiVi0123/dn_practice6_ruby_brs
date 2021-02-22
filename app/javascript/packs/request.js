import $ from 'jquery'

$(document).ready(function () {
  $(".btn-accept-req").click((e) => {
    $.ajax({
      url: "/admin/responses/accept",
      method: "POST",
      data:{
        id: e.target.id
      },
      success: (res)=>{
        location.reload();
      },
      error: (err)=>{
        console.log(err);
      }
    })
  });

  $(".btn-noti").click((e)=>{
    $.ajax({
      url: "/requests/seen",
      method: "POST",
      data:{
        id: e.target.id
      }
    });
  });
});