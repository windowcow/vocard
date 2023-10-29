//
//  ContentView.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI
import SwiftData

struct CardStudyView: View {
    var body: some View {
        CardBackView(cardData: CardData(
            originalWord: "apple",
            translatedWord: "사과",
            englishDefinition: "a round fruit with red, yellow, or green skin and firm white flesh",
            exampleSentence: "She ate a fresh apple for breakfast.",
            learningScore: 5,
            consecutiveCorrectStreak: 3
        )
                     )
    }
}

#Preview {
    CardStudyView()
        .modelContainer(for: Item.self, inMemory: true)
}

//@Environment(\.modelContext) private var modelContext
//@Query private var items: [Item]
//
//var body: some View {
//    NavigationSplitView {
//        List {
//            ForEach(items) { item in
//                NavigationLink {
//                    Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                } label: {
//                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                }
//            }
//            .onDelete(perform: deleteItems)
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                EditButton()
//            }
//            ToolbarItem {
//                Button(action: addItem) {
//                    Label("Add Item", systemImage: "plus")
//                }
//            }
//        }
//    } detail: {
//        Text("Select an item")
//    }
//}
//
//private func addItem() {
//    withAnimation {
//        let newItem = Item(timestamp: Date())
//        modelContext.insert(newItem)
//    }
//}
//
//private func deleteItems(offsets: IndexSet) {
//    withAnimation {
//        for index in offsets {
//            modelContext.delete(items[index])
//        }
//    }
//}
