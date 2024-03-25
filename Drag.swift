//
//  Drag.swift
//  NCX Draft
//
//  Created by Claudio Marciello on 23/03/24.
//

import UIKit

class Drag: UIGestureRecognizer {
    var lastLocation = CGPoint.zero

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let view = touch.view else { return }
        lastLocation = view.center
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let view = touch.view else { return }
        let location = touch.location(in: self.view)
        view.center = CGPoint(x: lastLocation.x + location.x - view.bounds.midX,
                              y: lastLocation.y + location.y - view.bounds.midY)
    }
}
