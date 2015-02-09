# テストしたいmoduleをrequire
WO = require('../scripts/wo').WO

# テスト用のライブラリをrequire
should = require('should')

describe 'Controller', () ->
  it 'w start', ->
    controller = new WO.Controller
    controller.start(1).should.be.true
    controller.isOngoing.should.be.true
    controller.isWaitingParticipants.should.be.true

  it 'w reset', () ->
    controller = new WO.Controller
    controller.reset()
    controller.isOngoing.should.be.false
    

