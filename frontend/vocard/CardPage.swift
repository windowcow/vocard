//
//  CardPage.swift
//  vocard
//
//  Created by windowcow on 11/27/23.
//

import SwiftUI

@Observable fileprivate class CardPageViewModel {
    var cardViewStatus: CardViewStatus = .back(.detail)
}

struct CardPage: View {
    @State private var vm: CardPageViewModel = CardPageViewModel()
    
    var body: some View {
        VStack {
            CardPage_Top()
            Divider()
            
            Spacer()
            
                .background(.gray)
            CardPage_Middle()
                .environment(vm)
                .padding()

            
            Spacer()

            CardPage_Bottom()
                .environment(vm)
        }
    }
}

struct CardPage_Top: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("TODAY'S STARS")
                Text("123")
                    .fontWeight(.heavy)
            }
            .foregroundStyle(.white)
            
            Spacer()
            
            Button("MENU") {
                
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 15))
            .foregroundStyle(.black)
            .tint(.white)
        }
    }
}

struct CardPage_Middle: View {
    @Environment(CardPageViewModel.self) private var vm
    
    var body: some View {
        CardPage_CardView_CardBackground(cardViewStatus: vm.cardViewStatus)
            .overlay {
                CardPage_CardView_CardForeground()

            }
    }
}

struct CardPage_CardView_CardBackground: View {
    var cardViewStatus: CardViewStatus
    
    var body: some View {
        switch cardViewStatus {
        case .front(let cardFrontStatus):
            switch cardFrontStatus {
            case .middle:
                CardFrontShape()
                    .aspectRatio(0.66, contentMode: .fit)
                    .foregroundStyle(.cardFacedUpBackground)
            default:
                CardFrontShape()
                    .aspectRatio(0.66, contentMode: .fit)
                    .foregroundStyle(.cardFacedDownBackground)

            }
            
            
        case .back(let cardBackStatus):
            switch cardBackStatus {
            case .detail:
                CardBackShape()
                    .aspectRatio(0.66, contentMode: .fit)
                    .foregroundStyle(.cardFacedDownBackground)
            case .quiz:
                CardBackShape()
                    .aspectRatio(0.66, contentMode: .fit)
                    .foregroundStyle(.cardFacedDownBackground)
            }
            
        }
        
    }
}

enum CardView_ComponentPosition {
    case star(CardViewStatus)
    case word(CardViewStatus)
    case definition(CardViewStatus)
    case example(CardViewStatus)
    
    var position: (GeometryProxy) -> CGPoint {
        switch self {
        case .star(let cardViewStatus):
            switch cardViewStatus {
            case .front(let cardFrontStatus):
                switch cardFrontStatus {
                case .left:
                    return { geometryProxy in
                        CGPoint(x: geometryProxy.size.width / 4.5,
                                y: geometryProxy.size.height / 18)
                    }
                case .middle:
                    return { geometryProxy in
                        CGPoint(x: geometryProxy.size.width / 4.5,
                                y: geometryProxy.size.height / 18)
                    }
                case .right:
                    return { geometryProxy in
                        CGPoint(x: geometryProxy.size.width / 4.5,
                                y: geometryProxy.size.height / 18)
                    }
                }
            case .back(let cardBackStatus):
                switch cardBackStatus {
                case .detail:
                    return { geometryProxy in
                        CGPoint(x: geometryProxy.size.width * 3.5 / 4.5,
                                y: geometryProxy.size.height / 18)
                    }
                case .quiz:
                    return { geometryProxy in
                        CGPoint(x: geometryProxy.size.width * 3.5 / 4.5,
                                y: geometryProxy.size.height / 18)
                    }
                }
            }
        case .word(let cardViewStatus):
            switch cardViewStatus {
            case .front(_):
                return { geometryProxy in
                    CGPoint(x: geometryProxy.size.width / 2,
                            y: geometryProxy.size.height / 2)
                }
            case .back(let cardBackStatus):
                switch cardBackStatus {
                case .detail:
                    return { geometryProxy in
                        CGPoint(x: geometryProxy.size.width * 3.5 / 4.5,
                                y: geometryProxy.size.height / 18)
                    }
                case .quiz:
                    return { geometryProxy in
                        CGPoint(x: geometryProxy.size.width * 3.5 / 4.5,
                                y: geometryProxy.size.height / 18)
                    }
                }
            }
        case .definition(_):
            return { geometryProxy in
                CGPoint(x: geometryProxy.size.width / 4.5,
                        y: geometryProxy.size.height / 18)
            }
        case .example(_):
            return { geometryProxy in
                CGPoint(x: geometryProxy.size.width / 4.5,
                        y: geometryProxy.size.height / 18)
            }
//        case .definition(let cardViewS)
        }
    }
}

struct CardPage_CardView_CardForeground: View {
    @Environment(CardPageViewModel.self) private var vm

    var body: some View {
        switch vm.cardViewStatus {
        case .front(let cardFrontStatus):
            switch cardFrontStatus {
            case .middle:
                CardPage_CardView_CardForeground_CardFront_Middle()
            case .left:
                CardPage_CardView_CardForeground_CardFront_Left()
            case .right:
                CardPage_CardView_CardForeground_CardFront_Right()
            }
        case .back(let cardBackStatus):
            switch cardBackStatus {
            case .detail:
                CardPage_CardView_CardForeground_CardDetail()
            case .quiz:
                CardPage_CardView_CardForeground_CardQuiz()
            }
        }
    }
}

struct CardPage_CardView_CardForeground_CardFront_Middle: View {
    let word: String = "Consecutive"
    let stars: String = "★★★★★"

    var body: some View {
        GeometryReader {
            Text(stars)
                .position(CardView_ComponentPosition.star(.front(.middle)).position($0))
            Text(word)
                .position(x: $0.size.width / 2, y: $0.size.height / 2)

        }
    }
}

struct CardPage_CardView_CardForeground_CardFront_Left: View {
    var body: some View {
        GeometryReader {
            
            Text("DETAIL")
                .foregroundStyle(.white)

                .position(x: $0.size.width / 2, y: $0.size.height / 2)
                .rotation3DEffect(
                    .degrees(180),
                                          
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )

        }
    }
}

struct CardPage_CardView_CardForeground_CardFront_Right: View {
    var body: some View {
        GeometryReader {
            
            Text("QUIZ")
                .foregroundStyle(.white)
                .position(x: $0.size.width / 2, y: $0.size.height / 2)
                .rotation3DEffect(
                    .degrees(180),
                                          
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
        }
    }
}

struct CardPage_CardView_CardForeground_CardDetail: View {
    let stars: String = "★★★★★"
    let word = "Conversation"
    let definition = "aafwefwefwf wf wefew fwef wef"
    let image = "SampleImage"
    let exampleSentence = "I like having conversation with my friend."
    
    var body: some View {
        GeometryReader { g in
            Text(stars)
                .position(CardView_ComponentPosition.star(.back(.detail)).position(g))
            VStack {
                Text(word)
                    .font(.largeTitle)
                
                Text(definition)
                    
                    .frame(width: g.size.width * 0.9)
                    .padding(.vertical)
                    .background(.cardBackInside,
                                in: .rect(cornerRadius: 5))
                    .padding(.horizontal)

                    
                
                VStack {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: g.size.width * 0.65)
                    Text(exampleSentence)
                }
                .padding()
                .frame(width: g.size.width * 0.9)

                .background(.cardBackInside, in: .rect(cornerRadius: 5))

                    
                
                
                Spacer()
            }
            .frame(height: g.size.height * 0.9)
            .frame(maxWidth: .infinity)
            .position(x: g.size.width / 2,
                      y: g.size.height * 0.6
            )
            
            
        }
        .foregroundStyle(.white)

    }
}

struct CardPage_CardView_CardForeground_CardQuiz: View {
    var body: some View {
        ZStack {
            
        }
    }
}


struct CardPage_Bottom: View {
    @Environment(CardPageViewModel.self) private var vm

    var body: some View {
        switch vm.cardViewStatus {
        case .front(_):
            EmptyView()
        case .back(.detail):
            Button {
                
            } label: {
                Text("NEXT")
                    .foregroundStyle(.white)
                    .frame(width: 330, height: 63, alignment: .center)
                    .background(.cardFacedDownBackground, in: NextButtonShape())

            }
            .buttonStyle(.plain)
        case .back(.quiz):
            HStack(spacing: 23) {
                Button {
                    
                } label: {
                    
                    Text("PASS")
                        .foregroundStyle(.white)
                        .frame(width: 107, height: 63, alignment: .center)
                        .background(.cardFacedDownBackground, in: PassButtonShape())
                }
                Button {
                    
                    
                    
                } label: {
                    Text("SUBMIT")
                        .foregroundStyle(.black)
                        .frame(width: 200, height: 63, alignment: .center)
                        .background(.quizSubmitButton, in: NextButtonShape())
                }
            }
        }
        
        
    }
}


#Preview {
    CardPage()
        .background(.black)
}
