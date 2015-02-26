# WOMember  = require('./womember').WOMember
MemberManager   = require('./memberManager').MemberManager
Roles           = require('./roleManager').Roles
RoleManager     = require('./roleManager').RoleManager
MessageManager  = require('./messageManager').MessageManager.Japanese
Errors          = require('./error').Errors

# ---- WOを管理するクラス ----
class Controller
  constructor: (@eventListener) ->
    @memberManager           = new MemberManager
    @messageManager          = new MessageManager
    @isOngoing               = false
    @isWaitingParticipants   = false
    @discussionTime          = 1
    @votingCheckIntervalTime = 3

    @VOTING_STATE = {
      waiting: "waiting" # 投票開始前
      accept:  "accept"  # 投票受付中
      finish:  "finish"  # 投票終了
    }

    # 投票受付状態を格納する.
    @votingState = @VOTING_STATE.waiting

  checkGoing: () =>
    unless @isOngoing
      throw new Errors.
      GameError( @messageManager.gameDoesNotStart() )

  # 参加者の受付を開始する.
  startAcceptingMember: (name, sec) =>
    if @isOngoing
      throw new Errors.
      GameError( @messageManager.alreadyGameStarted() )

    @memberManager = new MemberManager
    @roleManager   = new RoleManager

    @isOngoing             = true
    @isWaitingParticipants = true

    @eventListener?.onStartAccepting( [@messageManager.startAccepting( sec )] )

    self = this
    setTimeout () ->
      self.isWaitingParticipants = false
      self.finishAcceptingMember()
    , sec * 1000

    # ゲームを開始したプレイヤーをメンバーに加える
    @memberManager.addMember( name )
    true

  # 参加者の受付終了時の処理を行う
  finishAcceptingMember: () =>
    private_messages = this.workAtNight()

    public_messages =
    [@messageManager.finishAccepting(), @messageManager.startDiscussion()]

    @eventListener?.onFinishAccepting( public_messages, private_messages )

    self = this
    setTimeout () ->
      self.acceptVoting()
    , @discussionTime * 1000

  # ゲーム開始前の状態にリセットする
  reset: () =>
    @isOngoing = false
    @messageManager.terminateGame()

  # 投票が終了したかどうかを確認し、現在の状態を返す.
  checkVoting: () =>
    if @memberManager.members.length <= @memberManager.getVotesCast()
      @votingState = @VOTING_STATE.finish
      clearInterval(@timerID)
    @votingState

  # 投票を受け付ける. 投票が終了したらcallbackを呼び出す
  acceptVoting: () =>
    messages = [@messageManager.finishDisucussion()]
    @eventListener?.onFinishDiscussion( messages )

    self = this
    @votingState = @VOTING_STATE.accept
    @timerID = setInterval( () ->
      if self.checkVoting() == self.VOTING_STATE.finish
        self.finishVoting()
    , @votingCheckIntervalTime * 1000 )

  finishVoting: () =>
    messages = [@messageManager.finishVoting()]
    mostVotedMembers = @memberManager.getMostVotedMembers()
    messages.push @messageManager.winningTeamIs( this.getWiningTeamName() )
    messages.push @messageManager.hang( mostVotedMembers )
    for name, votedMembersName of @memberManager.getVotingResult()
      messages.push @messageManager.votingResult( name, votedMembersName )

    # messages.push this.getVotingResultMessage(@messageManager.votingResult)
    @eventListener?.onFinishVoting(messages)

  # 参加中のメンバーの名前を返す.
  getMembersList: () =>
    this.checkGoing()
    return @memberManager.getMembersList()

  # メンバーを追加し、メッセージを返す
  join: (name) =>
    this.checkGoing()
    unless @isWaitingParticipants
      throw new Errors.
      JoinError( @messageManager.acceptingIsAlreadyFinished() )

    membersName = @memberManager.getMembersName()
    if membersName.indexOf(name) >= 0
      throw new Errors.
      JoinError( @messageManager.alreadyJoined() )

    @memberManager.addMember( name )
    return @messageManager.memberJoined( name )

  workAtNight: () =>
    this.checkGoing()
    @memberManager.workAtNight()

  # nameがtargetNameに投票を行う
  vote: (name, targetName) =>
    this.checkGoing()

    switch @votingState
      when @VOTING_STATE.waiting
        throw new Errors.
        VoteError( @messageManager.voteIsNotYetAccepted() )
      when @VOTING_STATE.finish
        throw new Errors.
        VoteError( @messageManager.voteIsAlreadyFinished() )

    member       = @memberManager.getMemberByName(name)
    targetMember = @memberManager.getMemberByName(targetName)

    unless member?
      throw new Errors.
      VoteError( @messageManager.targetPlayerDoNotExist(name) )

    unless targetMember?
      throw new Errors.
      VoteError( @messageManager.targetPlayerDoNotExist(targetName) )

    if member.isVoted
      throw new Errors.
      VoteError( @messageManager.alreadyVoted() )

    unless targetMember?
      throw new Errors.
      VoteError( @messageManager.targetPlayerDoNotExist() )

    member.voteTo targetMember.name
    targetMember.votedFrom member.name
    @eventListener?.onVote( [@messageManager.vote( targetName )] )

  getVotingResultMessage: () ->
    @memberManager.getVotingResultMessage(@messageManager.votingResult)

  getWiningTeamName: () ->
    this.checkGoing()
    @memberManager.getWiningTeamName()

exports.Controller = Controller

