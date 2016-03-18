//
//  Common.swift
//  NewbieZone
//
//  Created by zhaochenjun on 15/12/30.
//  Copyright © 2015年 kazmastudio. All rights reserved.
//

import UIKit
// WAO
//let weChatAppid = "wx74587b9207ae1ef6"
//let weChatSecret = "acd901b1dc3bcba6ed1e4bbe50b91d73"

// ZHAOCHENJUN
//let weChatAppid = "wx11f39a75d23f49f0"
//let weChatSecret = "cafd39507178263493418a720a8a7ab0"

// COUNT ME IN
let weChatAppid = "wxb74391e462f751a0"
let weChatSecret = "e08f3ecbcfacc042dc49f5fb576393e7"

// ZIJINWANG
//let weChatAppid = "wx967f65b9e6652798"
//let weChatSecret = "08dc3f4bbf2b7fe28e4cf8b7042a520c"

let URL_WECHAT_ACCESSTOKEN = "https://api.weixin.qq.com/sns/oauth2/access_token"
let URL_WECHAT_USERINFO = "https://api.weixin.qq.com/sns/userinfo"

let URL_RESTFUL = "http://restmuzi.kazmastudio.com"
let RESTFUL_METHOD_PASSBY = "/passby"
let RESTFUL_METHOD_POST_USER_GPS_RECORD = "/postUserGPSRecord"
let RESTFUL_METHOD_GET_USER_GPS_RECORD = "/getUserGPSRecord"

func createRESTfulURL (method: String) -> String{
    return URL_RESTFUL + method;
}

let userDefaults = NSUserDefaults.standardUserDefaults()

let KEY_SESSION_ID = "sessionId"

// we chat key
let KEY_WECHATINFO = "weChatInfo"
let KEY_UNIONID = "unionid"
let KEY_NICKNAME = "nickname"
let KEY_AVATAR = "headimgurl"

// segue id
let SEGUE_LOGIN_2_MAIN = "Login2Main"

// view tag
let TABLE_VIEW_NO_DATA_VIEW_TAG = 999001


