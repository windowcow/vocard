//
//  CardPage.swift
//  vocard
//
//  Created by windowcow on 11/27/23.
//

import SwiftUI

@Observable class CardPageViewModel {
    var cardViewStatus: CardViewStatus = .front(.middle)
}

struct CardPage: View {
    @Environment(CardPageViewModel.self) var vm
    
    var body: some View {
        VStack {
            CardPage_Top()
            Divider()
            
            Spacer()
            
                .background(.gray)
            CardPage_Middle()
                .padding()

            
            Spacer()

            CardPage_Bottom()
        }
        .background(.black)
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
        .padding(.horizontal)
    }
}

struct CardPage_Middle: View {
    @Environment(CardPageViewModel.self) private var vm
    
    var body: some View {
        ViewThatFits {
            CardPage_CardView_CardBackground(cardViewStatus: vm.cardViewStatus)
                .overlay {
                    CardPage_CardView_CardForeground()

                }
        }
        .cardDrag(vm)


    }
}

struct CardPage_CardView_CardBackground: View {
    @Environment(CardPageViewModel.self) private var vm
    
    var cardViewStatus: CardViewStatus
    
    var body: some View {
        switch vm.cardViewStatus {
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

extension View {
    func cardDrag(_ vm: CardPageViewModel) -> some View {
        self
            .modifier(CardMovement(vm: vm))
    }
}


struct CardMovement: ViewModifier {
    @Bindable var vm: CardPageViewModel
    @GestureState var offsetState: CGSize = .zero

    func body(content: Content) -> some View {
        switch vm.cardViewStatus {
        case .front:
            content
                .visualEffect { (content, geometryProxy)  in
                    content
                        .offset(offsetState.applying(.init(scaleX: -1, y: 1)))
                        .rotation3DEffect(
                            .degrees(offsetState.width),
                            axis: (x: 0.0, y: 1.0, z: 0.0)
//                            anchor: offsetState.width > 0 ? .trailing : .leading
                        )
                        .scaleEffect((200 - offsetState.width.magnitude) / 200 < 0.5 ? 0.5 : (200 - offsetState.width.magnitude) / 200)
                }
                .animation(.spring.speed(2), value: offsetState)
                .gesture(
                    DragGesture()
                        .updating($offsetState) { value, state, t in
                            withAnimation {
                                state = value.translation

                                switch state.width {
                                case let x where CardMovementLocation.left.range ~= x:
                                    vm.cardViewStatus = .front(.left)
                                case let x where CardMovementLocation.right.range ~= x:
                                    vm.cardViewStatus = .front(.right)
                                default:
                                    vm.cardViewStatus = .front(.middle)
                                }
                            }
                            
                        }
                        .onEnded { value in
                            withAnimation {
                                switch value.translation.width {
                                case let x where CardMovementLocation.center.range ~= x:
                                    vm.cardViewStatus = .front(.middle)
                                case let x where CardMovementLocation.left.range ~= x:
                                    vm.cardViewStatus = .back(.detail)
                                case let x where CardMovementLocation.right.range ~= x:
                                    vm.cardViewStatus = .back(.quiz)
                                default:
                                    vm.cardViewStatus = .front(.middle)
                                    print("123")
                                }
                            }
                        }
                )
        case .back:
            content
        }
        
    }
}
#Preview {
    CardPage()
        .background(.black)
}
