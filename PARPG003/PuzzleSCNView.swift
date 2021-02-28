//
//  PuzzleSCNView.swift
//  PARPG003
//
//  Created by izumiyoshiki on 2021/02/25.
//

import SceneKit

enum ImageName: String {
    case heart = "heart"
    case quad = "quad"
    case star = "star"
    case hexagon = "hexagon"
}

class PuzzleSCNView: SCNView {

    var actionRPGView: ActionRPGView?
    var pieceArray: [PuzzlePiece] = []
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
    
    func addUIImageView(piece: PuzzlePiece) {
        piece.frame = CGRect(x: PADDING + CGFloat(pieceArray.count % 5) * IMAGE_SIZE,
                                 y: PADDING + actionRPGView!.frame.height + CGFloat( (pieceArray.count - pieceArray.count % 5) / 5) * IMAGE_SIZE,
                                 width: IMAGE_ADJUST_SIZE,
                                 height: IMAGE_ADJUST_SIZE)
        
        switch Int.random(in: 0...3) {
        case 0:
            piece.image = UIImage(named: ImageName.heart.rawValue)
            piece.imageName = .heart
            break
        case 1:
            piece.image = UIImage(named: ImageName.quad.rawValue)
            piece.imageName = .quad
            break
        case 2:
            piece.image = UIImage(named: ImageName.star.rawValue)
            piece.imageName = .star
            break
        case 3:
            piece.image = UIImage(named: ImageName.hexagon.rawValue)
            piece.imageName = .hexagon
            break
        default:
            break
        }
        piece.indexX = pieceArray.count % 5
        piece.indexY = (pieceArray.count - pieceArray.count % 5) / 5
        piece.touch = false
        pieceArray.append(piece)

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        actionRPGView?.startAnimation()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos: CGPoint = t.location(in: self)
            
            for image in pieceArray {
                if pos.x > image.frame.minX &&
                    pos.x < image.frame.maxX &&
                    actionRPGView!.frame.height + pos.y > image.frame.minY &&
                    actionRPGView!.frame.height + pos.y < image.frame.maxY {
                    image.frame = CGRect(x: image.frame.minX, y: image.frame.minY, width:20, height: 20)
                    image.touch = true
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var imageName: ImageName? = nil
        for image in pieceArray {
            if image.touch == true {
                if  imageName != nil && image.imageName != imageName {
                    return
                }
                imageName = image.imageName
            }
        }
        
        for image in pieceArray {
            if image.touch == true {
                image.frame = CGRect(x: image.frame.minX, y: 0, width: 32, height: 32)
                image.indexX = -1
                image.indexY = -1
                image.touch = false;
                if imageName == ImageName.hexagon {
                    actionRPGView?.jumpAnimation()
                }
            }
        }
    }
    
}
