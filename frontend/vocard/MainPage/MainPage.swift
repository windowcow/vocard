//
//  MainPage.swift
//  vocard
//
//  Created by windowcow on 11/30/23.
//

import SwiftUI
import SwiftData
import Charts

struct MainPage: View {
    var body: some View {
        VStack {
            MainPage_Top()
                .frame(maxHeight: 100)
            Spacer()
            MainPage_Middle_StarCount()
            Spacer()
            MainPage_Middle_NextWord()
        }
        .background(.black)
    }
}


struct DateStarCount: Identifiable {
    var id: Date {
        date
    }
    
    var date: Date
    var starCount: Int
}





struct MainPage_Middle_StarCount_Chart: View {
    var body: some View {
        EmptyView()
    }
}

struct MainPage_Middle_NextWord: View {
    var body: some View {
        VStack{
            
        }
    }
}



#Preview {
    MainPage()
        .background(.black)
        .modelContainer(sampleContainer)
}
