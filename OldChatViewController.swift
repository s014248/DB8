//
//  ChatController.swift
//  SwiftUI Chat
//
//  Created by Alexander Zhang (student LM) on 1/16/20.
//  Copyright © 2020 Alexander Zhang (student LM). All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class OldChatViewController : ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    @Published var messages = [
        ChatMessage(message: "Hello world", avatar: "A", color: .red),
        ChatMessage(message: "Hi", avatar: "B", color: .blue)
    ]
    
    func sendMessage(_ chatMessage: ChatMessage) {
        messages.append(chatMessage)
        didChange.send(())
    }
    
}
