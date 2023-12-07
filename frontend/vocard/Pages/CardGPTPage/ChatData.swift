//
//  StudyMaterialData.swift
//  vocard
//
//  Created by windowcow on 12/7/23.
//

import Foundation
import SwiftData

@Model class ChatData {
    var headword: String
    var myMessage: String
    var gptMessage: String?
    var imageURL: String?
    
    init(headword: String, myMessage: String) {
        self.headword = headword
        self.myMessage = myMessage
    }
}

extension ChatData {
    static func predicate(headword: String) -> Predicate<ChatData> {
        return #Predicate<ChatData> { studyMaterialData in
            headword == studyMaterialData.headword
        }
    }
}
