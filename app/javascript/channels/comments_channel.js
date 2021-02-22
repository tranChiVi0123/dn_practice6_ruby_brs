import consumer from "./consumer"

consumer.subscriptions.create("CommentsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    if (data.type == "comment") {
      $("#txt_comment_content").val("")
      if ($("#reviewId").val() == data.review_id) {
        $("#comments-box").prepend(
          `
        <div class="media mb-4">
            <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">
            <div class="media-body">
              <div class="row">
                <div class="col-8 d-flex">
                  <h5 class="mt-0"><a href="#">${data.user_name}</a></h5>
                </div>
                <div class="col-4">
                  <a class="text-primary btn-reply" style="cursor:pointer;" id="${data.comment_id}" name="btn-reply-${data.comment_id}">
                    <i class="fas fa-reply"></i>
                    Reply
                  </a>
                </div>
              </div>
              <p>${data.content}</p>
            </div>
          </div>
        `
        );
      }
    } else if (data.type == "reply") {
      $(`#reply-list-${data.comment_id}`).append(
        `
        <div class="media mt-4">
          <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">
          <div class="media-body">
            <h5 class="mt-0"><a href="#">${data.user_name}</a></h5>
            <p>${data.content}</p>
          </div>
        </div>
        `
      )
      $(`div[name="reply-box-${data.comment_id}"]`).hide(200);
      $(`a[name="btn-reply-${data.comment_id}"]`).show(200);
      $(`textarea[name="txt-reply-content-${data.comment_id}`).val("");
    } else if (data.type == "notification") {
      if ($("#user_id_header").val()== data.user_id) {
        $("#bell").hide(100);
        $("#bell-red").show(100);
        $("#notification-box").prepend(
          `
          <li class="dropdown-item bg-secondary btn-noti" id="${data.noti_id}"  name="btn-noti-${data.noti_id}">${data.content}</li>
          `
        )
      }

    }
  }
});
