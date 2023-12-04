//
//  ReviewResultDataModel+Samples.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation


extension ReviewResultDataModel {
    static func makeSample() -> ReviewResultDataModel {
        ReviewResultDataModel(reviewDate: Date.now.randomPastDate(7.day), result: .success(1))

    }
}
