# WOMember  = require('./womember').WOMember
MemberManager = require('./memberManager').MemberManager
RoleManager = require('./roleManager').RoleManager

# ---- WOを管理するクラス ----
class Controller
  constructor: () ->
    @memberManager         = new MemberManager
    @isOngoing             = false
    @isWaitingParticipants = false
    @discussionTime        = 1

    @VOTING_STATE = {
      waiting: "waiting" # 投票開始前
      accept:  "accept"  # 投票受付中
      finish:  "finish"  # 投票終了
    }

    # 投票受付状態を格納する.
    @votingState = @VOTING_STATE.waiting

  # WOを開始する.開始に成功すればtrueを返す
  start: (sec) =>
    @memberManager = new MemberManager
    @roleManager   = new RoleManager
    if @isOngoing
      return false
    @isOngoing = true
    this.waitParticipants(sec)
    true

  # 指定された時間だけ参加者を受け付ける
  waitParticipants: (sec) ->
    @isWaitingParticipants = true
    setTimeout () ->
      @isWaitingParticipants = false
    , sec * 1000

  # ゲーム開始前の状態にリセットする
  reset: () ->
    @isOngoing = false

  # 投票が終了したかどうかを確認し、現在の状態を返す.
  checkVoting: () =>
    if @memberManager.members.length <= @memberManager.getVotesCast()
      @votingState = @VOTING_STATE.finish
      clearInterval(@timerID)
    @votingState

  # 投票を受け付ける. 投票が終了したらcallbackを呼び出す
  acceptVoting: (callback) ->
    self = this
    @votingState = @VOTING_STATE.accept
    @timerID = setInterval( () ->
      if self.checkVoting() == self.VOTING_STATE.finish
        callback()
    , 3000 )

  # nameがtargetNameに投票を行う
  vote: (name, targetName) ->
    switch @votingState
      when @VOTING_STATE.waiting then return "まだ投票は受け付けていません。"
      when @VOTING_STATE.finish  then return "投票は既に終了しています。"

    member       = @memberManager.getMemberByName(name)
    targetMember = @memberManager.getMemberByName(targetName)

    if member.isVoted
      return "既に投票済みです。"

    unless targetMember?
      return "指定した名前のプレイヤーは存在しません。"

    targetMember.votesCast++
    member.isVoted = true
    return targetName + "に投票しました。"

exports.Controller = Controller

