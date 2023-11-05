//
//  AlarmPage.swift
//  vocard
//
//  Created by windowcow on 11/4/23.
//

import SwiftUI

enum AlarmOption: String {
    case includeWeekends = "주말 포함" // 주말 포함
    case excludeWeekends = "주말 제외" // 주말 제외
    case customSetting = "직접 설정"   // 직접 설정
    
    
}

struct BorderedButton<Label: View>: View {
    let action: () -> Void
    let label: () -> Label
    var body: some View {
        Button {
            action()
        } label: {
            label()
        }
    }
}

struct AlarmOptionButton: View {
    @Binding var selectedAlarmOption: AlarmOption
    let currentAlarmOption: AlarmOption
    
    var body: some View {
        if selectedAlarmOption == currentAlarmOption {
            Button(selectedAlarmOption.rawValue) {
                selectedAlarmOption = currentAlarmOption
            }
            .frame(width: 94, height: 36, alignment: .center)
            .foregroundStyle(.black)
            .tint(.white)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
        } else {
            Button(selectedAlarmOption.rawValue) {
                selectedAlarmOption = currentAlarmOption

            }
            .frame(width: 94, height: 36, alignment: .center)
            .foregroundStyle(.white)
            .tint(.black)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .border(.red)


        }
    }
}

struct AlarmPage: View {
    @State private var selectedAlarmOption: AlarmOption = .includeWeekends
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "xmark")
                        .font(.system(size: 40))
                        .bold()
                        .padding(.horizontal)

                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("Alarm")
                            .font(.system(size: 36))
                            .padding(.horizontal)
                        Text("같이 공부할 시간을 정해주세요. \n푸쉬 알림으로 알려드릴게요")
                            .padding()
                    }
                    .bold()

                    Spacer()
                }
                .padding(.leading)
                Spacer()
                
                HStack {
                    AlarmOptionButton(selectedAlarmOption: $selectedAlarmOption,
                                      currentAlarmOption: .includeWeekends)
                    AlarmOptionButton(selectedAlarmOption: $selectedAlarmOption,
                                      currentAlarmOption: .excludeWeekends)
                    AlarmOptionButton(selectedAlarmOption: $selectedAlarmOption,
                                      currentAlarmOption: .customSetting)
                }
                Spacer()
                
                
                
                    
            }
            Color.clear

        }
        .foregroundColor(.white)
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        AlarmPage()
        
//        Button {
//            
//        } label: {
//            ZStack {
//                Text("123123")
//                RoundedRectangle(cornerRadius: 15)
//            }
//        }



    }
}
