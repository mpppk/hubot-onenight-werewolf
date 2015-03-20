class Robber
  @num:  1

  constructor: () ->
    @name = "Robber"

  # setAssignedMemberName: (@assignedMemberName) ->
  # setMemberManager: (@memberManager) ->

  # 夜に表示するメッセージ
  getMessageAtNight: () ->
    @messageAtNight

  # 夜に行う行動
  workAtNight: () ->
    assignedMember = @memberManager.getMemberByName(@assignedMemberName)
    stolenMember   =
    @memberManager.getMemberByRandomWithout(@assignedMemberName)
    
    unless stolenMember?
      assignedMember.role.getMessageAfterNight = () ->
        "申し訳ありません。エラーが発生しました。ゲームをやり直してください。" +
        "(Robber couldn't find other player)"
      return
    
    # 盗まれる前の役職を覚えておく
    stolenMember.role.beforeRole = assignedMember.role

    # 対象のメンバーと役職を入れ替える.
    tempRole            = assignedMember.role
    assignedMember.role = stolenMember.role
    stolenMember.role   = tempRole

    # assignedMember.role.setAssignedMemberName( @assignedMemberName )
    # assignedMember.stolenMember = stolenMember
    # assignedMember.role.getMessageAfterNight = () ->
    #   roleName = assignedMember.role.name
    #   "#{stolenMember.name}の「#{roleName}」とあなたの「怪盗」を交換しました。"

    # stolenMember.role = new Robber
    # stolenMember.role.setAssignedMemberName( stolenMember.name )
    # stolenMember.role.setMemberManager( @memberManager )


  makeMessageAtNight: (@assignedMemberName, memberManager, messageManager) ->
    @messageAtNight = messageManager.youAre(messageManager.robberName)

exports.Robber = Robber
