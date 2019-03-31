//
//  ViewController.swift
//  UserDefaults
//
//  Created by Berdil İlyada Karacam on 31.03.2019.
//  Copyright © 2019 Berdil İlyada Karacam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
            titleLabel.isUserInteractionEnabled = true
            titleLabel.addGestureRecognizer(tapGesture)
            guard let selectedName = UserDefaults.standard.getSelectedName() else {
                titleLabel.text = mask(to: names.first ?? "")
                return
            }
            titleLabel.text = selectedName
        }
    }
    
    @IBOutlet weak var tableView: AutoSizingTableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = UIColor.lightGray
            tableView.estimatedRowHeight = 45
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    
    @IBOutlet weak var viewSwitch: UISwitch! {
        didSet {
            viewSwitch.isOn = false
            viewSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        guard let text = titleLabel.text else { return }
        tableView.isHidden = true
        let maskedText = mask(to: text)
        if sender.isOn {
            var isOnList: [String] = []
            if let userData = UserDefaults.standard.getSwitchIsOpen() {
                isOnList = userData
            }
            if !isOnList.contains(maskedText) {
                isOnList.append(maskedText)
                UserDefaults.standard.setSwitchIsOpen(isOnList: isOnList)
            }
        } else {
            guard let isOnList = UserDefaults.standard.getSwitchIsOpen() else { return }
            if isOnList.contains(maskedText) {
                let newList = isOnList.filter {$0 != maskedText}
                UserDefaults.standard.setSwitchIsOpen(isOnList: newList)
            }
        }
    }
    
    let names = ["Berdil Gizli Mesaj", "İlyada Masked", "Karaçam"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myArray = UserDefaults.standard.getSwitchIsOpen()
        
        if myArray?.contains(titleLabel.text ?? "") ?? false {
            viewSwitch.isOn = true
        }
    }
    
    @objc func labelTapped() {
        UIView.animate(withDuration: 0.3) {
            self.tableView.isHidden = !self.tableView.isHidden
            self.view.layoutIfNeeded()
        }
    }
    
    func mask(to text: String) -> String {
        var maskedText = ""
        let chars = text.uppercased().split(separator: " ")
        for char in chars {
            for c in char {
                if c == char.first {
                    maskedText += String(c)
                } else {
                    maskedText += "*"
                }
            }
            maskedText += " "
        }
        return maskedText
    }
}

extension ViewController : UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.lightGray
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        titleLabel.text = mask(to: names[indexPath.row])
        UserDefaults.standard.setSelectedName(name: mask(to: names[indexPath.row]))
        if let isOnList = UserDefaults.standard.getSwitchIsOpen() {
            if isOnList.contains(mask(to: names[indexPath.row])) {
                viewSwitch.isOn = true
            } else { viewSwitch.isOn = false }
        }
        UIView.animate(withDuration: 0.3) {
            self.tableView.isHidden = !self.tableView.isHidden
            self.view.layoutIfNeeded()
        }
    }
}
