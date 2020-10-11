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
    
    @IBOutlet weak var darkModeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
    
    // MARK: - Actions
    
    @IBAction func darkModeToggled(_ sender: UISwitch) {
        
        switch sender.isOn {
        case false:
            self.view.window?.overrideUserInterfaceStyle = .light
        case true:
            self.view.window?.overrideUserInterfaceStyle = .dark
        }
    }
    
    // MARK: - Private Methods
    
    private func setBackground() {
        view.backgroundColor = UIColor(named: "background")
    }
}
