//
//  PuzzleSCNView.swift
//  PARPG003
//
//  Created by izumiyoshiki on 2021/02/25.
//

import SceneKit

class PuzzleSCNView: SCNView {

    var actionRPGView: ActionRPGView?
    var imageViewArray: [UIImageView] = []
    let IMAGE_SIZE: CGFloat = 64
    let PADDING: CGFloat = 8
    let IMAGE_ADJUST_SIZE: CGFloat = 48
    let IMAGE_NAME: [String] = ["heart","quad","star","hexagon",]
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUIView(actionView: ActionRPGView) {
        actionRPGView = actionView
    }
    
    func addUIImageView(imageView: UIImageView) {
        imageView.frame = CGRect(x: PADDING + CGFloat(imageViewArray.count % 5) * IMAGE_SIZE,
                                 y: PADDING + actionRPGView!.frame.height + CGFloat( (imageViewArray.count - imageViewArray.count % 5) / 5) * IMAGE_SIZE,
                                 width: IMAGE_ADJUST_SIZE,
                                 height: IMAGE_ADJUST_SIZE)
        imageView.image = UIImage(named: IMAGE_NAME[ Int.random(in: 0...3) ])
        imageViewArray.append(imageView)

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        actionRPGView?.startAnimation()
    }
}
