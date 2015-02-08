	# ---- 参加者を表すクラス ----
class WOMember
	constructor: (@name, @manager) ->

	setRole: (@role) ->
		@role.setAssignedMemberName(@name)
		@role.setMemberManager(@manager)

	getRole: () ->
		@role

	getMessageAtNight: (memberManager) ->
		@role.getMessageAtNight(@name, memberManager)

exports.WOMember = WOMember
