class JapaneseMessageManager
  constructor: () ->

  acceptingIsAlreadyFinished: () ->
    "参加者受付は終了しています。次のゲームをお待ちください。"

  alreadyGameStarted: () ->
    "ゲームは既に開始しています。"

  alreadyJoined: () ->
    "既に参加中です。"

  alreadyVoted: () ->
    "既に投票済みです。"

  errorOccurred: () ->
    "エラーが発生しました。ゲームをやり直してください。"

  finishAccepting: () ->
    "受付が終了しました。"

  finishDisucussion: () ->
    "議論時間が終了しました。投票を行ってください。"

  finishVoting: () ->
    "投票が終了しました。"

  gameDoesNotStart: () ->
    "ゲームが開始されていません。\n先にゲームを開始してください。"

  memberJoined: (name) ->
    "#{name}が参加します！"

  robberName: ->
    "怪盗"

  roleAndName: (name, roleName) ->
    "#{name}は#{roleName}です。"

  seerName: ->
    "占い師"

  startDiscussion: () ->
    "議論を開始してください。"

  startAccepting: (sec) ->
    "受付開始(残り#{sec}秒)"

  targetPlayerDoNotExist: (name) ->
    name ?= ""
    "指定した名前(#{name})のプレイヤーは存在しません。"

  terminateGame: () ->
    "ゲームを中止しました。"

  villagerName: ->
    "村人"

  vote: (name) ->
    "#{name}に投票しました。"

  voteIsAlreadyFinished: () ->
    "投票は既に終了しています。"

  voteIsNotYetAccepted: () ->
    "まだ投票は受け付けていません。"

  votingResult: (targetName, votedMembersName) ->
    methodName = "JapaneseMessageManager.votingResult()"
    unless targetName?
      throw TypeError("targetName is not exist. (in #{methodName})")

    unless votedMembersName?
      throw TypeError("votedMembersName is not exist. (in #{methodName})")

    votesCast = votedMembersName.length
    message = "#{targetName}の得票数 => #{votesCast}\n投票した人("
    for name in votedMembersName
      message += name + ", "
    message.slice(0, -2) + ")"

  hang: (members) ->
    message = ""
    for member in members
      message += member.name + "と"
    message.slice(0, -1) + "を処刑しました。"

  winningTeamIs: (teamName) ->
    switch teamName
      when "peace"     then return "この村に人狼は居ませんでした！"
      when "lostPeace" then return "この村に人狼は居ませんでしたが、
      不必要な犠牲者を生んでしまいました。"
      when "human"     then return "人間チームが勝利しました！"
      when "werewolf"  then return "人狼チームが勝利しました！"
    "大変申し訳ないのですが、私にも誰が勝ったのか分かりません。
    この村に一体何が起きてしまったのでしょう？"

  werewolfName: ->
    "人狼"

  youAre: (name) ->
    "あなたは#{name}です。"

exports.JapaneseMessageManager = JapaneseMessageManager

