Member    = require('./womember').WOMember
RoleManager = require('./worole').RoleManager

# ---- ゲームの参加者を管理するクラス ----
class WOMembers
	constructor: () ->
		@members = []
		@roleManager = new RoleManager

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
		member = new Member(memberName)
		member.setRole( @roleManager.popRole() )
		@members.push( member )

	# メンバーの人数を返す
	getLength: () ->
		@members.length

exports.WOMembers = WOMembers
