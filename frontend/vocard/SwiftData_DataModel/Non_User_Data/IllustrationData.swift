//
//  IllustrationDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftData

@Model final class IllustrationData {
    var imageStyle: String
    var imageURL: URL
    
    @Relationship var exampleData: ExampleData?
    
    init(imageStyle: String, imageURL: URL) {
        self.imageStyle = imageStyle
        self.imageURL = imageURL
    }
}

extension IllustrationData {
    static var samples: [IllustrationData] {
        [
            IllustrationData(imageStyle: "cartoon", imageURL: URL(string: "https://plus.unsplash.com/premium_photo-1680740103993-21639956f3f0?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c2FtcGxlfGVufDB8fDB8fHww")!)
        
        ]
    }
}
