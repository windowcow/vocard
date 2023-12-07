//
//  WordData+Predicate.swift
//  vocard
//
//  Created by windowcow on 12/6/23.
//

import Foundation


extension WordData {
    static func predicate(
        headword: String
    ) -> Predicate<WordData> {
        return #Predicate<WordData> { word in
            word.headword == headword
        }
    }
}
