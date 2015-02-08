class Robber
	@num:  1

	constructor: () ->
		@name = "怪盗"

	getName: () ->
		@name

	setAssignedMemberName: (@assignedMemberName) ->
	setMemberManager: (@memberManager) ->

	# 夜の間に行う行動
	workAtNight: () ->

	# 夜に表示するメッセージ
	getMessageAtNight: () ->
		msg = "あなたは#{@name}です。"
		# TODO 他のプレイヤーをランダムに選択し、役職を入れ替える	
		return msg

exports.Robber = Robber
