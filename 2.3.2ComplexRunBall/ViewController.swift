//
//  ViewController.swift
//  2.3.2ComplexRunBall
//
//  Created by MAC on 6/17/22.
//

import UIKit

class ViewController: UIViewController {

    let contenerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let blackView:UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    let greenView:UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    
    var rotateAngle : CGFloat = 0
    var timerRotate:Timer!
    
    var leftRighTimer: Timer!
    var leftRight:Bool = true
    
    var downTimer:Timer!
    var downCount: CGFloat = 1
    
    var upTimer:Timer!
    var isUP = false
    var upCount: CGFloat = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        timerRotate = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { _ in
            self.rotateAngle += 1
            self.blackView.transform = CGAffineTransform(rotationAngle: -.pi * self.rotateAngle/360 )
        })
        leftRightMove()
    }
    
    func leftRightMove() {
        if leftRight == true {
            leftRighTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { (_) in
                self.contenerView.frame.origin.x += 0.5
                if self.contenerView.frame.maxX >= self.view.frame.maxX {
                    
                    self.leftRighTimer.invalidate()
                    self.leftRight = false
                    if self.isUP {
                        self.upMove()
                    } else {
                        self.downMove()
                    }
                    
                }
            })
        } else {
            leftRighTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { (_) in
                self.contenerView.frame.origin.x -= 0.5
                if self.contenerView.frame.minX <= self.view.frame.minX {
                    
                    self.leftRighTimer.invalidate()
                    self.leftRight = true
                    if self.isUP {
                        self.upMove()
                    } else {
                        self.downMove()
                    }
                }
            })
        }
        
    }
    func downMove (){
        downTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { (_) in
            self.contenerView.frame.origin.y += 0.5
            if self.contenerView.frame.maxY >= (self.view.frame.maxY * self.downCount / 3) {
                self.downTimer.invalidate()
                self.downCount += 1
                if self.downCount > 3 {
                    print("da den cuoi")
                    self.isUP = true
                    self.leftRightMove()
                    self.downCount = 1
        
                } else {
                    self.leftRightMove()
                    print("dang xuong")
                }
                
            }
        })
    }
    
    func upMove() {
       
        upTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { (_) in
            self.contenerView.frame.origin.y -= 0.5
            if self.upCount > 0 {
                if self.contenerView.frame.maxY <= (self.view.frame.maxY * self.upCount / 3) {
                    self.upCount -= 1
                    self.upTimer.invalidate()
                    
                    self.leftRightMove()
                }
            } else {
                if self.contenerView.frame.minY <= self.view.frame.minY {
                    self.upTimer.invalidate()
                    self.isUP = false
                    self.upCount = 2
                    self.leftRightMove()
                }
                
            }
            
        })
        
    }
    
    func updateUI(){
        
        view.addSubview(contenerView)
        contenerView.frame = CGRect()
        view.addSubview(contenerView)
        contenerView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        contenerView.addSubview(blackView)
       
        blackView.frame = contenerView.bounds
        blackView.layer.cornerRadius = 30
        blackView.clipsToBounds = true
        blackView.layer.borderWidth = 3
        blackView.layer.borderColor = UIColor.blue.cgColor
        
        blackView.addSubview(greenView)
        greenView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
    }
    
}

