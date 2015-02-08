class Seer
	@num:  1

	constructor: () ->
		@name = "占い師"

	getName: () ->
		@name

	setAssignedMemberName: (@assignedMemberName) ->
	setMemberManager: (@memberManager) ->

	# 夜の間に行う行動
	workAtNight: () ->

	# 夜に表示するメッセージ
	getMessageAtNight: () ->
		msg = "あなたは#{@name}です。"
		maxIter = 1000 # 最大試行回数
		for i in [0..maxIter]
			otherMember = @memberManager.getMemberByRandom()
			if otherMember.name != @assignedMemberName
				return msg + "\n#{otherMember.name}の役職を占い、#{otherMember.getRole().getName()}だと分かりました。"
		return "申し訳ありません。エラーが発生しました。ゲームをやり直してください。(Seer couldn't see other player)"
exports.Seer = Seer
