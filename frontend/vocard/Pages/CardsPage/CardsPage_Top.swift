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
                .fixedSize()
                
                if vm.isSeenSelected {
                    Button("Seen") {
                        vm.isSeenSelected.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                } else {
                    Button("Seen") {
                        vm.isSeenSelected.toggle()
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                }
                
                if vm.isUnseenSelected {
                    Button("Unseen") {
                        vm.isUnseenSelected.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                } else {
                    Button("Unseen") {
                        vm.isUnseenSelected.toggle()
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                }
                Spacer()
                
                
                Button {
                    
                } label: {
                    VStack{
                        Text(Image(systemName: "arrow.up.arrow.down"))

                    }
                }
                .padding(.trailing)

            }
        }
    }
}

#Preview {
    CardsPage()
        .modelContainer(sharedModelContainer)
}
