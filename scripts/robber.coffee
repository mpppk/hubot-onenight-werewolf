class Robber
	@num:  1

	constructor: () ->
		@name = "怪盗"

	getName: () ->
		@name

	# 夜の間に行う行動
	workAtNight: () ->

	# 夜に表示するメッセージ
	getMessageAtNight: (controller) ->
		"あなたは#{@name}です。"

exports.Robber = Robber
