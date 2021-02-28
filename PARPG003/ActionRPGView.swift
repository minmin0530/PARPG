//
//  ActionRPGView.swift
//  PARPG003
//
//  Created by izumiyoshiki on 2021/02/25.
//

import UIKit

class ActionRPGView: UIView {
    
    var imageView: UIImageView?
    var fieldView1: UIImageView?
    var fieldView2: UIImageView?

    var onceFlag: Bool = false
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addUIImageView(image: UIImageView) {
        imageView = image
        imageView?.frame = CGRect(x: 50, y: 100, width: 50, height: 50)
        
    }
    
    func addFieldImage1(fieldImage: UIImageView) {
        fieldView1 = fieldImage
    }
    func addFieldImage2(fieldImage: UIImageView) {
        fieldView2 = fieldImage
    }

    func jumpAnimation() {
        self.imageView?.transform = CGAffineTransform(translationX: 0, y: -50)

        
        UIView.transition(with: imageView!, duration: 0.6, options: [ .curveEaseOut, .autoreverse], animations: ({
            self.imageView?.transform = CGAffineTransform(translationX: 0, y: -100)
        }), completion: ({ _ in
            self.imageView?.transform = CGAffineTransform(translationX: 0, y: 0)
        }))

    }
    func startAnimation() {
        
        if (onceFlag == false) {
            onceFlag = true

            var x: CGFloat = 500
//                fieldView.frame = CGRect(x: 0, y: 50, width: 700, height: 100)

            
                UIView.transition(with: fieldView1!, duration: 6, options: [ .repeat, .curveLinear], animations: ({
                    self.fieldView1!.transform = CGAffineTransform(translationX: -500, y: 0)
                }), completion: ({ _ in
                    self.fieldView1!.transform = CGAffineTransform(translationX: 500, y: 0)
                }))
                
                UIView.animate(withDuration: 6, delay: 0, options: [ .repeat, .curveLinear], animations: ({
                    self.fieldView2!.transform = CGAffineTransform(translationX: -500, y: 0)
                }), completion: ({ _ in
                    self.fieldView2!.transform = CGAffineTransform(translationX: 500, y: 0)
                }))
                
                x -= 110
        }
    }
}
