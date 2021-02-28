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

    @IBOutlet weak var puzzleView: PuzzleSCNView!
    @IBOutlet weak var actionRPGView: ActionRPGView!
    @IBOutlet weak var dragon: UIImageView!
    @IBOutlet weak var allfieldbig: UIImageView!
    @IBOutlet weak var allfieldbig2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.bringSubviewToFront(allfieldbig)
        self.view.bringSubviewToFront(allfieldbig2)
        self.view.bringSubviewToFront(dragon)
        actionRPGView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - self.view.bounds.width)
        actionRPGView.backgroundColor = .blue
        actionRPGView.addUIImageView(image: dragon)
        actionRPGView.addFieldImage1(fieldImage: allfieldbig)
        actionRPGView.addFieldImage2(fieldImage: allfieldbig2)

        
        puzzleView.frame = CGRect(x: 0, y: self.view.bounds.height - self.view.bounds.width, width: self.view.bounds.width, height: self.view.bounds.width)
        puzzleView.backgroundColor = .red
        puzzleView.setUIView(actionView: actionRPGView)
        
        for _ in 0..<25 {
            let image: UIImageView = UIImageView()
            self.view.addSubview(image)
            puzzleView.addUIImageView(imageView: image)
        }
        
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
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
