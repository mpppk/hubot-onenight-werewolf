# テストしたいmoduleをrequire
WO = require('../scripts/wo').WO

# テスト用のライブラリをrequire (mochaの場合は、shouldがあればいいはず)
should = require('should')

describe 'MemberManager', () ->
  it 'add member', ->
    manager = new WO.MemberManager
    roleNum = manager.roleManager.roleNum

    for i in [0...roleNum]
      manager.addMember("testUser#{i}")
    manager.getLength().should.equal roleNum
    
  it 'get members name', ->
    manager = new WO.MemberManager
    manager.addMember("testUser1")
    manager.addMember("testUser2")
    manager.getMembersName()[0].should.equal "testUser1"
    

