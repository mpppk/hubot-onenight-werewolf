# ワンナイト人狼(Onenight Werewolf: WO)をslack上でプレイするためのスクリプト

WO     = require('./wo').WO
Errors = require('./error').Errors

module.exports = (robot) ->
  controller = new WO.Controller( new WO.EventListenerForHubot( robot ) )

  tryMethod = (method, msg) ->
    try
      method()
    catch e
      showErrorMessage msg, e

  showErrorMessage = (msg, error) ->
    unless error instanceof Errors.WOError
      throw error

    msg.send error.message
    console.log error
    console.log error.message

  # WOを開始する
  robot.hear /[werewolf|w] start ?([0-9]*)/i, (msg) ->
    defaultSec = 5
    sec = Number(msg.match[1] or defaultSec)
    method = controller.startAcceptingMember.
    bind(null, msg.message.user.name, sec)
    tryMethod( method, msg )

  # WOを中止する
  robot.hear /[werewolf|w] terminate/i, (msg) ->
    tryMethod( controller.reset, msg )

  # WOに参加する
  robot.hear /[werewolf|w] join/i, (msg) ->
    method = controller.join.bind( null, msg.message.user.name )
    tryMethod( method, msg )

  # WOの参加者一覧を確認する
  robot.hear /[werewolf|w] members/i, (msg) ->
    tryMethod( controller.getMembersList, msg )

  robot.hear /[werewolf|w] vote (\w+)/i, (msg) ->
    method = controller.vote.bind( null, msg.message.user.name, msg.match[1] )
    tryMethod( method, msg )

