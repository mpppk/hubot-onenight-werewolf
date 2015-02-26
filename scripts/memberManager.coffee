Member      = require('./member').Member
Roles       = require('./roleManager').Roles
RoleManager = require('./roleManager').RoleManager

# ---- ゲームの参加者を管理するクラス ----
class MemberManager
  constructor: () ->
    @members = []
    @roleManager = new RoleManager

  # 全てのメンバーの名前を格納した配列を返す
  getMembersName: () ->
    (member.name for member in @members)

  # 全てのメンバーの名前をリストにした文字列を返す
  getMembersList: () =>
    memberList = "```"
    membersName = this.getMembersName()
    for name in membersName
      memberList += name + "\n"
    memberList + "```"

  # メンバーを追加
  addMember: (memberName) =>
    member = new Member(memberName, this)
    member.setRole( @roleManager.popRole() )
    @members.push( member )

  # メンバーの人数を返す
  getLength: () ->
    @members.length

  getMaxVotesCast: () =>
    this.getMostVotedMembers()[0].votesCast

  # 指定した役職を持つメンバーインスタンスの配列を返す
  getMembersByRoleName: (roleName) ->
    ret = []
    for member in @members
      if member.role.name == roleName
        ret.push( member )
    ret

  # 与えられた名前を持つメンバーのインスタンスを返す
  getMemberByName: (name) ->
    for member in @members
      if member.name == name
        return member

  # ランダムにメンバーインスタンスを返す
  getMemberByRandom: () ->
    index = Math.floor( Math.random() * @members.length )
    @members[index]

  # 指定した名前のメンバー以外のメンバーインスタンスをランダムに返す
  getMemberByRandomWithout: (name, maxIter = 1000) ->
    for i in [0..maxIter]
      otherMember = this.getMemberByRandom()
      if otherMember.name != name
        return otherMember
    console.log "Member.ManagergetMemberByRandomWithout()" +
    "can't find other member."
    return null

  # 最も多く得票しているメンバーのインスタンスの配列を返す。
  getMostVotedMembers: () ->
    retMembers   = []
    maxVotesCast = 0
    for member in @members
      if member.votesCast > maxVotesCast
        retMembers = [member]
      else if member.votesCast == maxVotesCast
        retMembers.push member
    retMembers

  # 各メンバーの夜の行動を行う。各メンバーごとのメッセージのハッシュを返す。
  workAtNight: (messageManager) ->
    msgs = {}
    for member in @members
      msgs[member.name] = member.getMessageAtNight(messageManager)

    member.workAtNight() for member in @members
    
    for member in @members
      if member.getMessageAfterNight(messageManager)?
        msgs[member.name] += "\n" + member.getMessageAfterNight()
    msgs

  # 投票総数を返す
  getVotesCast: () ->
    sum = 0
    for member in @members
      sum += member.votesCast
    sum

  # 投票の結果を文字列で返す
  getVotingResult: () ->
    result = {}
    for member in @members
      result[member.name] = member.votedMembersName
    result

  # 投票の結果を文字列で返す
  getVotingResultMessage: (messageFunc) ->
    unless messageFunc?
      throw TypeError("messageFunc is not exist.
       (in MemberManager.getVotingResultMessage())")

    messages = ""
    for member in @members
      messages += messageFunc(member.name, member.votedMembersName) + "\n"
    messages

  # 勝利したチーム名を返す
  # 人狼側が勝利していた場合      -> "werewolf"
  # 村人側が勝利していた場合      -> "human"
  # 平和村だったが処刑を行った場合 -> "lostPeace"
  # 平和村で処刑を行わなかった場合 -> "peace"
  getWiningTeamName: () ->
    werewolfName = Roles.Werewolf.name
    werewolfs    = this.getMembersByRoleName(werewolfName)
    maxVotesCast = this.getMaxVotesCast()

    # 平和村だった場合
    if werewolfs.length == 0
      return if maxVotesCast > 1 then "lostPeace" else "peace"

    humanWinFlag = true
    for werewolf in werewolfs
      if werewolf.votesCast < maxVotesCast
        humanWinFlag = false
        break
    if humanWinFlag then "werewolf" else "human"


exports.MemberManager = MemberManager
