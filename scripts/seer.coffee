class Seer
  @num:  1

  constructor: () ->
    @name = "Seer"

  # setAssignedMemberName: (@assignedMemberName) ->
  # setMemberManager: (@memberManager) ->

  # 夜の間に行う行動
  workAtNight: () ->

  # 夜に表示するメッセージ
  getMessageAtNight: () ->
    @messageAtNight

  makeMessageAtNight: (@assignedMemberName, memberManager, messageManager) ->
    msg = messageManager.youAre(messageManager.seerName)
    maxIter = 1000 # 最大試行回数
    for i in [0..maxIter]
      otherMember = @memberManager.getMemberByRandom()
      if otherMember.name != @assignedMemberName
        roleName = otherMember.role.getName()
        @messageAtNight = msg + "\n" +
        messageManager.roleAndName( otherMember.name, roleName )
        return
    return "申し訳ありません。エラーが発生しました。ゲームをやり直してください。(Seer couldn't see other player)"

exports.Seer = Seer
