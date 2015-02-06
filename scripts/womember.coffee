	# ---- 参加者を表すクラス ----
class WOMember
	constructor: (name) ->
		@name = name

	setRole: (roleName) ->
		@roleName = roleName

	getRole: () ->
		@roleName

exports.WOMember = WOMember
