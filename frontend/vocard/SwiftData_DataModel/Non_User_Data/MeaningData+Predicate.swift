//
//  MeaningData+Predicate.swift
//  vocard
//
//  Created by windowcow on 12/6/23.
//

import Foundation

extension MeaningData {
    static func predicate(
        meaningNum: Int,
        meaning: String
    ) -> Predicate<MeaningData> {
        return #Predicate<MeaningData> { meaningData in
            meaningNum == meaningData.meaningNum &&
            meaning == meaningData.meaning
        }
    }
}
