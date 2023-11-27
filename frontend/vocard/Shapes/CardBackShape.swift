//
//  CardBackShape.swift
//  vocard
//
//  Created by windowcow on 10/27/23.
//

import SwiftUI

struct CardBackShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: width, y: 0.13362*height))
        path.addCurve(to: CGPoint(x: 0.93939*width, y: 0.09665*height), control1: CGPoint(x: width, y: 0.11321*height), control2: CGPoint(x: 0.97287*width, y: 0.09665*height))
        path.addLine(to: CGPoint(x: 0.06061*width, y: 0.09665*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.13362*height), control1: CGPoint(x: 0.02713*width, y: 0.09665*height), control2: CGPoint(x: 0, y: 0.11321*height))
        path.addLine(to: CGPoint(x: 0, y: 0.96203*height))
        path.addCurve(to: CGPoint(x: 0.06061*width, y: 0.99899*height), control1: CGPoint(x: 0, y: 0.98244*height), control2: CGPoint(x: 0.02713*width, y: 0.99899*height))
        path.addLine(to: CGPoint(x: 0.93939*width, y: 0.99899*height))
        path.addCurve(to: CGPoint(x: width, y: 0.96203*height), control1: CGPoint(x: 0.97287*width, y: 0.99899*height), control2: CGPoint(x: width, y: 0.98244*height))
        path.addLine(to: CGPoint(x: width, y: 0.13362*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: width, y: 0.03797*height))
        path.addCurve(to: CGPoint(x: 0.93939*width, y: 0.00101*height), control1: CGPoint(x: width, y: 0.01756*height), control2: CGPoint(x: 0.97287*width, y: 0.00101*height))
        path.addLine(to: CGPoint(x: 0.59019*width, y: 0.00101*height))
        path.addCurve(to: CGPoint(x: 0.52958*width, y: 0.03797*height), control1: CGPoint(x: 0.55672*width, y: 0.00101*height), control2: CGPoint(x: 0.52958*width, y: 0.01756*height))
        path.addLine(to: CGPoint(x: 0.52958*width, y: 0.46393*height))
        path.addCurve(to: CGPoint(x: 0.59019*width, y: 0.5009*height), control1: CGPoint(x: 0.52958*width, y: 0.48435*height), control2: CGPoint(x: 0.55672*width, y: 0.5009*height))
        path.addLine(to: CGPoint(x: 0.93939*width, y: 0.5009*height))
        path.addCurve(to: CGPoint(x: width, y: 0.46393*height), control1: CGPoint(x: 0.97287*width, y: 0.5009*height), control2: CGPoint(x: width, y: 0.48435*height))
        path.addLine(to: CGPoint(x: width, y: 0.03797*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.54142*width, y: 0.01544*height))
        path.addLine(to: CGPoint(x: 0.43195*width, y: 0.082*height))
        path.addCurve(to: CGPoint(x: 0.36686*width, y: 0.09665*height), control1: CGPoint(x: 0.41124*width, y: 0.09665*height), control2: CGPoint(x: 0.37919*width, y: 0.09785*height))
        path.addLine(to: CGPoint(x: 0.36686*width, y: 0.12914*height))
        path.addLine(to: CGPoint(x: 0.54734*width, y: 0.12914*height))
        path.addLine(to: CGPoint(x: 0.54142*width, y: 0.01544*height))
        path.closeSubpath()
        return path
    }
}


struct CardShape: View {
    var side: CardSide
    
    var body: some View {
        if side == .front {
            CardFrontShape()
        } else {
            CardBackShape()
        }
    }
}

#Preview {
    CardBackShape()
}
