class Villager
	@num:  4

	constructor: () ->
		@name = "村人"

	getName: () ->
		@name

	# 夜の間に行う行動
	workAtNight: () ->

	# 夜に表示するメッセージ
	getMessageAtNight: (controller) ->
		"あなたは#{@name}です。"

exports.Villager = Villager
