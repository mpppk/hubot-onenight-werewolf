class Villager
	@num:  4

	constructor: () ->
		@name = "村人"

	getName: () ->
		@name

	setAssignedMemberName: (@assignedMemberName) ->
	setMemberManager: (@memberManager) ->

	# 夜の間に行う行動
	workAtNight: () ->

	# 夜に表示するメッセージ
	getMessageAtNight: () ->
		msg = "あなたは#{@name}です。"
		return msg

exports.Villager = Villager
