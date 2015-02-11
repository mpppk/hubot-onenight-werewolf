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

  workAtNight: () ->
    if @role.workAtNight?
      @role.workAtNight(@name, @manager)

  getMessageAfterNight: () ->
    if @role.getMessageAfterNight?
      return @role.getMessageAfterNight(@name, @manager)
    else
      return null

exports.Member = Member
