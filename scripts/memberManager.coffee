Member    = require('./member').Member
RoleManager = require('./roleManager').RoleManager

# ---- ゲームの参加者を管理するクラス ----
class MemberManager
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
	addMember: (memberName) =>
		member = new Member(memberName, this)
		member.setRole( @roleManager.popRole() )
		@members.push( member )

	# メンバーの人数を返す
	getLength: () ->
		@members.length

	# 指定した役職を持つメンバーインスタンスの配列を返す
	getMembersByRoleName: (roleName) ->
		ret = []
		for member in @members
			console.log member.getRole().name
			if member.getRole().name == roleName
				ret.push( member )
		ret

	# ランダムにメンバーインスタンスを返す
	getMemberByRandom: () ->
		index = Math.floor( Math.random() * @members.length );
		@members[index]

exports.MemberManager = MemberManager
