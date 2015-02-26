WO = {}
WO.Member                = require('./member'        ).Member
WO.MemberManager         = require('./memberManager' ).MemberManager
WO.Controller            = require('./controller'    ).Controller
WO.RoleManager           = require('./roleManager'   ).RoleManager
WO.Roles                 = require('./roleManager'   ).Roles
WO.MessageManager        = require('./messageManager').MessageManager
WO.Errors                = require('./error'         ).Errors
WO.EventListenerForHubot =
require('./eventListenerForHubot').EventListenerForHubot

exports.WO = WO
