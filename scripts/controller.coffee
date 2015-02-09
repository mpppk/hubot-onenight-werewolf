# WOMember  = require('./womember').WOMember
MemberManager = require('./memberManager').MemberManager
RoleManager = require('./roleManager').RoleManager

# ---- WOを管理するクラス ----
class Controller
  constructor: () ->
    @memberManager = new MemberManager
    @isOngoing = false
    @isWaitingParticipants = false

  # WOを開始する.開始に成功すればtrueを返す
  start: (sec) =>
    @memberManager = new MemberManager
    @roleManager = new RoleManager
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

exports.Controller = Controller

