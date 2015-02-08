# ワンナイト人狼(Onenight Werewolf: WO)をslack上でプレイするためのスクリプト

WO = require('./wo').WO

module.exports = (robot) ->
	# 指定したユーザーにDMを送る
	sendDM = (slackUserName , message) ->
		userId = robot.adapter.client.getUserByName(slackUserName)?.id
		return unless userId?

		if robot.adapter.client.getDMByID(userId)?
			robot.send {room: slackUserName}, message
		else
			robot.adapter.client.openDM userId
			# openをハンドルする手段がなさそうなので、仕方なくsetTimeout
			setTimeout =>
				robot.send {room: slackUserName}, message
			, 1000

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
		controller.memberManager.addMember( name )

		msg.send "受付開始(残り" + sec + "秒)"
		setTimeout () ->
			if controller.isOngoing
				msg.send "受付終了"
				for member in controller.memberManager.getMembers()
					sendDM( member.name, member.getMessageAtNight() )
					console.log member.name + "に次のメッセージを送りました.\n" + member.getMessageAtNight(controller.memberManager)
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
		membersName = controller.memberManager.getMembersName()

		if membersName.indexOf(name) >= 0
			msg.send "既に参加中です。"
			return

		controller.memberManager.addMember( name )
		msg.send name + "が参加します!"

	# WOの参加者一覧を確認する
	robot.hear /[werewolf|w] members/i, (msg) ->
		unless controller.isOngoing
			msg.send "ゲームが開始されていません。\n先に_werewolf start_でゲームを開始してください。"
			return

		msg.send controller.memberManager.getMembersList()
