# テストしたいmoduleをrequire
WO = require('../scripts/wo').WO

# テスト用のライブラリをrequire (mochaの場合は、shouldがあればいいはず)
should = require('should')

describe 'Robber', () ->
  it 'exchange role', ->
    manager = new WO.MemberManager
    roleNum = manager.roleManager.roleNum

    for i in [0...roleNum]
      manager.addMember("testUser#{i}")

    robberMember = manager.getMembersByRoleName( "怪盗" )[0]
    robberMember.workAtNight()
    stolenMember = robberMember.stolenMember
    stolenMemberName = stolenMember.name
    stolenMember.role.name.should.be.equal "怪盗"
    expectMessage =
    "#{stolenMemberName}の「#{robberMember.role.name}」とあなたの「怪盗」を交換しました。"
    robberMember.getMessageAfterNight().should.be.equal expectMessage

