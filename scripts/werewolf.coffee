class Werewolf
	@num:  2

	constructor: () ->
		@name = "人狼"

	getName: () ->
		@name

	# 夜の間に行う行動
	workAtNight: () ->

	# 夜に表示するメッセージ
	getMessageAtNight: (controller) ->
		"あなたは#{@name}です。"

exports.Werewolf = Werewolf
