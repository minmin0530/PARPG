//
//  GameScene.swift
//  PARPG003
//
//  Created by izumiyoshiki on 2021/02/25.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var deleteFlag: Bool = false
    private var shieldFlag: Bool = false
    private var fireFlagArray: [Bool] = []
    private var fallFlag: Bool = false
    private var jumpFlag: Bool = false
    private var jumpSpeed: CGFloat = 0.0
    private let JUMP_SPEED: CGFloat = 4.0
    private let GRAVITY: CGFloat = 0.1
    private let GROUND: CGFloat = 125.0
    private let SCREEN_WIDTH: CGFloat = 700
    private var enemyImageView: UIImageView?
    private var fireIndex: Int = 0
    private var fireImageViewArray: [UIImageView] = []
    private var shildTime: Int = 0
    private var shieldImageView: UIImageView?
    private var heartImageArray: [UIImageView] = []
    private var holeImageView: UIImageView?
    private var imageView: UIImageView?
    private var fieldView1: UIImageView?
    private var fieldView2: UIImageView?

    private var pieceArray: [PuzzlePiece] = []
    private let IMAGE_SIZE: CGFloat = 64
    private let PADDING: CGFloat = 8
    private let IMAGE_ADJUST_SIZE: CGFloat = 48
    private let IMAGE_SMALL_SIZE: CGFloat = 20
    private let IMAGE_NAME: [String] = ["heartp","shield","fire2","jump",]
    private let FALL_SPEED: CGFloat = 4.0

    private var actionRPGViewHeight: CGFloat?

    override func didMove(to view: SKView) {
    }
    
    func addEnemyImage(image: UIImageView) {
        enemyImageView = image
        enemyImageView?.frame = CGRect(x: 250, y: 100, width: 50, height: 50)
    }
    func addFireImage(image: UIImageView) {
        fireImageViewArray.append(image)
        image.isHidden = true
        image.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        fireFlagArray.append(false)
    }
    func addShieldImage(image: UIImageView) {
        shieldImageView = image
        image.isHidden = true
        image.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
    }
    func addHeartImage(image: UIImageView) {
        heartImageArray.append(image)
        image.frame = CGRect(x: heartImageArray.count * 30, y: 0, width: 30, height: 30)
    }
    func addHoleImage(image: UIImageView) {
        holeImageView = image
        image.frame = CGRect(x: 200, y: 85, width: 70, height: 80)
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
    func setActionRPGViewHeight(height: CGFloat) {
        actionRPGViewHeight = height
    }
    func addUIImageView(piece: PuzzlePiece) {
        piece.frame = CGRect(x: PADDING + CGFloat(pieceArray.count % 5) * IMAGE_SIZE,
                                 y: PADDING + actionRPGViewHeight! + CGFloat( (pieceArray.count - pieceArray.count % 5) / 5) * IMAGE_SIZE,
                                 width: IMAGE_ADJUST_SIZE,
                                 height: IMAGE_ADJUST_SIZE)
        
        switch Int.random(in: 0...3) {
        case 0:
            piece.image = UIImage(named: ImageName.heart.rawValue)
            piece.imageName = .heart
            break
        case 1:
            piece.image = UIImage(named: ImageName.shield.rawValue)
            piece.imageName = .shield
            break
        case 2:
            piece.image = UIImage(named: ImageName.fire.rawValue)
            piece.imageName = .fire
            break
        case 3:
            piece.image = UIImage(named: ImageName.jump.rawValue)
            piece.imageName = .jump
            break
        default:
            break
        }
        piece.indexX = pieceArray.count % 5
        piece.indexY = (pieceArray.count - pieceArray.count % 5) / 5
        piece.touch = false
        piece.fall = false
        pieceArray.append(piece)

    }

    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
                
        for image in pieceArray {
            if 400 + pos.x > image.frame.minX * 2.5 &&
                400 + pos.x < image.frame.maxX * 2.5 &&
                4.0 * actionRPGViewHeight! - pos.y > image.frame.minY * 2.5 &&
                4.0 * actionRPGViewHeight! - pos.y < image.frame.maxY * 2.5 {
                image.frame = CGRect(x: image.frame.minX, y: image.frame.minY, width:IMAGE_SMALL_SIZE, height: IMAGE_SMALL_SIZE)
                image.touch = true
            }
        } 
    }
    
    func touchUp(atPoint pos : CGPoint) {
        var imageName: ImageName? = nil
        var touchCount: Int = 0
        for image in pieceArray {
            if image.touch == true {
                if  imageName != nil && image.imageName != imageName {
                    for image2 in pieceArray {
                        image2.frame = CGRect(x: image2.frame.minX, y: image2.frame.minY, width:IMAGE_ADJUST_SIZE, height: IMAGE_ADJUST_SIZE)
                        image2.touch = false
                    }
                    return
                }
                imageName = image.imageName
                touchCount += 1
            }
        }
        
        if touchCount < 2 {
            for image in pieceArray {
                image.frame = CGRect(x: image.frame.minX, y: image.frame.minY, width:IMAGE_ADJUST_SIZE, height: IMAGE_ADJUST_SIZE)
                image.touch = false
            }
            return
        }
        
        var imageX: [Int] = [0,0,0,0,0]
        for image in pieceArray {
            if image.fall == true {
//                let addX: Int = Int((actionRPGViewHeight! - image.frame.minY) / IMAGE_SIZE) + 1
                imageX[image.indexX!] += 1
            }
        }
        
        var fireFlag: Bool = false
        for image in pieceArray {
            if image.touch == true {
                imageX[image.indexX!] += 1
                image.frame = CGRect(x: image.frame.minX, y: actionRPGViewHeight! - CGFloat(imageX[image.indexX!]) * IMAGE_SIZE, width: IMAGE_ADJUST_SIZE, height: IMAGE_ADJUST_SIZE)
                image.touch = false
                image.fall = true
                deleteFlag = true
                if imageName == ImageName.jump {
                    jumpFlag = true
                    jumpSpeed = JUMP_SPEED
//                    actionRPGView?.jumpAnimation()
                    
                }
                if imageName == ImageName.fire {
                    fireFlag = true
//                    actionRPGView?.fireAnimation()
                }
                if imageName == ImageName.shield {
                    shieldFlag = true
                }
                switch Int.random(in: 0...3) {
                case 0:
                    image.image = UIImage(named: ImageName.heart.rawValue)
                    image.imageName = .heart
                    break
                case 1:
                    image.image = UIImage(named: ImageName.shield.rawValue)
                    image.imageName = .shield
                    break
                case 2:
                    image.image = UIImage(named: ImageName.fire.rawValue)
                    image.imageName = .fire
                    break
                case 3:
                    image.image = UIImage(named: ImageName.jump.rawValue)
                    image.imageName = .jump
                    break
                default:
                    break
                }
            }
        }
        
        if fireFlag == true {
            fireFlagArray[fireIndex] = true
            fireIndex += 1
            if fireIndex >= fireImageViewArray.count {
                fireIndex = 0
            }

        }
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        fieldView1?.center.x -= 1
        fieldView2?.center.x -= 1
        if fieldView1!.frame.maxX < 0 {
            fieldView1?.center.x = SCREEN_WIDTH
        }
        if fieldView2!.frame.maxX < 0 {
            fieldView2?.center.x = SCREEN_WIDTH
        }
        
        holeImageView?.center.x -= 1
        if holeImageView!.center.x > imageView!.center.x + IMAGE_ADJUST_SIZE / 2 &&
        holeImageView!.center.x < imageView!.center.x + IMAGE_ADJUST_SIZE &&
            holeImageView!.center.y >= imageView!.center.y &&
            holeImageView!.center.y < imageView!.center.y + 1
        {
            fallFlag = true
        }

        if fallFlag == true {
            imageView?.center.y += 10
            if imageView!.center.y > actionRPGViewHeight! {
                imageView?.isHidden = true
            }
        }

        if jumpFlag == true {
            if imageView!.center.y > GROUND {
                jumpSpeed = 0.0
                jumpFlag = false
                imageView!.center.y = GROUND
            } else {
                jumpSpeed -= GRAVITY
                imageView?.center.y -= jumpSpeed
            }
        }

        if shieldFlag == true {
            shieldImageView?.isHidden = false
            shildTime += 1
            if shildTime > 100 {
                shildTime = 0
                shieldFlag = false
                shieldImageView?.isHidden = true
            }
        }

        for i in 0..<fireImageViewArray.count {
            if fireFlagArray[i] == true {
                fireImageViewArray[i].isHidden = false
                fireImageViewArray[i].center.x += 1
                if fireImageViewArray[i].center.x > SCREEN_WIDTH {
                    fireFlagArray[i] = false
                    fireImageViewArray[i].isHidden = true
                    fireImageViewArray[i].center.x = 0
                }
                if fireImageViewArray[i].center.x > enemyImageView!.center.x &&
                    fireImageViewArray[i].center.x < enemyImageView!.center.x + IMAGE_ADJUST_SIZE {
                    fireFlagArray[i] = false
                    fireImageViewArray[i].isHidden = true
                    fireImageViewArray[i].center.x = 0

                    enemyImageView?.isHidden = true
                    enemyImageView?.center.x = 9999
                
                }
            }
        }
        
        if deleteFlag == true {
            var hitCount = 0
            for image1 in pieceArray {
                var hitFlag = false
                if image1.frame.width == IMAGE_SMALL_SIZE {
                    continue
                }
                for image2 in pieceArray {
                    if image1 != image2 &&
                        image2.frame.minY > image1.frame.maxY &&
                        image2.frame.minY < image1.frame.maxY + PADDING * 2 &&
                        image2.frame.minX == image1.frame.minX {
                        hitFlag = true
                        break
                    }
                }
                if image1.frame.maxY > IMAGE_SIZE * 5 - PADDING + actionRPGViewHeight! {
                    hitFlag = true
                }
                if hitFlag == false {
                    var doubleFlag = false
                    for image2 in pieceArray {
                        if image1 != image2 &&
                            image2.frame.minY > image1.frame.minY &&
                            image2.frame.minY < image1.frame.maxY + PADDING * 2 &&
                            image2.frame.minX == image1.frame.minX {
                            doubleFlag = true
                            break
                        }
                    }

                    if doubleFlag == false {
                        image1.center.y += FALL_SPEED
                    }
                } else {
                    hitCount += 1
                    image1.fall = false
                }
            }
            
            if hitCount >= pieceArray.count {
                deleteFlag = false
            }
        }
    }
}
