class JapaneseMessageManager
  constructor: () ->

  acceptingIsAlreadyFinished: () ->
    return "参加者受付は終了しています。次のゲームをお待ちください。"

  alreadyGameStarted: () ->
    return "ゲームは既に開始しています。"

  alreadyJoined: () ->
    return "既に参加中です。"

  alreadyVoted: () ->
    return "既に投票済みです。"

  errorOccurred: () ->
    return "エラーが発生しました。ゲームをやり直してください。"

  finishAccepting: () ->
    return "受付が終了しました。"

  finishDisucussion: () ->
    return "議論時間が終了しました。投票を行ってください。"

  finishVoting: () ->
    return "投票が終了しました。"

  gameDoesNotStart: () ->
    return "ゲームが開始されていません。\n先にゲームを開始してください。"

  memberJoined: (name) ->
    return "#{name}が参加します！"

  startDiscussion: () ->
    return "議論を開始してください。"

  startAccepting: (sec) ->
    return "受付開始(残り#{sec}秒)"

  targetPlayerDoNotExist: () ->
    return "指定した名前のプレイヤーは存在しません。"

  terminateGame: () ->
    return "ゲームを中止しました。"

  vote: (name) ->
    return "#{name}に投票しました。"

  voteIsAlreadyFinished: () ->
    return "投票は既に終了しています。"

  voteIsNotYetAccepted: () ->
    return "まだ投票は受け付けていません。"

exports.JapaneseMessageManager = JapaneseMessageManager

