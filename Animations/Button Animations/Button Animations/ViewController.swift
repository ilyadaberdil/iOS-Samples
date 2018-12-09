//
//  ViewController.swift
//  Button Animations
//
//  Created by Berdil İlyada Karacam on 9.12.2018.
//  Copyright © 2018 Berdil İlyada Karacam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pulseTapped(_ sender: UIButton) {
        Animations.pulse(view: sender)
    }
    
    @IBAction func flashTapped(_ sender: UIButton) {
        Animations.flash(view: sender)
    }
    @IBAction func shakeTapped(_ sender: UIButton) {
        Animations.shake(view: sender)
    }
}

