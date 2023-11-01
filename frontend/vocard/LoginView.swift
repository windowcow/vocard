//
//  LoginView.swift
//  vocard
//
//  Created by 조예현 on 2023/10/20.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack{
            Color.mainBgr
                .ignoresSafeArea()
            MainView()
        }
    }
}

struct OnBoardingContent: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var contents: String
    
    static let onBoardingList: [OnBoardingContent] = [
        OnBoardingContent(title: "카드로 쉽게 암기하기", contents: "카드 형태로 빠르게 넘기며 단어를 암기하세요.\n넘기기만 해도 외워지는 알고리즘으로 추천해드려요."),
        OnBoardingContent(title: "직접 만드는 예문과 이미지", contents: "예문을 직접 만들면 단어가 더 잘외워져요.\n보카드가 문법을 확인하고 그에 맞는 이미지를 생성해요."),
        OnBoardingContent(title: "매일 알람받기", contents: "매일매일 단어를 암기해봐요.\n설정한 시간에 보카드와 만날 수 있게 알려드릴게요."),
        OnBoardingContent(title: "암기를 확인하는 퀴즈", contents: "카드를 넘기기 전에 퀴즈로 한번 더 확인할 수 있어요.\n모르는 단어를 그냥 넘어가지 않게 막아줘요.")
    ]
}

struct BeforeLoginView: View {
    @Binding var isLoggedIn: Bool
    let onBoardingList: [OnBoardingContent] = OnBoardingContent.onBoardingList
    
    var body: some View {
        VStack(alignment: .center, spacing: 25, content: {
            Image("text_logo")
            
            TabView {
                ForEach(onBoardingList, id: \.id) { onBoarding in
                    OnBoardingView(title: onBoarding.title, contents: onBoarding.contents).padding(.bottom,20)
                }
            }
            .frame(width: 400, height: 490)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            
            Button{
                // kakao login
                tryLogin()
            }label: {
                Image("kakao_login_btn")
                    .resizable()
                    .frame(width: 320, height: 50)
            }
            .padding(.top,20)
        })
    }
    
    
    private func tryLogin() {
        isLoggedIn.toggle()
    }
}

struct MainView: View {
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        switch isLoggedIn {
        case false:
            BeforeLoginView(isLoggedIn: $isLoggedIn)
        case true:
            HomeView()
            
        }
        
    }
}


struct OnBoardingView: View {
    let title: String
    let contents: String
    
    var body: some View {
        VStack(spacing: 18, content: {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 300, height: 300)
            Text(title)
                .fontWeight(.bold)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 24.0))
            Text(contents)
                .foregroundColor(Color("OnboardingTxt"))
                .font(.system(size: 14.0))
                .multilineTextAlignment(.center)
        })
    }
}

#Preview {
    LoginView()
}
