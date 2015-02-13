# ワンナイト人狼(Onenight Werewolf: WO)をslack上でプレイするためのスクリプト

WO = require('./wo').WO

module.exports = (robot) ->
  controller = new WO.Controller

  # 指定したユーザーにDMを送る
  sendDM = (slackUserName , message) ->
    userId = robot.adapter.client?.getUserByName(slackUserName)?.id
    unless userId?
      console.log "fail to send DM\n" +
      "destUser: #{slackUserName}\nmessage: #{message}"
      return

    if robot.adapter.client.getDMByID(userId)?
      robot.send {room: slackUserName}, message
    else
      robot.adapter.client.openDM userId
      # openをハンドルする手段がなさそうなので、仕方なくsetTimeout
      setTimeout ->
        robot.send {room: slackUserName}, message
        console.log "#{slackUserName}に次の内容でDMを送りました。\n" + message
      , 5000

  # 議論の終了
  finishVoting = (msg) ->
    msg.send "投票が終了しました。"

  # 議論の開始
  startDiscuss = (msg) ->
    msg.send "議論を開始してください"
    setTimeout () ->
      msg.send "議論時間が終了しました。投票を行ってください。"
      controller.acceptVoting(finishVoting.bind(null, msg))
    , controller.discussionTime * 1000

  # 受付終了時の処理
  finishAcceptance = (msg) ->
    if controller.isOngoing
      msg.send "受付終了"
      for member in controller.memberManager.getMembers()
        messageAtNight = member.getMessageAtNight()
        sendDM( member.name, messageAtNight )
        
      for member in controller.memberManager.getMembers()
        member.workAtNight()
        
      for member in controller.memberManager.getMembers()
        messageAfterNight = member.getMessageAfterNight() | ""
        sendDM( member.name, messageAfterNight )
      
      startDiscuss(msg)

  # WOを開始する
  robot.hear /[werewolf|w] start ?([0-9]*)/i, (msg) ->
    defaultSec = 5
    sec = Number(msg.match[1] or defaultSec)
    
    unless controller.start(sec)
      msg.send "ゲームは既に開始しています。"
      return

    # ゲームを開始したプレイヤーをメンバーに加える
    name = msg.message.user.name
    controller.memberManager.addMember( name )

    msg.send "受付開始(残り" + sec + "秒)"
    setTimeout () ->
      finishAcceptance(msg)
    , sec * 1000

  # WOを中止する
  robot.hear /[werewolf|w] terminate/i, (msg) ->
    controller.reset()
    msg.send "ゲームを中止しました"

  # WOに参加する
  robot.hear /[werewolf|w] join/i, (msg) ->
    unless controller.isOngoing
      msg.send "ゲームが開始されていません。\n先に_werewolf start_でゲームを開始してください。"
      return

    unless controller.isWaitingParticipants
      msg.send "参加者受付は終了しています。次のゲームをお待ち下さい。"
      return

    name = msg.message.user.name
    membersName = controller.memberManager.getMembersName()

    if membersName.indexOf(name) >= 0
      msg.send "既に参加中です。"
      return

    controller.memberManager.addMember( name )
    msg.send name + "が参加します!"

  # WOの参加者一覧を確認する
  robot.hear /[werewolf|w] members/i, (msg) ->
    unless controller.isOngoing
      msg.send "ゲームが開始されていません。\n先に_werewolf start_でゲームを開始してください。"
      return

    msg.send controller.memberManager.getMembersList()

  robot.hear /[werewolf|w] vote (\w+)/i, (msg) ->
    unless controller.isOngoing
      msg.send "ゲームが開始されていません。\n先に_werewolf start_でゲームを開始してください。"
      return
    
    msg.send controller.vote( msg.message.user.name, msg.match[1] )
