# ワンナイト人狼(Onenight Werewolf: WO)をslack上でプレイするためのスクリプト

WO = require('./wo').WO

module.exports = (robot) ->
	controller = new WO.Controller

	# WOを開始する
	robot.hear /[werewolf|w] start ?([0-9]*)/i, (msg) ->
		defaultSec = 5
		sec = Number(msg.match[1] or defaultSec)
		
		unless controller.start(sec)
			msg.send "ゲームは既に開始しています。"
			return

		# ゲームを開始したプレイヤーをメンバーに加える
		name = msg.message.user.name
		controller.members.addMember( new WO.Member(name) )

		msg.send "受付開始(残り" + sec + "秒)"
		setTimeout () ->
			if controller.isOngoing
				msg.send "受付終了"
		, sec * 1000

	# WOを中止する
	robot.hear /[werewolf|w] terminate/i, (msg) ->
		controller.reset()
		msg.send "ゲームを中止しました"

	# WOに参加する
	robot.hear /[werewolf|w] join/i, (msg) ->
		unless controller.isOngoing
			msg.send "ゲームが開始されていません。\n先に_werewolf start_でゲームを開始してください。"
			return

		unless controller.isWaitingParticipants
			msg.send "参加者受付は終了しています。次のゲームをお待ち下さい。"
			return

		name = msg.message.user.name
		membersName = controller.members.getMembersName()

		if membersName.indexOf(name) >= 0
			msg.send "既に参加中です。"
			return

		controller.members.addMember( new WO.Member(name) )
		msg.send name + "が参加します!"

	# WOの参加者一覧を確認する
	robot.hear /[werewolf|w] members/i, (msg) ->
		unless controller.isOngoing
			msg.send "ゲームが開始されていません。\n先に_werewolf start_でゲームを開始してください。"
			return

		msg.send controller.members.getMembersList()
