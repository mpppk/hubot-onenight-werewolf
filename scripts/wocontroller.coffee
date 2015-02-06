WOMember  = require('./womember').WOMember
WOMembers = require('./womembers').WOMembers

# ---- WOを管理するクラス ----
class WOController
	constructor: () ->
		@memberManager = new WOMembers
		@isOngoing = false
		@isWaitingParticipants = false

	# WOを開始する.開始に成功すればtrueを返す
	start: (sec) =>
		@memberManager = new WOMembers
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
		@members = new WOMembers
		@isOngoing = false

	# 全ての役職を配列で受け取る.順番はランダム.
	getRoles: () ->
		length = @members.getLength()


	# 各メンバーに役職を割り振る
	assignRoleToMembers: () ->

exports.WOController = WOController

