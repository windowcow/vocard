//
//  Array+Extensions.swift
//  vocard
//
//  Created by windowcow on 11/16/23.
//

import Foundation

extension Array where Element == Double {
    func cumulativeSum() -> [Element] {
        var total: Element = 0
        return self.map { (element) -> Element in
            total += element
            return total
        }
    }
}

extension Array where Element == Drawable {
    func draw() -> Element {
        let cumulativeDegrees = self.map{$0.weight}.cumulativeSum()
        
        let random = Double.random(in: 0...cumulativeDegrees.last!)

            // 랜덤 값에 해당하는 요소 찾기
            for (index, weight) in cumulativeDegrees.enumerated() {
                if random <= weight {
                    return self[index]
                }
            }
        
        return self.last!
    }
}
