//
//  HomeView.swift
//  vocard
//
//  Created by 조예현 on 2023/10/25.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ZStack{
            Color("MainBgr")
                .ignoresSafeArea()
            VStack {
                HeaderView()
                WordCountView()
                WordCountChartView()
                Spacer(minLength: 20)
                StartStudyView()
                Spacer(minLength: 30)
                HistoryBtnView()
            }
            
        }
    }
}

struct HeaderView: View {
    @State var isMyPagePresented: Bool = false
    
    var body: some View {
        HStack {
            Image("icon_logo")
            Spacer()
            Button {
                isMyPagePresented.toggle()
            } label: {
                Text("My Page")
                    .font(.system(size: 16.0))
                    .foregroundColor(.white)
                    .padding(11)
            }
            .sheet(isPresented: $isMyPagePresented) {
                MyPageView()
            }
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Alarm")
                    .font(.system(size: 16.0))
                    .foregroundColor(.white)
                    .padding(11)
            })
        }
        .padding(.bottom, 25)
        .padding(.top, 5)
        .padding(.horizontal, 30)
    }
}

struct WordCountView: View {
    var body: some View {
        VStack(alignment:.leading, content: {
            HStack(content: {
                Text("WORD COUNT")
                    .foregroundColor(.white)
                    .bold()
                    .font(.system(size: 16.0))
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(.white)
                Text("NEW")
                    .foregroundColor(.white)
                    .font(.system(size: 14.0))
            })
            Text("0")
                .bold()
                .foregroundColor(.white)
                .font(.system(size: 64.0))
        })
        .padding(.horizontal, 30)
    }
}


struct WordCountChartView: View {
    var body: some View {
        // 차트 코드
        Text("날짜 별 공부한 단어 그래프 올 자리").foregroundColor(.white)
    }
}


struct StartStudyView: View {
    @State private var cardStudyViewPresented: Bool = false
    var body: some View {
        VStack(alignment:.leading, spacing: 0, content: {
            // 다음에 학습할 단어 올 부분
            
            ZStack(alignment:.leading, content: {
                Image("index")
                Text("다음 단어")
                    .font(.system(size: 18.0))
                    .padding(.leading, 45)
                    .padding(.top, 5)
            })
            
            VStack(content: {
                Text("conversation")
                    .font(.system(size: 30.0))
                    .bold()
                    .padding(.vertical, 40)
                
                Button {
                    cardStudyViewPresented.toggle()
                } label: {
                    Text("시작하기")
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 110)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("BlackTxt"))
                        )
                    
                }
                .fullScreenCover(isPresented: $cardStudyViewPresented) {
                    CardStudyView()
                }
            })
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(
                CardBottomRectangle(cornerRadius: 20)
                    .fill(Color("tmpCardBgr"))
            )
        })
        
    }
}

struct HistoryBtnView: View {
    var body: some View {
        VStack(alignment:.leading, content: {
        
            Text("단어 기록")
                .font(.system(size: 18.0))
                .padding(.bottom, 20)
                .padding(.leading, 20)
            
            Button(action: {
                // 기록 페이지로 이동
            }, label: {
                Text("복습하기")
                    .font(.system(size: 16.0))
                    .foregroundColor(Color("BlackTxt"))
                    .padding()
                    .padding(.horizontal, 110)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("BlackTxt"), lineWidth: 3)
                            .fill(Color("HistoryBgr"))
                    )
            })
            
            Spacer()
        })
        .padding(.horizontal, 20)
        .padding(.top, 25)
        .background(
        TopRoundedRectangle(radius: 20)
            .fill(Color("HistoryBgr"))
        )
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct TopRoundedRectangle: Shape {
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.addQuadCurve(to: CGPoint(x: rect.minX + radius, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + radius), control: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        return path
    }
}


struct CardBottomRectangle: Shape {
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
        
        return path
    }
}



#Preview {
    HomeView()
}
