class CommentsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "comments_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
