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
            updateUI()
        }
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

