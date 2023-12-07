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
    
    @State private var noDate: Bool = true
    @Namespace var top
    
    var body: some View {
        ZStack {
            Color.clear
            HStack {
                if let selectedData = vm.selectedDate {
                    HStack {
                        DatePicker("", selection: Binding(get: {
                            vm.selectedDate ?? Date.now
                        },
                                                          set: { v in
                            vm.selectedDate = v
                        }), displayedComponents: .date)
                        .datePickerStyle(.automatic)
                        
                        Image(systemName: "calendar")
                            .foregroundStyle(.blue)
                            .font(.title2)
                            .onTapGesture {
                                vm.selectedDate = nil
                            }
                            .matchedGeometryEffect(id: "calendar",
                                                   in: top)
                            
                        
                    }
                    .fixedSize()
                    
                } else {
                    Image(systemName: "calendar")
                        .foregroundStyle(.red)
                        .font(.title2)
                        .padding(.leading)
                        .matchedGeometryEffect(id: "calendar",
                                               in: top)
                        .onTapGesture {
                            vm.selectedDate = Date.now
                        }
                }
                
                
                
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
        .animation(.bouncy, value: vm.selectedDate)
    }
}

#Preview {
    CardsPage()
        .modelContainer(sharedModelContainer)
}
