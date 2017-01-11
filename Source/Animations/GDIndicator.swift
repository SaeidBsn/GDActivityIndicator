//
//  DotCircularIndicator.swift
//  GDActivityIndicator
//
//  Created by Saeid Basirnia on 4/22/16.
//  Copyright © 2016 Saeidbsn. All rights reserved.
//

import UIKit

class GDCircularDotsBlinking: UIView{
    var circleRadius: CGFloat = 5.0
    var circleSpace: CGFloat = 7
    var animDuration: CFTimeInterval = 0.7
    var shapeCol: UIColor = UIColor.black
    var circleCount: Int = 5
    var colCount: Int = 0
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupView()
    }
    
    /*!
     - parameters:
        - cRadius: radius of circles
        - cSpace:  space between each circle
        - aDuration: animation duration
        - shapeColor: color of circles
        - cCount: number of circles in a row
        - colCount: number of columns
     */
    init(frame: CGRect, cRadius: CGFloat, cSpace: CGFloat, aDuration: CFTimeInterval, shapeColor: UIColor, cCount: Int, colCount: Int) {
        super.init(frame: frame)
        
        self.circleRadius = cRadius
        self.circleSpace = cSpace
        self.animDuration = aDuration
        self.shapeCol = shapeColor
        self.circleCount = cCount
        self.colCount = colCount
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView(){
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        self.circularDotsIndicator()
    }
    
    func circularDotsIndicator(){
        //Setting properties
        let circleStart: CGFloat = 0.0
        let circleEnd: CGFloat = CGFloat(M_PI * 2)
        let animTime = CACurrentMediaTime()
        let animTimes = [0.0, 0.5, 0.8, 1, 1.2, 1.26, 1.4, 1.6, 1.9, 2.1, 2.4, 2.8]
        
        //Create Circle bezier path
        let path = UIBezierPath(arcCenter: CGPoint.zero, radius: circleRadius, startAngle: circleStart, endAngle: circleEnd, clockwise: true)
        
        //Calculate position of circles
        let size = (2 * circleRadius) * CGFloat(circleCount / 2)
        let x = (frame.width) / 2 - size
        let y = frame.height / 2
        
        //Add animations
        //Fade animation
        let fadeAnim = CABasicAnimation(keyPath: "opacity")
        fadeAnim.fromValue = 0.5
        fadeAnim.toValue = 1.0
        fadeAnim.duration = animDuration
        
        //X animation scale
        let xAnim = CAKeyframeAnimation(keyPath: "transform.scale.x")
        xAnim.values = [0.7, 1, 0.7]
        xAnim.keyTimes = [0.3, 0.6, 1]
        
        //Y animation scale
        let yAnim = CAKeyframeAnimation(keyPath: "transform.scale.y")
        yAnim.values = [0.7, 1, 0.7]
        yAnim.keyTimes = [0.3, 0.6, 1]
        
        let groupAnim = CAAnimationGroup()
        groupAnim.duration = animDuration
        groupAnim.isRemovedOnCompletion = false
        groupAnim.repeatCount = HUGE
        groupAnim.animations = [fadeAnim, xAnim, yAnim]
        
        //Create n shapes with animations
        if colCount != 0{
            for i in 0..<circleCount{
                for j in 0..<colCount{
                    //Create Shape for path
                    let shapeToAdd = CAShapeLayer()
                    shapeToAdd.fillColor = shapeCol.cgColor
                    shapeToAdd.strokeColor = nil
                    shapeToAdd.path = path.cgPath
                    
                    let frame = CGRect(
                        x: (x + circleRadius * CGFloat(i) + circleSpace * CGFloat(i)),
                        y: (y + circleRadius * CGFloat(j) + circleSpace * CGFloat(j)),
                        width: circleRadius,
                        height: circleRadius)
                    shapeToAdd.frame = frame
                    
                    groupAnim.beginTime = animTime + animTimes[i]
                    
                    layer.addSublayer(shapeToAdd)
                    shapeToAdd.add(groupAnim, forKey: "circularDotsIndicator")
                }
            }
        }else{
            for i in 0..<circleCount{
                //Create Shape for path
                let shapeToAdd = CAShapeLayer()
                shapeToAdd.fillColor = shapeCol.cgColor
                shapeToAdd.strokeColor = nil
                shapeToAdd.path = path.cgPath
                
                let frame = CGRect(
                    x: (x + circleRadius * CGFloat(i) + circleSpace * CGFloat(i)),
                    y: y,
                    width: circleRadius,
                    height: circleRadius)
                shapeToAdd.frame = frame
                
                groupAnim.beginTime = animTime + animTimes[i]
                
                layer.addSublayer(shapeToAdd)
                shapeToAdd.add(groupAnim, forKey: "circularDotsIndicator")
            }
        }
    }
}

class GDCircularDotsRotating: UIView{
    var circleRadius: CGFloat = 8.0
    var circleSpace: CGFloat = 30
    var animDuration: CFTimeInterval = 3
    var topLeftCircleColor: UIColor = UIColor.white
    var topRightCircleColor: UIColor = UIColor.black
    var bottomLeftCircleColor: UIColor = UIColor.black
    var bottomRightCircleColor: UIColor = UIColor.white
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    /**
     - parameters:
        - parameter cRadius: radius of circles
        - parameter cSpace: space between circles
        - parameter aDuration: duration of each interval of animation
        - parameter topLeftColor: top-left circle color
        - parameter topRightColor: top-right circle color
        - parameter bottomLeftColor: bottom-left circle color
        - parameter bottomRightColor: bottom-right circle color
     */
    init(frame: CGRect, cRadius: CGFloat, cSpace: CGFloat, aDuration: CFTimeInterval, topLeftColor: UIColor, topRightColor: UIColor, bottomLeftColor: UIColor, bottomRightColor: UIColor){
        super.init(frame: frame)
        
        self.circleRadius = cRadius
        self.circleSpace = cSpace
        self.animDuration = aDuration
        self.topLeftCircleColor = topLeftColor
        self.topRightCircleColor = topRightColor
        self.bottomLeftCircleColor = bottomLeftColor
        self.bottomRightCircleColor = bottomRightColor
        
        self.setupView()
    }
    
    func setupView(){
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        self.circularDotsRotatingIndicator()
    }
    
    func circularDotsRotatingIndicator(){
        //Setting properties
        let circleStart: CGFloat = 0.0
        let circleEnd: CGFloat = CGFloat(M_PI * 2)
        let animTime = CACurrentMediaTime()
        
        //Calculate possition for each circle in different directions
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let topLeft = CGPoint(x: center.x - circleSpace, y: center.y - circleSpace)
        let topRight = CGPoint(x: center.x + circleSpace, y: center.y - circleSpace)
        let bottomLeft = CGPoint(x: center.x - circleSpace , y: center.y + circleSpace)
        let bottomRight = CGPoint(x: center.x + circleSpace , y: center.y + circleSpace)
        let circleSize = CGSize(width: circleRadius, height: circleRadius)
        
        let lineWidth: CGFloat = 3.0
        let timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        
        //Create Circle bezier path
        let path = UIBezierPath(arcCenter: CGPoint.zero, radius: circleRadius, startAngle: circleStart, endAngle: circleEnd, clockwise: true)
        
        //Top Left circle shape
        let topLeftCircle = CAShapeLayer()
        topLeftCircle.fillColor = topLeftCircleColor.cgColor
        topLeftCircle.strokeColor = topLeftCircleColor.cgColor
        topLeftCircle.strokeStart = 0.0
        topLeftCircle.strokeEnd = 1.0
        topLeftCircle.lineWidth = lineWidth
        topLeftCircle.path = path.cgPath
        topLeftCircle.frame = CGRect(origin: topLeft, size: circleSize)
        
        layer.addSublayer(topLeftCircle)
        
        //Top right circle shape
        let topRightCircle = CAShapeLayer()
        topRightCircle.fillColor = topRightCircleColor.cgColor
        topRightCircle.strokeColor = topRightCircleColor.cgColor
        topRightCircle.strokeStart = 0.0
        topRightCircle.strokeEnd = 1.0
        topRightCircle.lineWidth = lineWidth
        topRightCircle.path = path.cgPath
        topRightCircle.frame = CGRect(origin: topRight, size: circleSize)
        
        layer.addSublayer(topRightCircle)
        
        //bottom Left circle shape
        let bottomLeftCircle = CAShapeLayer()
        bottomLeftCircle.fillColor = bottomLeftCircleColor.cgColor
        bottomLeftCircle.strokeColor = bottomLeftCircleColor.cgColor
        bottomLeftCircle.strokeStart = 0.0
        bottomLeftCircle.strokeEnd = 1.0
        bottomLeftCircle.lineWidth = lineWidth
        bottomLeftCircle.path = path.cgPath
        bottomLeftCircle.frame = CGRect(origin: bottomLeft, size: circleSize)
        
        layer.addSublayer(bottomLeftCircle)
        
        //bottom right circle shape
        let bottomRightCircle = CAShapeLayer()
        bottomRightCircle.fillColor = bottomRightCircleColor.cgColor
        bottomRightCircle.strokeColor = bottomRightCircleColor.cgColor
        bottomRightCircle.strokeStart = 0.0
        bottomRightCircle.strokeEnd = 1.0
        bottomRightCircle.lineWidth = lineWidth
        bottomRightCircle.path = path.cgPath
        bottomRightCircle.frame = CGRect(origin: bottomRight, size: circleSize)
        
        layer.addSublayer(bottomRightCircle)
        
        //Rotate animation
        let rotateAnim = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnim.values = [0, M_PI , M_PI * 2]
        rotateAnim.keyTimes = [0.0, 0.4, 1]
        rotateAnim.repeatCount = HUGE
        rotateAnim.duration = animDuration / 2
        rotateAnim.isRemovedOnCompletion = false
        rotateAnim.timingFunctions = [timingFunction, timingFunction, timingFunction]
        
        layer.add(rotateAnim, forKey: nil)
        
        //Translate position animation
        let transAnim = CAKeyframeAnimation(keyPath: "position")
        transAnim.duration = animDuration
        transAnim.keyTimes = [0.0, 0.3, 0.5, 0.7, 1]
        transAnim.isRemovedOnCompletion = false
        transAnim.timingFunctions = [timingFunction, timingFunction, timingFunction, timingFunction]
        transAnim.repeatCount = HUGE
        
        func setTransisionValues(_ shapeToAdd: CAShapeLayer, values: [CGPoint]){
            transAnim.values = [NSValue(cgPoint: values[0]), NSValue(cgPoint: values[1]), NSValue(cgPoint: values[2]), NSValue(cgPoint: values[3]), NSValue(cgPoint: values[4])]
            shapeToAdd.add(transAnim, forKey: "circularDotsRotatingIndicator")
        }
        
        setTransisionValues(topLeftCircle, values: [topLeft, center, bottomRight, center, topLeft])
        setTransisionValues(topRightCircle, values: [topRight, center, bottomLeft, center, topRight])
        setTransisionValues(bottomLeftCircle, values: [bottomLeft, center, topRight, center, bottomLeft])
        setTransisionValues(bottomRightCircle, values: [bottomRight, center, topLeft, center, bottomRight])
    }
}

class GDCircularDotsChain: UIView{
    //MARK: - default variables
    var circleRadius: CGFloat = 5.0
    var radiusMultiplier: CGFloat = 5
    var animDuration: CFTimeInterval = 2.0
    var isRotating: Bool = true
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupView()
    }
    
    /**
     - parameters:
        - cRadius: circle radius and circles size
        - rMultiplier: radius of the rotation path. bigger values means bigger rotation area
        - aDuration: duration of a full rotation
        - isRotateOn: should the loading bar roate itself
     */
    init(frame: CGRect, cRadius: CGFloat, rMultiplier: CGFloat, aDuration: CFTimeInterval, isRotateOn: Bool){
        super.init(frame: frame)
        
        self.isRotating = isRotateOn
        self.circleRadius = cRadius
        self.radiusMultiplier = rMultiplier
        self.animDuration = aDuration

        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView(){
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        self.circularDotsRotatingChain()
    }

    func circularDotsRotatingChain(){
        var circleShape: CAShapeLayer!
        let circleStart: CGFloat = 0.0
        let circleEnd: CGFloat = CGFloat(M_PI * 2)
        var animRate: Float = 0.0
        
        let rotateAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnim.duration = animDuration * 2.3
        rotateAnim.fromValue = circleStart
        rotateAnim.toValue = circleEnd
        rotateAnim.repeatCount = HUGE
        layer.add(rotateAnim, forKey: nil)

        for i in 0...4{
            animRate = Float(i) * 1.7 / 8
            
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: circleRadius * 0.4 + CGFloat(i), startAngle: circleStart, endAngle: circleEnd, clockwise: true).cgPath
            
            circleShape = CAShapeLayer()
            circleShape.path = circlePath
            circleShape.fillColor = UIColor.white.cgColor
            
            let posAnim = CAKeyframeAnimation(keyPath: "position")
            posAnim.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: circleRadius * radiusMultiplier, startAngle: circleStart - CGFloat(M_PI_2), endAngle: circleEnd + circleStart - CGFloat(M_PI_2), clockwise: true).cgPath
            
            
            posAnim.repeatCount = HUGE
            posAnim.duration = animDuration
            posAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 0.15 + animRate, 0.05, 1.0)
            posAnim.isRemovedOnCompletion = true
            
            circleShape.add(posAnim, forKey: nil)
            layer.addSublayer(circleShape)
        }
    }
}

class GDHalfCircleRotating: UIView{
    //MARK: - default variables
     var circleRadius: CGFloat = 20.0
     var animDuration: CFTimeInterval = 3
     var animDelay: CFTimeInterval = 1.6

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    /**
     - parameters:
     - cRadius: circle radius and circles size
     - aDuration: duration of a full rotation
     - aDelay: delay between rotating the outer circles
     */
    init(frame: CGRect, cRadius: CGFloat, aDuration: CFTimeInterval, aDelay: CFTimeInterval){
        super.init(frame: frame)
        
        self.circleRadius = cRadius
        self.animDuration = aDuration
        self.animDelay = aDelay

        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView(){
        self.backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        self.halfCircleRotating()
    }
    
    func halfCircleRotating(){
        //Setting properties
        let circleStart: CGFloat = 0.0
        let circleEnd: CGFloat = CGFloat(M_PI * 2)
        
        //Calculate possition for each circle in different directions
        let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: center, radius: circleRadius, startAngle: circleStart, endAngle: circleEnd, clockwise: true)
        let circlePath1 = UIBezierPath()
        circlePath1.addArc(withCenter: center, radius: circleRadius - 3.0, startAngle: circleStart, endAngle: circleEnd, clockwise: false)
        let circlePathCenter = UIBezierPath()
        circlePathCenter.addArc(withCenter: center, radius: circleRadius - 8.0, startAngle: circleStart, endAngle: circleEnd, clockwise: true)
        
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        circleShape.fillColor = nil
        circleShape.strokeColor = UIColor.white.cgColor
        circleShape.lineWidth = 2.0
        circleShape.strokeStart = 0.0
        circleShape.strokeEnd = 0.0
        
        let circleShape1 = CAShapeLayer()
        circleShape1.path = circlePath1.cgPath
        circleShape1.fillColor = nil
        circleShape1.strokeColor = UIColor.white.cgColor
        circleShape1.lineWidth = 2.0
        circleShape1.strokeStart = 0.0
        circleShape1.strokeEnd = 0.0
        
        let circleShapeCenter = CAShapeLayer()
        circleShapeCenter.path = circlePathCenter.cgPath
        circleShapeCenter.fillColor = UIColor.white.cgColor
        
        let rotateAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnim.duration = animDuration * 2.3
        rotateAnim.fromValue = circleStart
        rotateAnim.toValue = circleEnd
        rotateAnim.repeatCount = HUGE
        layer.add(rotateAnim, forKey: nil)
        
        let drawAnim = CABasicAnimation(keyPath: "strokeEnd")
        drawAnim.fromValue = 0.0
        drawAnim.toValue = 1.0
        drawAnim.duration = animDuration
        
        let eraseAnim = CABasicAnimation(keyPath: "strokeStart")
        eraseAnim.fromValue = 0.0
        eraseAnim.toValue = 1.0
        eraseAnim.beginTime = animDelay
        eraseAnim.duration = animDuration - animDelay
        
        let groupAnim = CAAnimationGroup()
        groupAnim.animations = [drawAnim, eraseAnim]
        groupAnim.repeatCount = HUGE
        groupAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        groupAnim.isRemovedOnCompletion = false
        groupAnim.duration = animDuration
        
        let drawAnim1 = CABasicAnimation(keyPath: "strokeEnd")
        drawAnim1.fromValue = 0.0
        drawAnim1.toValue = 1.0
        drawAnim1.duration = animDuration
        
        let eraseAnim1 = CABasicAnimation(keyPath: "strokeStart")
        eraseAnim1.fromValue = 0.0
        eraseAnim1.toValue = 1.0
        eraseAnim1.beginTime = animDelay
        eraseAnim1.duration = animDuration - animDelay
        
        let groupAnim1 = CAAnimationGroup()
        groupAnim1.animations = [drawAnim1, eraseAnim1]
        groupAnim1.repeatCount = HUGE
        groupAnim1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        groupAnim1.isRemovedOnCompletion = false
        groupAnim1.duration = animDuration
        
        circleShape.add(groupAnim, forKey: nil)
        layer.addSublayer(circleShape)
        circleShape1.add(groupAnim1, forKey: nil)
        layer.addSublayer(circleShape1)
        layer.addSublayer(circleShapeCenter)
    }
}






