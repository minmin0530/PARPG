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
        let fire = UIImageView(image: UIImage(named: "fire"))
        self.view.addSubview(fire)
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
                scene.addFireImage(image: fire)
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
