# テストしたいmoduleをrequire
WO = require('../scripts/wo').WO

# テスト用のライブラリをrequire
should = require('should')

messageManager = new WO.MessageManager.Japanese

describe 'Controller', () ->
  describe 'startAcceptingMember', () ->
    it 'should success.', ->
      controller = new WO.Controller
      controller.startAcceptingMember("hoge", 1)
      controller.isOngoing.should.be.true
      controller.isWaitingParticipants.should.be.true

    it 'should throw exception when call it twice.', () ->
      controller = new WO.Controller
      controller.startAcceptingMember("hoge", 1)
      ( -> controller.startAcceptingMember("hoge", 1) ).should.be.throw()

  describe 'reset', () ->
    it 'should success', () ->
      controller = new WO.Controller
      message = controller.reset()
      controller.isOngoing.should.be.false
      message.should.be.equal( messageManager.terminateGame() )
    
  describe 'join', () ->
    it 'should success', () ->
      controller = new WO.Controller
      controller.startAcceptingMember("hoge", 1)
      userName = "testUser1"
      message = controller.join(userName)
      message.should.be.equal( messageManager.memberJoined( userName ) )

    it 'should not waiting participants', (done) ->
      controller = new WO.Controller
      controller.startAcceptingMember("hoge", 0.001)
      setTimeout () ->
        controller.isWaitingParticipants.should.be.false
        ( -> controller.join("testUser1") ).should.be.throw()
        done()
      , 0.01

    it 'should throw exception when join by same user twice.', () ->
      controller = new WO.Controller
      controller.startAcceptingMember("hoge", 1)
      userName = "testUser1"
      controller.join(userName)
      ( -> controller.join(userName) ).should.be.throw()

  describe 'vote', () ->
    USER_NAME1 = "testUser1"
    USER_NAME2 = "testUser2"

    it 'should be success', (done) ->
      controller = new WO.Controller
      controller.discussionTime          = 0.001
      controller.votingCheckIntervalTime = 0.005
      controller.startAcceptingMember(USER_NAME1, 0.001)
      controller.join(USER_NAME2)
      setTimeout () ->
        expectState = controller.VOTING_STATE.accept
        controller.votingState.should.be.equal expectState
        controller.vote(USER_NAME1, USER_NAME2)
        controller.vote(USER_NAME2, USER_NAME1)
      
        setTimeout () ->
          expectState = controller.VOTING_STATE.finish
          controller.votingState.should.be.equal expectState
          it 'should throw exception when hogehoge.', () ->
            console.log "hoge"
          done()
        , 20
      , 20

    it 'should throw exception when voting is not yet acceping.', () ->
      controller = new WO.Controller
      controller.startAcceptingMember(USER_NAME1, 1000)
      controller.join(USER_NAME2)
      expectState = controller.VOTING_STATE.waiting
      controller.votingState.should.be.equal expectState
      ( -> controller.vote USER_NAME1, USER_NAME2 ).should.be.throw()

    it 'should throw exception when voting has already finished.', (done) ->
      controller = new WO.Controller
      controller.discussionTime          = 0.001
      controller.votingCheckIntervalTime = 0.005

      controller.startAcceptingMember(USER_NAME1, 0.005)
      controller.join(USER_NAME2)
      setTimeout () ->
        controller.vote(USER_NAME1, USER_NAME2)
        controller.vote(USER_NAME2, USER_NAME1)
        setTimeout () ->
          controller.votingState.should.be.equal controller.VOTING_STATE.finish
          ( -> controller.vote USER_NAME1, USER_NAME2 ).should.be.throw()
          done()
        , 10
      , 10

    it 'should throw exception when player already voted.', (done) ->
      controller = new WO.Controller
      controller.discussionTime = 0.001

      controller.startAcceptingMember(USER_NAME1, 0.005)
      controller.join(USER_NAME2)
      setTimeout () ->
        controller.vote(USER_NAME1, USER_NAME2)
        ( -> controller.vote(USER_NAME1, USER_NAME2) ).should.be.throw()
        done()
      , 10

    it 'should throw exception' +
    ' when given name of player doesn\'t exist.', (done) ->
      controller = new WO.Controller
      controller.discussionTime = 0.001

      controller.startAcceptingMember(USER_NAME1, 0.005)
      controller.join(USER_NAME2)
      setTimeout () ->
        ( -> controller.vote(USER_NAME1, "DO_NOT_EXIST") ).should.be.throw()
        done()
      , 10
