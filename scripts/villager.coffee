class Villager
  @num:  4

  constructor: () ->
    @name = "Villager"

  # setAssignedMemberName: (@assignedMemberName) ->
  # setMemberManager: (@memberManager) ->
  # setMessageManager: (@messageManager) ->

  # 夜の間に行う行動
  workAtNight: () ->

  # 夜に表示するメッセージ
  getMessageAtNight: () ->
    @messageAtNight

  makeMessageAtNight: (@assignedMemberName, memberManager, messageManager) ->
    unless @messageManager?
      eInfo = "messageManager doesn't exist in Villager.getMessageAtNight()"
      throw TypeError( eInfo )

    return @messageManager.youAre(messageManager.villagerName)

exports.Villager = Villager
