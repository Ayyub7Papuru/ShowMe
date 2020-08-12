//
//  DetailsViewController.swift
//  ShowMe
//
//  Created by SayajinPapuru on 12/08/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var favButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func favButtonTapped(_ sender: UIButton) {
        if favButton.imageView?.image == UIImage(named: "heartEmpty") {
            favButton.setImage(UIImage(named: "heartFill"), for: .normal)
        } else {
            favButton.setImage(UIImage(named: "heartEmpty"), for: .normal)
        }
        
    }
}
