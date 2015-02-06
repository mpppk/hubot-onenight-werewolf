class Seer
	@num:  1

	constructor: () ->
		@name = "占い師"

	getName: () ->
		@name

	# 夜の間に行う行動
	workAtNight: () ->

	# 夜に表示するメッセージ
	getMessageAtNight: (controller) ->
		"あなたは#{@name}です。"

exports.Seer = Seer
