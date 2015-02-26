  # ---- 参加者を表すクラス ----

Errors = require('./error').Errors

class Member
  constructor: (@name, @manager) ->
    unless @name?
      throw TypeError("argument \"name\" don't exist in Member.constructor")
    unless @manager?
      throw TypeError("argument \"manager\" don't
       exist in Member.constructor")

    @votesCast = 0     # このメンバーの得票数
    @isVoted   = false # このメンバーが投票を行ったかどうか
    @votedMembersName = []

  setRole: (@role) ->
    unless @role?
      throw TypeError("argument \"role\" don't exist in Member.setRole()")

    @role.setAssignedMemberName(@name)
    @role.setMemberManager(@manager)

  getMessageAtNight: (messageManager) ->
    @role.getMessageAtNight(messageManager)
    # @role.getMessageAtNight(@name, @manager)

  workAtNight: () ->
    @role.workAtNight?(@name, @manager)

  getMessageAfterNight: () ->
    @role.getMessageAfterNight?(@name, @manager)

  # 指定した名前のメンバーに投票する
  voteTo: (memberName) ->
    if @isVoted
      throw new Errors.VoteError( "#{@name} is already voted." +
      "( in Member.voteTo() )" )

    @isVoted = true

  # 指定した名前のメンバーから投票される
  votedFrom: (memberName) ->
    # 既に投票済みのメンバーから再度投票された場合は例外を吐く
    if @votedMembersName.indexOf(memberName) != -1
      throw new Errors.VoteError( "#{@name} is already voted
      from #{memberName}." + "( in Member.votedFrom() )" )

    @votesCast++
    @votedMembersName.push memberName

exports.Member = Member
