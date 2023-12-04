//
//  IllustrationDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftData

@Model final class IllustrationDataModel {
    var id: UUID
    var imageStyle: String
    var imageURL: URL
    
    init(id: UUID = UUID(), imageStyle: String, imageURL: URL) {
        self.id = id
        self.imageStyle = imageStyle
        self.imageURL = imageURL
    }
}

extension IllustrationDataModel {
    static var samples: [IllustrationDataModel] {
        [
            IllustrationDataModel(imageStyle: "cartoon", imageURL: URL(string: "https://plus.unsplash.com/premium_photo-1680740103993-21639956f3f0?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c2FtcGxlfGVufDB8fDB8fHww")!)
        
        ]
    }
}
