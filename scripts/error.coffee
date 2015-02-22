# メンバーを参加させる際のエラー

class WOError extends Error
 
class JoinError extends WOError
  constructor: (@message='') ->
    @name = 'JoinError'

# ゲーム開始時のエラー
class GameError extends WOError
  constructor: (@message='') ->
    @name = 'GameDoesNotStartError'

# 投票時のエラー
class VoteError extends WOError
  constructor: (@message='') ->
    @name = 'VoteError'

Errors           = {}
Errors.WOError   = WOError
Errors.JoinError = JoinError
Errors.GameError = GameError
Errors.VoteError = VoteError
exports.Errors   = Errors
