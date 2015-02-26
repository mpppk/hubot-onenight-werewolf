# テスト用のライブラリをrequire
should = require('should')

class EventListenerForTest
  constructor: (@messageManager) ->

  test:(public_messages, private_messages, describe, testFunction) ->
    it "EventListener.#{describe}", ->
      testFunction(public_messages, private_messages)

  testFinishAccepting: (public_messages, private_messages) =>
    public_messages[0].should.be.equal( @messageManager.finishAccepting() )

  testFinishDiscussion: (public_messages, private_messages) =>
    public_messages[0].should.be.equal( @messageManager.finishDisucussion() )

  testFinishVoting: (public_messages, private_messages) =>
    public_messages[0].should.be.equal( @messageManager.finishVoting() )

  onStartAccepting: (messages) ->

  onFinishAccepting: (public_messages, private_messages) =>
    this.test( public_messages, private_messages,
    'onFinishAccepting should receive MessageManager.finishAccepting()',
    this.testFinishAccepting )

  onFinishDiscussion: (messages) ->
    this.test( messages, null,
    'onFinishDiscussion should receive MessageManager.finishDisucussion()',
    this.testFinishDiscussion )

  onFinishVoting: (messages) ->
    this.test( messages, null,
    'onFinishVoting should receive MessageManager.finishVoting()',
    this.testFinishVoting )

  onVote: (messages) ->

exports.EventListenerForTest = EventListenerForTest
