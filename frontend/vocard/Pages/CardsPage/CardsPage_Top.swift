//
//  CardsPage_Top.swift
//  vocard
//
//  Created by windowcow on 12/5/23.
//

import SwiftUI

     
struct CardsPage_Top: View {
    @Environment(CardsPage_VM.self) var vm
    @Environment(\.dismiss) private var dismiss
    
//    @State 
    
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

                Picker(selection: Binding(get: {
                    vm.filterBy
                }, set: { v in
                    vm.filterBy = v
                })) {
                    Label("No Sorting", systemImage: "xmark")
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

                Image(systemName: "x.circle")
                    .font(.title)
                    .padding(.trailing)
                    .onTapGesture {
                        dismiss()
                    }

            }
        }
    }
}

#Preview {
    CardsPage()
        .modelContainer(sharedModelContainer)
}
