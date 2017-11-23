//
//  ViewController.swift
//  Faceit
//
//  Created by Developer on 23/10/2017.
//  Copyright © 2017 CGI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView!{
        didSet{
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecogniser = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecogniser)
            let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo:)))
            tapRecogniser.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapRecogniser)
            let swipeUpRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeUpRecogniser.direction = .up
            faceView.addGestureRecognizer(swipeUpRecogniser)
            let swipeDownRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            swipeDownRecogniser.direction = .down
            faceView.addGestureRecognizer(swipeDownRecogniser)
            updateUI()
        }
    }

    func toggleEyes(byReactingTo tapRecogniser: UITapGestureRecognizer){
        if tapRecogniser.state == .ended{
            let eyes: FacialExpression.Eyes = (expression.eyes == .close) ? .open : .close
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    func increaseHappiness()
    {
        expression = expression.happier
    }
    
    func decreaseHappiness()
    {
        expression = expression.sadder
    }
    
    
    var expression = FacialExpression(eyes: .close, mouth: .grin){
        didSet {
            updateUI()
        }
    }
    
    
    
    
    
    private func updateUI()
    {
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .close:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        
        
    }
  
    
    private let mouthCurvatures = [FacialExpression.Mouth.grin: 0.5,
                                   .frown:      -1.0,
                                   .smile:      1.0,
                                   .neutral:    0.0,
                                   .smirk:      -0.5]
    
    
}

