	# ---- ゲームの参加者を管理するクラス ----
Member    = require('./womember').WOMember
class WOMembers
	constructor: () ->
		@members = []

	getMembers: () ->
		@members

	# 全てのメンバーの名前を格納した配列を返す
	getMembersName: () ->
		(member.name for member in @members)

	# 全てのメンバーの名前をリストにした文字列を返す
	getMembersList: () =>
		memberList = "```"
		membersName = this.getMembersName()
		for name in membersName
			memberList += name + "\n"
		memberList + "```"

	# メンバーを追加
	addMember: (memberName) ->
		@members.push( new Member(memberName) )

	# メンバーの人数を返す
	getLength: () ->
		@members.length

exports.WOMembers = WOMembers
