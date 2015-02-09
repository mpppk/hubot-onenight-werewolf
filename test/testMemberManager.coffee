# テストしたいmoduleをrequire
WO = require('../scripts/wo').WO

# テスト用のライブラリをrequire (mochaの場合は、shouldがあればいいはず)
should = require('should')

describe 'MemberManager', () ->
  it 'add member', ->
    manager = new WO.MemberManager
    manager.addMember("testUser1")
    manager.addMember("testUser2")
    manager.getLength().should.equal 2
    
  it 'get members name', ->
    manager = new WO.MemberManager
    manager.addMember("testUser1")
    manager.addMember("testUser2")
    manager.getMembersName()[0].should.equal "testUser1"
    

