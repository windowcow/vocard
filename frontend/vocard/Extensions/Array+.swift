//
//  Array+.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation

extension Array {
    /// prob = 60이면 60% 확률로 앞의 요소가 걸린다.
    func pickOneByProbabilityOf(_ prob: Int) -> Element? {
        guard !isEmpty, (0...100).contains(prob) else { return nil }

        return Int.random(in: 0..<100) < prob ? self[0] : nil
    }
}

