//
//  Item.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//
 
import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
