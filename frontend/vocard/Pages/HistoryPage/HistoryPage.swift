//
//  HistoryPage.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI

struct HistoryPage: View {
    @State var date: Date = .now
    
    var body: some View {
        
        DatePicker("", selection: $date, displayedComponents: .date)
    }
}

#Preview {
    HistoryPage()
}
