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

  werewolfMessageAtNight: (werewolfMembers) ->
    msg = "あなたは人狼です。"
    if werewolfMembers.length <= 1
      return msg + "\n他の人狼はいません。"
    
    msg += "\n他の人狼は"
    for werewolfMember in werewolfMembers
      if werewolfMember.name != @assignedMemberName
        msg += werewolfMember.name

    return msg + "です。"

  startDiscussion: () ->
    return "議論を開始してください。"

  startAccepting: (sec) ->
    return "受付開始(残り#{sec}秒)"

  targetPlayerDoNotExist: (name) ->
    name ?= ""
    return "指定した名前(#{name})のプレイヤーは存在しません。"

  terminateGame: () ->
    return "ゲームを中止しました。"

  vote: (name) ->
    return "#{name}に投票しました。"

  voteIsAlreadyFinished: () ->
    return "投票は既に終了しています。"

  voteIsNotYetAccepted: () ->
    return "まだ投票は受け付けていません。"

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

exports.JapaneseMessageManager = JapaneseMessageManager

