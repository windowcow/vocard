//
//  ReviewResultDataModel+Samples.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation


extension ReviewData {
    static func makeSample() -> ReviewData {
        ReviewData(reviewDate: Date.now.randomPastDate(7.day), result: .success(1))
    }
}
