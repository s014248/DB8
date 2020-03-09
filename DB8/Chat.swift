//
//  Chat.swift
//  DB8
//
//  Created by Alexander Zhang (student LM) on 3/6/20.
//  Copyright © 2020 Alexander Zhang (student LM). All rights reserved.
//

import UIKit

struct Chat {
    var users: [String]
    var dictionary: [String: Any] {
        return ["users": users]
    }
}
extension Chat {
    init?(dictionary: [String:Any]) {
        guard let chatUsers = dictionary["users"] as? [String] else {return nil}
        self.init(users: chatUsers)
    }
}
