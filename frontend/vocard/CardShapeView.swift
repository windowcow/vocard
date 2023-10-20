//
//  CardShapeView.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI

struct CardShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.13201*height))
        path.addCurve(to: CGPoint(x: 0.05917*width, y: 0.09584*height), control1: CGPoint(x: 0, y: 0.11203*height), control2: CGPoint(x: 0.02649*width, y: 0.09584*height))
        path.addLine(to: CGPoint(x: 0.94083*width, y: 0.09584*height))
        path.addCurve(to: CGPoint(x: width, y: 0.13201*height), control1: CGPoint(x: 0.97351*width, y: 0.09584*height), control2: CGPoint(x: width, y: 0.11203*height))
        path.addLine(to: CGPoint(x: width, y: 0.96383*height))
        path.addCurve(to: CGPoint(x: 0.94083*width, y: height), control1: CGPoint(x: width, y: 0.98381*height), control2: CGPoint(x: 0.97351*width, y: height))
        path.addLine(to: CGPoint(x: 0.05917*width, y: height))
        path.addCurve(to: CGPoint(x: 0, y: 0.96383*height), control1: CGPoint(x: 0.02649*width, y: height), control2: CGPoint(x: 0, y: 0.98381*height))
        path.addLine(to: CGPoint(x: 0, y: 0.13201*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0, y: 0.03617*height))
        path.addCurve(to: CGPoint(x: 0.05917*width, y: 0), control1: CGPoint(x: 0, y: 0.01619*height), control2: CGPoint(x: 0.02649*width, y: 0))
        path.addLine(to: CGPoint(x: 0.41124*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.47041*width, y: 0.03617*height), control1: CGPoint(x: 0.44392*width, y: 0), control2: CGPoint(x: 0.47041*width, y: 0.01619*height))
        path.addLine(to: CGPoint(x: 0.47041*width, y: 0.46474*height))
        path.addCurve(to: CGPoint(x: 0.41124*width, y: 0.5009*height), control1: CGPoint(x: 0.47041*width, y: 0.48471*height), control2: CGPoint(x: 0.44392*width, y: 0.5009*height))
        path.addLine(to: CGPoint(x: 0.05917*width, y: 0.5009*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.46474*height), control1: CGPoint(x: 0.02649*width, y: 0.5009*height), control2: CGPoint(x: 0, y: 0.48471*height))
        path.addLine(to: CGPoint(x: 0, y: 0.03617*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.45858*width, y: 0.01447*height))
        path.addLine(to: CGPoint(x: 0.56805*width, y: 0.08116*height))
        path.addCurve(to: CGPoint(x: 0.63314*width, y: 0.09584*height), control1: CGPoint(x: 0.58876*width, y: 0.09584*height), control2: CGPoint(x: 0.62081*width, y: 0.09704*height))
        path.addLine(to: CGPoint(x: 0.63314*width, y: 0.12839*height))
        path.addLine(to: CGPoint(x: 0.45266*width, y: 0.12839*height))
        path.addLine(to: CGPoint(x: 0.45858*width, y: 0.01447*height))
        path.closeSubpath()
        return path
    }
}

struct CardShapeView: View {
    var body: some View {
        ZStack {
            CardShape()
                .aspectRatio(contentMode: .fill)
                .padding()
        }
        .background(.red)
        
    }
}

#Preview {
    CardShapeView()
}
