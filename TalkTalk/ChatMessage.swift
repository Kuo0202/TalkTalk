//
//  ChatMessage.swift
//  TalkTalk
//
//  Created by PeterKuo on 2022/3/23.
//

import Foundation

class ChatMessage {

    let id: UInt16
    let sender: String
    let content: String

    init(sender: String, content: String, id: UInt16) {
        self.sender = sender
        self.content = content
        self.id = id
    }
}
