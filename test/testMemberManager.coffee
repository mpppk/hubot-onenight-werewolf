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
    
describe 'getMaxVotesCast', ->
  it 'should be success'
  
describe 'getMembersByRoleName', ->
  it 'should be success'
  
describe 'getMemberByName', ->
  it 'should be success'
  
describe 'getMemberByRandom', ->
  it 'should be success'
  
describe 'getMemberByRandomWithoutArgumentName', ->
  it 'should be success'
  
describe 'getMostVotedMembers', ->
  it 'should be success'
  
describe 'workAtNight', ->
  it 'should be success'
  
describe 'getVotesCast', ->
  it 'should be success'
  
describe 'getVotingResult', ->
  it 'should be success'
  
describe 'getVotingResultMessage', ->
  it 'should be success'
  
describe 'getWinningTeamName', ->
  it 'should be success'
  
