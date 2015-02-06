	# ---- 参加者を表すクラス ----
class WOMember
	constructor: (name) ->
		@name = name

	setRole: (role) ->
		@role = role

	getRole: () ->
		@role

	getMessageAtNight: () ->
		@role.getMessageAtNight()


exports.WOMember = WOMember
