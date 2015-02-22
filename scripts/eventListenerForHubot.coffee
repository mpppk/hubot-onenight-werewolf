class EventListenerForHubot
  constructor: (@robot) ->
    @roomName = "random"

  send: (message) ->
    @robot.send {room: @roomName}, message

  # 指定したユーザーにDMを送る
  sendDM: (slackUserName , message) ->
    userId = @robot.adapter.client?.getUserByName(slackUserName)?.id
    unless userId?
      console.log "fail to send DM\n" +
      "destUser: #{slackUserName}\nmessage: #{message}"
      return

    if @robot.adapter.client.getDMByID(userId)?
      @robot.send {room: slackUserName}, message
    else
      @robot.adapter.client.openDM userId
      # openをハンドルする手段がなさそうなので、仕方なくsetTimeout
      setTimeout ->
        @robot.send {room: slackUserName}, message
        console.log "#{slackUserName}に次の内容でDMを送りました。\n" + message
      , 5000

  sendAll: (public_messages, private_messages) =>
    if public_messages?
      this.send message for message in public_messages

    if private_messages?
      this.sendDM( name, message ) for name, message of private_messages

  onStartAccepting: (messages) =>
    this.sendAll(messages)

  onFinishAccepting: (public_messages, private_messages) =>
    this.sendAll(public_messages, private_messages)
    
  onFinishVoting: (messages) ->
    this.sendAll(messages)
    # this.send message for message in messages

  onFinishDiscussion: (messages) ->
    this.sendAll(messages)

  onVote: (messages) ->
    this.sendAll(messages)

exports.EventListenerForHubot = EventListenerForHubot
