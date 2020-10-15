//
//  SettingsViewController.swift
//  ShowMe
//
//  Created by SayajinPapuru on 11/10/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
    
    // MARK: - Actions
    
    
    // MARK: - Private Methods
    
    private func setBackground() {
        view.backgroundColor = UIColor(named: "background")
    }
}
