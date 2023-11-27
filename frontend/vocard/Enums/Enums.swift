//
//  Enums.swift
//  vocard
//
//  Created by windowcow on 11/27/23.
//

import Foundation

enum DefinitionType {
   case english, korean
}

enum CardViewStatus: Equatable {
   enum CardFrontStatus {
       case left, middle, right
   }
   
   enum CardBackStatus {
       case detail, quiz
   }
   
   case front(CardFrontStatus)
   case back(CardBackStatus)
}
