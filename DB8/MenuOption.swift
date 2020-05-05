//
//  MenuOption.swift
//  DB8
//
//  Created by Justin Robertson (student LM) on 4/19/20.
//  Copyright © 2020 Alexander Zhang (student LM). All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case Profile
    case Inbox
    case Exit
    case Settings
    
    var description: String{
        switch self{
        case .Profile: return "Report Player"
        case .Inbox: return "Topic"
        case .Exit: return "Exit"
        case .Settings: return "Settings"
        }
    }
    
    var image: UIImage{
        switch self{
        case .Profile: return UIImage(named: "person") ?? UIImage()
        case .Inbox: return UIImage(named: "mail") ?? UIImage()
        case .Exit: return UIImage(named: "stack") ?? UIImage()
        case .Settings: return UIImage(named: "settings") ?? UIImage()
        }
    }
}
