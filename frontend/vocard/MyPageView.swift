//
//  MyPageView.swift
//  vocard
//
//  Created by 조예현 on 2023/10/27.
//

import SwiftUI

struct MyPageView: View {
    @State var newCardProbability: Double = 0.0
    var roundedValue: Int {
        Int(newCardProbability)
    }
    var body: some View {
        ZStack{
            Color("MainBgr")
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("My Page")
                    .foregroundColor(.white)
                    .font(.system(size: 36.0))
                Divider()
                    .background(Color.white)
                LogoutView()
                
                VStack(alignment: .leading) {
                    Text("새로운 카드 등장 확률")
                        .font(.title3)
                        .foregroundStyle(.white)
                    HStack {
                        Slider(value: $newCardProbability,
                               in: 0...100)
                        Text("\(roundedValue)%")
                            .foregroundStyle(.white)
                    }
                    Divider()
                        .background(.white)
                    BtnItem(btnText: "오늘의 목표치 설정")
                    BtnItem(btnText: "단어 기록 초기화")
                    BtnItem(btnText: "회원 탈퇴")
                }
                .padding(.vertical)
                
                Spacer()
            }
            .padding(.horizontal, 30)
        }
    }
}

struct LogoutView: View {
    var body: some View {
        HStack(content: {
            Text("홍길동 님")
                .foregroundColor(.white)
            Spacer()
            Button {
                // 로그아웃 로직
            } label: {
                Text("로그아웃")
                    .font(.system(size: 16.0))
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    .background(
                        Capsule()
                            .fill(Color("MainBgr"))
                            .stroke(Color.white, lineWidth: 2)
                    )
            }
        })
    }
}

struct CloseBtn: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

struct BtnItem: View {
    let btnText: String
    var body: some View {
        Button(action: {
            
        }, label: {
            Text(btnText)
                .foregroundColor(.white)
                .font(.system(size: 18.0))
                .padding(.vertical, 20)
                .padding(.leading, 15)
        })
        Divider().background(.white)
    }
}

#Preview {
    MyPageView(newCardProbability: 30)
}
