//
//  GameViewController.swift
//  PARPG003
//
//  Created by izumiyoshiki on 2021/02/25.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var dragon: UIImageView!
    @IBOutlet weak var allfieldbig: UIImageView!
    @IBOutlet weak var allfieldbig2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.bringSubviewToFront(dragon)
        let hole = UIImageView(image: UIImage(named: "hole"))
        self.view.addSubview(hole)
        let shield = UIImageView(image: UIImage(named: "shield"))
        self.view.addSubview(shield)
        let heart1 = UIImageView(image: UIImage(named: "heartp"))
        let heart2 = UIImageView(image: UIImage(named: "heartp"))
        let heart3 = UIImageView(image: UIImage(named: "heartp"))
        self.view.addSubview(heart1)
        self.view.addSubview(heart2)
        self.view.addSubview(heart3)
        let fire1 = UIImageView(image: UIImage(named: "fire"))
        let fire2 = UIImageView(image: UIImage(named: "fire"))
        let fire3 = UIImageView(image: UIImage(named: "fire"))
        let fire4 = UIImageView(image: UIImage(named: "fire"))
        self.view.addSubview(fire1)
        self.view.addSubview(fire2)
        self.view.addSubview(fire3)
        self.view.addSubview(fire4)
        let enemy = UIImageView(image: UIImage(named: "dragon3"))
        self.view.addSubview(enemy)

        if let view = self.view as! SKView? {

            if let scene = GameScene(fileNamed: "GameScene") {
                
                scene.setActionRPGViewHeight(height: self.view.bounds.height - self.view.bounds.width)
                
                for _ in 0..<25 {
                    let piece: PuzzlePiece = PuzzlePiece()
                    self.view.addSubview(piece)
                    scene.addUIImageView(piece: piece)
                }
                
                
                scene.addUIImageView(image: dragon)
                scene.addHoleImage(image: hole)
                scene.addShieldImage(image: shield)
                scene.addHeartImage(image: heart1)
                scene.addHeartImage(image: heart2)
                scene.addHeartImage(image: heart3)
                scene.addFireImage(image: fire1)
                scene.addFireImage(image: fire2)
                scene.addFireImage(image: fire3)
                scene.addFireImage(image: fire4)
                scene.addEnemyImage(image: enemy)
                scene.addFieldImage1(fieldImage: allfieldbig)
                scene.addFieldImage2(fieldImage: allfieldbig2)

                scene.scaleMode = .aspectFill

                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
