  # ---- 参加者を表すクラス ----
class Member
  constructor: (@name, @manager) ->

  setRole: (@role) ->
    @role.setAssignedMemberName(@name)
    @role.setMemberManager(@manager)

  getRole: () ->
    @role

  getMessageAtNight: () ->
    @role.getMessageAtNight(@name, @manager)

exports.Member = Member
