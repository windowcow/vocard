//
//  CardsPage_Top.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI

     
struct CardsPage_Top: View {
    @Environment(CardsPage_VM.self) var vm
    
    var body: some View {
        ZStack {
            Color.clear
            HStack {
                DatePicker("", selection: Binding(get: {
                    vm.selectedDate
                },
                                                  set: { v in
                    vm.selectedDate = v
                }), displayedComponents: .date)
                .datePickerStyle(.automatic)
                
                
                Spacer()
                
                // TODO: 정렬.
                Picker("", selection: Binding(get: {
                    vm.seenFilterType
                }, set: { v in
                    vm.seenFilterType = v
                })) {
                    Text("all")
                        .tag(CardsPage_VM.SeenFilterType.all)
                    Text("seen")
                        .tag(CardsPage_VM.SeenFilterType.seen)

                    Text("unseen")
                        .tag(CardsPage_VM.SeenFilterType.unseen)

                }
                .pickerStyle(.segmented)

                Picker(selection: Binding(get: {
                    vm.filterBy
                }, set: { v in
                    vm.filterBy = v
                })) {
                    Label("No Filter", systemImage: "xmark")
                        .tag(CardsPage_VM.FilterType.none(.ascending))

                    Label("Alphabet", systemImage: "abc")
                        .tag(CardsPage_VM.FilterType.alphabet(.ascending))

                    Label("Stars", systemImage: "star.fill")
                        .tag(CardsPage_VM.FilterType.stars(.ascending))

                } label: {
                    Label(
                        title: { Text("Label") },
                        icon: { Image(systemName: "arrow.up.arrow.down") }
                    )
                }
                .background(.white, in: .capsule)
                .labelStyle(.iconOnly)

                

            }
        }
    }
}

#Preview {
    CardsPage()
        .modelContainer(sharedModelContainer)
}
