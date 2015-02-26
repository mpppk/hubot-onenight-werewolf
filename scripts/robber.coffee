class Robber
  @num:  1

  constructor: () ->
    @name = "怪盗"

  getName: () ->
    @name

  setAssignedMemberName: (@assignedMemberName) ->
  setMemberManager: (@memberManager) ->

  # 夜に表示するメッセージ
  getMessageAtNight: (messageManager) ->
    msg = "あなたは#{@name}です。"
    return msg

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
    
    # 対象のメンバーと役職を入れ替える.
    assignedMember.role = stolenMember.role
    assignedMember.role.setAssignedMemberName( @assignedMemberName )
    assignedMember.stolenMember = stolenMember
    assignedMember.role.getMessageAfterNight = () ->
      roleName = assignedMember.role.name
      "#{stolenMember.name}の「#{roleName}」とあなたの「怪盗」を交換しました。"

    stolenMember.role = new Robber
    stolenMember.role.setAssignedMemberName( stolenMember.name )
    stolenMember.role.setMemberManager( @memberManager )

    # 盗まれる前の役職を覚えておく
    stolenMember.role.beforeRole = assignedMember.role

exports.Robber = Robber
