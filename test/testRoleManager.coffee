# テストしたいmoduleをrequire
WO = require('../scripts/wo').WO

# テスト用のライブラリをrequire (mochaの場合は、shouldがあればいいはず)
should = require('should')

describe 'RoleManager', () ->
  it 'pop role', ->
    manager = new WO.RoleManager
    l = manager.roles.length
    for index in [0...l]
      manager.roles.length.should.be.not.equal 0
      manager.popRoleByIndex(0)
    manager.roles.length.should.be.equal 0


