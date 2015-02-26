class Werewolf
  @num:  2
  constructor: () ->
    @name = "Werewolf"

  getName: () ->
    @name

  setAssignedMemberName: (@assignedMemberName) ->
  setMemberManager: (@memberManager) ->

  # 夜の間に行う行動
  workAtNight: () ->

  # 夜に表示するメッセージ
  getMessageAtNight: (messageManager) ->
    msg = "あなたは#{@name}です。"
    werewolfMembers = @memberManager.getMembersByRoleName(@name)
    # messageManager.werewolfMessageAtNight(werewolfMembers)

    if werewolfMembers.length <= 1
      return msg + "\n他の#{@name}はいません。"
    
    msg += "\n他の#{@name}は"
    for werewolfMember in werewolfMembers
      if werewolfMember.name != @assignedMemberName
        msg += werewolfMember.name

    return msg + "です。"

exports.Werewolf = Werewolf
