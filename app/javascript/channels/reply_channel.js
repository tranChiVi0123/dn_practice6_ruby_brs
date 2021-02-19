import consumer from "./consumer"

consumer.subscriptions.create("ReplyChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
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
  }
});
