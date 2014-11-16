//
//  ViewController.swift
//  BasicAnimation
//
//  Created by Zhou Hao on 16/11/14.
//  Copyright (c) 2014年 Zhou Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: UIView!

    var shapePath : UIBezierPath = {

        var polygonPath = UIBezierPath()
        polygonPath.moveToPoint(CGPointMake(120, 25))
        polygonPath.addLineToPoint(CGPointMake(171.96, 115))
        polygonPath.addLineToPoint(CGPointMake(68.04, 115))
        polygonPath.closePath()
        
        return polygonPath

/*
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(84.5, 26.5))
        bezierPath.addCurveToPoint(CGPointMake(53.5, 50.5), controlPoint1: CGPointMake(61.5, 44.5), controlPoint2: CGPointMake(53.5, 50.5))
        bezierPath.addLineToPoint(CGPointMake(53.5, 65.5))
        bezierPath.addLineToPoint(CGPointMake(102.5, 81.5))
        bezierPath.addLineToPoint(CGPointMake(141.5, 65.5))
        bezierPath.addLineToPoint(CGPointMake(157.5, 41.5))
        bezierPath.addLineToPoint(CGPointMake(120.5, 47.5))
        bezierPath.addCurveToPoint(CGPointMake(84.5, 26.5), controlPoint1: CGPointMake(120.5, 47.5), controlPoint2: CGPointMake(107.5, 8.5))
        bezierPath.closePath()
        
        return bezierPath
*/
/*
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(50.64, 41.93))
        bezierPath.addCurveToPoint(CGPointMake(50.64, 56.07), controlPoint1: CGPointMake(47.12, 45.83), controlPoint2: CGPointMake(47.12, 52.17))
        bezierPath.addCurveToPoint(CGPointMake(63.36, 56.07), controlPoint1: CGPointMake(54.15, 59.98), controlPoint2: CGPointMake(59.85, 59.98))
        bezierPath.addCurveToPoint(CGPointMake(63.36, 41.93), controlPoint1: CGPointMake(66.88, 52.17), controlPoint2: CGPointMake(66.88, 45.83))
        bezierPath.addCurveToPoint(CGPointMake(50.64, 41.93), controlPoint1: CGPointMake(59.85, 38.02), controlPoint2: CGPointMake(54.15, 38.02))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPointMake(80, 27))
        bezierPath.addCurveToPoint(CGPointMake(80, 71), controlPoint1: CGPointMake(80, 27), controlPoint2: CGPointMake(80, 71))
        bezierPath.addLineToPoint(CGPointMake(35, 71))
        bezierPath.addLineToPoint(CGPointMake(35, 27))
        bezierPath.addLineToPoint(CGPointMake(80, 27))
        bezierPath.addLineToPoint(CGPointMake(80, 27))
        bezierPath.closePath()

        return bezierPath 
*/
    }()

    
    var animationLayer: CAShapeLayer! = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.animationLayer.path = shapePath.CGPath
        
        self.animationLayer.fillColor = nil
        self.animationLayer.strokeColor = UIColor.blackColor().CGColor
        self.animationLayer.lineWidth = 4
        self.animationLayer.miterLimit = 4
        self.animationLayer.lineCap = kCALineCapRound
        self.animationLayer.masksToBounds = true
        
        // very important, otherwise the stroke will not be shown
        let strokingPath = CGPathCreateCopyByStrokingPath(self.animationLayer.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4)
        self.animationLayer.bounds = CGPathGetPathBoundingBox(strokingPath)

        // don't show it yet
        self.animationLayer.strokeStart = 0
        self.animationLayer.strokeEnd = 0
        
        self.canvasView.layer.addSublayer(self.animationLayer)
    }

    override func viewDidAppear(animated: Bool) {
        
        // to setup the position here because the bounds of views may not be correct in viewDidLoad
        let w = self.canvasView.bounds.width/2.0
        self.animationLayer.anchorPoint = CGPointMake(0.5, 0.5)  // setup coordinate origin
        self.animationLayer.position = CGPointMake(w,w)         // setup origin
        
    }
    
    @IBAction func onAnimation(sender: AnyObject) {
        let stroke = CABasicAnimation(keyPath: "strokeEnd")
  
        stroke.fromValue = 0
        stroke.toValue = 1
        stroke.duration = 1.2
        stroke.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        self.animationLayer.addAnimation(stroke, forKey: "strokeEnd")
        self.animationLayer.strokeEnd = 1 // to keep it on screen
    }
}
