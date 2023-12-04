//
//  RootView.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import SwiftUI

enum TabViewItem: Int {
    case cards = 0, home, history
}
struct CardsPage: View {
    var body: some View {
        EmptyView()
    }
}

struct HistoryPage: View {
    var body: some View {
        EmptyView()
    }
}

struct RootView: View {
    @State private var selectedTab: TabViewItem = .home
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .cards:
                CardsPage()
            case .home:
                MainPage()
            case .history:
                HistoryPage()
            }
            
            HStack {
                Spacer()
                Image(systemName: "rectangle")
                    .symbolEffect(.bounce, value: selectedTab == .cards)
                    .onTapGesture {
                        selectedTab = .cards
                    }
                Spacer()

                Image(systemName: "house")
                    .onTapGesture {
                        selectedTab = .home
                    }
                Spacer()

                Image(systemName: "chart.line.uptrend.xyaxis")
                    .onTapGesture {
                        selectedTab = .history
                    }
                Spacer()

            }
            .font(.largeTitle)
            .padding(.top)
        }
        
        
    }
}

#Preview {
    RootView()
}
