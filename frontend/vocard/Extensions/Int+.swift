//
//  Int+.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation


extension Int {
    var day: TimeInterval {
        return 3600 * 24 * Double(self)
    }
    
    var hour: TimeInterval {
        return 3600 * Double(self)
    }
    
    var minute: TimeInterval {
        return 60 * Double(self)
    }
    
    
}
