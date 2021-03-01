//
//  PuzzlePiece.swift
//  PARPG003
//
//  Created by 泉芳樹 on 2021/02/28.
//

import UIKit

enum ImageName: String {
    case heart = "heart"
    case quad = "quad"
    case star = "star"
    case hexagon = "hexagon"
}

class PuzzlePiece: UIImageView {
    var indexX: Int?
    var indexY: Int?
    var imageName: ImageName?
    var touch: Bool?
    var fall: Bool?
}
