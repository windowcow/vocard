//
//  Date+.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation


extension Date {
    var defaultToMidnight: Date {
        Calendar.autoupdatingCurrent.date(from: self.ymd)!
    }
    
    var isWithinAWeak: Bool {
        /// 오늘이 7일인 경우
        ///  1일 00시 00분 ~ 7일 59분 59초
        self.addingTimeInterval(-6.day).defaultToMidnight <= self &&
        self <= self.addingTimeInterval(1.day).defaultToMidnight
        
    }
    
    var ymd: DateComponents {
        Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day], from: self)

    }
    
    var formattedWeekday: String {
        self.formatted(.dateTime.weekday(.abbreviated).locale(Locale(identifier: "ko_KR")))
    }
    
    
    var getPastSevenYMDIncludingToday: [DateComponents] {
        
        (-6...0).map { num in
            Date.now.addingTimeInterval(num.day)
        }
        .map{$0.ymd}
    }
    
    func formattedPreviousWeekdays() -> [Date.FormatStyle.FormatOutput] {
        (-6...0).map { num in
            Date.now.addingTimeInterval(num.day)
        }
        .map {
            $0.formattedWeekday
        }
    }
    
    func randomPastDate(_ interval: TimeInterval) -> Date {
        let  res = (-Int(interval)...0).randomElement() ?? 0
        return self.addingTimeInterval(Double(res))
    }
    
}
