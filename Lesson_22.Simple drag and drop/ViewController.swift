//
//  ViewController.swift
//  Lesson_22.Simple drag and drop
//
//  Created by Aleksandr Kan on 11.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private weak var dragginView: UIView?
    private var touchOffSet = CGPoint()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        for i in 0...7 {
            let view_01 = UIView(frame: CGRect(x: 110 * i + 10, y: 100, width: 100, height: 100))
            view_01.backgroundColor = randomColor()
            view.addSubview(view_01)
        }
        
        //view.isMultipleTouchEnabled = true
    }

    private func randomColor() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0.0...1.0), green: CGFloat.random(in: 0.0...1.0), blue: CGFloat.random(in: 0.0...1.0), alpha: 1.0)
    }
    
    func logTouches(_ touches: Set<UITouch>, with method: String) {
        var string = "\(method)"
        for touch in touches {
            let point = touch.location(in: view)
            string.append(" \(point)")
        }
        
        print(string)
    }

    //MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.logTouches(touches, with: "touchesBegan")
        let touch = touches.randomElement()
        let pointOnMainView = touch?.location(in: view)
        let testView = view.hitTest(pointOnMainView!, with: event)
        
        if !(testView!.isEqual(view)) {
            dragginView = testView!
            view.bringSubviewToFront(dragginView!)
            let touchPoint = touch!.location(in: dragginView)
            touchOffSet = CGPoint(x: dragginView!.bounds.midX - touchPoint.x, y: dragginView!.bounds.midY - touchPoint.y)
            
            //dragginView?.layer.removeAllAnimations()
            UIView.animate(withDuration: 0.3) {
                self.dragginView!.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self.dragginView!.alpha = 0.3
            }
        } else {
            //dragginView = nil
        }
        
        //print("\(testView.point(inside: point!, with: event))")
        
        //print("touchesBegan")
    }
    
    private func onTouchesEnded() {
        //dragginView = nil
        UIView.animate(withDuration: 0.3) {
            self.dragginView!.transform = CGAffineTransform.identity
            self.dragginView!.alpha = 1
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.logTouches(touches, with: "touchesEnded")
        //print("touchesEnded")
        onTouchesEnded()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.logTouches(touches, with: "touchesMoved")
        
        if dragginView != nil {
            let touch = touches.randomElement()
            let pointOnMainView = touch?.location(in: view)
            let correction = CGPoint(x: pointOnMainView!.x + touchOffSet.x, y: pointOnMainView!.y + touchOffSet.y)
            
            
            
            dragginView!.center = correction
        }
        
        
        //print("touchesMoved")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.logTouches(touches, with: "touchesCancelled")
        //print("touchesCancelleD")
    }
    
    
    
}

