class Werewolf
  @num:  2
  constructor: () ->
    @name = "Werewolf"
    @messageAtNight = "nothing."

  # 夜の間に行う行動
  workAtNight: () ->

  # 夜に表示するメッセージ
  getMessageAtNight: () ->
    @messageAtNight

  makeMessageAtNight: (@assignedMemberName, memberManager, messageManager) ->
    msg = messageManger.youAre(messageManager.werewolfName)
    werewolfMembers = memberManager.getMembersByRoleName(@name)

    if werewolfMembers.length <= 1
      @messageAtNight = msg + "\n" + messageManager.otherWerewolfDoesNotExist
      return
    
    for werewolfMember in werewolfMembers
      if werewolfMember.name != @assignedMemberName
        messageManager.roleAndName( @assignedMemberName,
        messageManager.werewolfName )

    # msg = "あなたは#{@name}です。"
    # werewolfMembers = @memberManager.getMembersByRoleName(@name)
    # # messageManager.werewolfMessageAtNight(werewolfMembers)

    # if werewolfMembers.length <= 1
    #   return msg + "\n他の#{@name}はいません。"
    
    # msg += "\n他の#{@name}は"
    # for werewolfMember in werewolfMembers
    #   if werewolfMember.name != @assignedMemberName
    #     msg += werewolfMember.name

    # return msg + "です。"

exports.Werewolf = Werewolf
