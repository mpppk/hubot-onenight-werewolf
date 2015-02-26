# テストしたいmoduleをrequire
WO = require('../scripts/wo').WO

# テスト用のライブラリをrequire (mochaの場合は、shouldがあればいいはず)
should = require('should')

describe 'Member', () ->
  describe 'constructor', ->
    it 'should be success', ->
      memberManager = new WO.MemberManager()
      member        = new WO.Member("testUser1", memberManager)

    it 'should be thrwo exception when pass invalid argument', ->
      memberManager = new WO.MemberManager()
      ( -> member = new WO.Member() ).should.be.throw()
      ( -> member = new WO.Member("testUser1") ).should.be.throw()

  describe 'setRole', ->
    it 'should be success', ->
      memberManager = new WO.MemberManager()
      member        = new WO.Member("testUser1", memberManager)
      member.setRole( new WO.Roles.Werewolf )
      member.role.name.should.be.equal WO.Roles.Werewolf.name

    it 'should be throw exception when argument is not instance of Role.'

  describe 'getMessageAtNight', ->
    it 'should be success', ->
      memberManager = new WO.MemberManager()
      member1       = new WO.Member("testUser1", memberManager)
      member2       = new WO.Member("testUser2", memberManager)
      member1.setRole( new WO.Roles.Robber   )
      member2.setRole( new WO.Roles.Werewolf )
      member2.getMessageAtNight()

  describe 'workAtNight', ->
    it 'should be success'

  describe 'getMessageAfterNight', ->
    it 'should be success'

  describe 'voteTo', ->
    it 'should be success'
    it 'should be throw exception when member is already voted'

  describe 'votedFrom', ->
    it 'should be success'
    it 'should be throw exception when member is already voted'

