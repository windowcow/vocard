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

struct OnBoardingContent: Identifiable {
    var id = UUID()
    var img_btm: Image
    var img_top: Image
    var title: String
    var contents: String
    var x: Double
    
    static let onBoardingList: [OnBoardingContent] = [
        OnBoardingContent(img_btm: Image("Onboarding_1_1"), img_top: Image("Onboarding_1_2"), title: "카드로 쉽게 암기하기", contents: "카드 형태로 빠르게 넘기며 단어를 암기하세요.\n넘기기만 해도 외워지는 알고리즘으로 추천해드려요.", x: -65.0),
        OnBoardingContent(img_btm: Image("OnBoarding_2_1"),img_top: Image("OnBoarding_2_2"),title: "직접 만드는 예문과 이미지", contents: "예문을 직접 만들면 단어가 더 잘외워져요.\n보카드가 문법을 확인하고 그에 맞는 이미지를 생성해요.", x: -70.0),
        OnBoardingContent(img_btm: Image("OnBoarding_3_1"),img_top: Image("OnBoarding_3_2"),title: "매일 알람받기", contents: "매일매일 단어를 암기해봐요.\n설정한 시간에 보카드와 만날 수 있게 알려드릴게요.", x: -60.0),
        OnBoardingContent(img_btm: Image("OnBoarding_4_1"),img_top: Image("OnBoarding_4_2"),title: "암기를 확인하는 퀴즈", contents: "카드를 넘기기 전에 퀴즈로 한번 더 확인할 수 있어요.\n모르는 단어를 그냥 넘어가지 않게 막아줘요.", x: -30.0)
    ]
}

struct BeforeLoginView: View {
    @Binding var isLoggedIn: Bool
    let onBoardingList: [OnBoardingContent] = OnBoardingContent.onBoardingList
    
    var body: some View {
            VStack(alignment: .center, spacing: 30, content: {
                Image("text_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 240)
                
                TabView {
                    ForEach(onBoardingList, id: \.id) { onBoarding in
                        OnBoardingView(img_btm:onBoarding.img_btm, img_top: onBoarding.img_top, title: onBoarding.title, contents: onBoarding.contents, value_x: onBoarding.x).padding(.bottom,20)
                    }
                }
                .frame(width: 400,height: 490)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                
                Button(action: {
                    // todo: kakao login 실행 부분 작성
                    tryLogin()
                }, label: {
                    Image("kakao_login_btn")
                        .resizable()
                        .frame(width: 320, height: 50)
                }).padding(.top,10)
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
    let img_btm: Image
    let img_top: Image
    let title: String
    let contents: String
    let value_x: Double
    
    var body: some View {
            VStack(spacing: 14, content: {
                ZStack {
                    img_btm
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400, height: 300)
                        .offset(CGSize(width: 0.0, height: 55.0))
                    img_top
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 520, height: 300)
                        .offset(CGSize(width: value_x, height: 40.0))
                }
                
                Text(title)
                    .fontWeight(.bold)
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: 26.0))
                Text(contents)
                    .foregroundColor(Color("OnboardingTxt"))
                    .font(.system(size: 16.0))
                    .multilineTextAlignment(.center)
            })
        }
}

#Preview {
    LoginView()
}
