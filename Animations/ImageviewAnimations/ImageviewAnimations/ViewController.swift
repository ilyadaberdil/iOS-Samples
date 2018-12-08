//
//  ViewController.swift
//  ImageviewAnimations
//
//  Created by Berdil İlyada Karacam on 8.12.2018.
//  Copyright © 2018 Berdil İlyada Karacam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ryuImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    var heartImageArray : [UIImage] = []
    var ryuImageArray : [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        heartImageArray = createImageArray(count: 24, imagePrefix: "heart")
        ryuImageArray = createImageArray(count: 7, imagePrefix: "ryu")
    }

    func animate (imageView: UIImageView, images: [UIImage]) {
        imageView.animationImages = images
        imageView.animationDuration = 1
        imageView.animationRepeatCount = 5
        imageView.startAnimating()
    }
    
    func createImageArray(count: Int, imagePrefix: String) -> [UIImage] {
        var imageArray = Array<UIImage>()

        for index in 0..<count {
            let imageName = "\(imagePrefix)-\(index).png"
            let image = UIImage(named: imageName)
            imageArray.append(image!)
        }
        return imageArray
    }
    
    @IBAction func startHeartAnimTapped(_ sender: UIButton) {
        animate(imageView: heartImageView, images: heartImageArray)
    }
    
    @IBAction func startRyuAnimTapped(_ sender: UIButton) {
        animate(imageView: ryuImageView, images: ryuImageArray)
    }
}

