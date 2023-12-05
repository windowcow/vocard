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
                
                Menu {
                    Button {
                        vm.seenFilterType = .all
                    } label: {
                        Label("All", 
                              systemImage: "square.grid.3x3.fill")
                    }
                    Button {
                        vm.seenFilterType = .seen

                    } label: {
                        Label("Seen", systemImage: "rectangle")
                    }
                    Button {
                        vm.seenFilterType = .unseen

                    } label: {
                        Label("Unseen", systemImage: "questionmark.square")
                    }
                } label: {
                    Label(
                        title: {
                            Text("")
                                .font(.callout)
                        },
                        icon: {
                            switch vm.seenFilterType {
                            case .all:
                                Image(systemName: "square.grid.3x3.fill")
                            case .seen:
                                Image(systemName: "rectangle")
                            case .unseen:
                                Image(systemName: "questionmark.square")

                            }
                        }
                    )
                    .foregroundStyle(.black)
                    .font(.title)

                }
                
                Spacer()
                
                // TODO: 정렬.
                
//                Menu {
//                    Button {
//                        
//                    } label: {
//                        <#code#>
//                    }
//                    
//                    Button {
//                        
//                    } label: {
//                        
//                    }
//                    
//                    Button {
//                        
//                    } label: {
//                        <#code#>
//                    }
//                    
//                } label: {
//                    switch vm.filterBy {
//                    case .none:
//                        Image(systemName: "arrow.up.arrow.down")
//                    case .stars:
//                        Image(systemName: "star.fill")
//                    case .alphabet:
//                        Image(systemName: "textformat.abc")
//                    }
//                }
//                .padding(.trailing)
                

            }
        }
    }
}

#Preview {
    CardsPage()
        .modelContainer(sharedModelContainer)
}
