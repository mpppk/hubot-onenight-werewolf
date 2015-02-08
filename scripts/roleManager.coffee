Roles          = {}
Roles.Werewolf = require('./werewolf').Werewolf
Roles.Seer     = require('./seer'    ).Seer
Roles.Villager = require('./villager').Villager
Roles.Robber   = require('./robber'  ).Robber

# ---- 役職を管理するクラス ----
class RoleManager
	constructor: () ->
		@roles = []
		for cn, c of Roles
			for i in [0...c.num]
				@roles.push(new c)

	# ランダムに役職のインスタンスを返す。取り出した役職は@rolesから削除される。
	popRole: () =>
		index = Math.floor( Math.random() * @roles.length )
		this.popRoleByIndex(index)

	# indexで指定した場所の役職のインスタンスを返す.取り出した役職は@rolesから削除される
	popRoleByIndex: (index) ->
		ret = @roles[index]
		@roles.splice(index, 1)
		ret

exports.Roles       = Roles
exports.RoleManager = RoleManager
