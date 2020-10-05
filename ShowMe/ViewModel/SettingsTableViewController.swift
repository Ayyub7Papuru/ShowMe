//
//  SettingsTableViewController.swift
//  ShowMe
//
//  Created by SayajinPapuru on 02/10/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    

    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var sateliteStyleSwitch: UISwitch!
    @IBOutlet var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        updateDarkMode()
    }
    
    @IBAction func darkModeSelected(_ sender: UISwitch) {
        sender.isOn = !sender.isOn
        self.view.window?.overrideUserInterfaceStyle = traitCollection.userInterfaceStyle == .dark ? .light : .dark
    }
    
    @IBAction func SateliteStyleSelected(_ sender: UISwitch) {
    }
    
    private func setTableView() {
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    
    private func updateDarkMode() {
        let darkMode = traitCollection.userInterfaceStyle == .dark ? true : false
        darkModeSwitch.isOn = darkMode
    }
}
