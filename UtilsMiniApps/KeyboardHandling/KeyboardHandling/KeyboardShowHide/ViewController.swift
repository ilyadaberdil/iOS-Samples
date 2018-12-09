//
//  ViewController.swift
//  KeyboardShowHide
//
//  Created by Berdil İlyada Karacam on 9.12.2018.
//  Copyright © 2018 Berdil İlyada Karacam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var textField: UITextField! {
        didSet{
          //  textField.autocorrectionType = .no
            textField.delegate = self
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
      
        self.hideKeyboardWhenTappedAround()

    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print(textField.text)
        view.endEditing(true)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            /*if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            } */
           // scrollView.frame.origin.y -= keyboardSize.height
            var contentInset:UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardSize.height
            scrollView.contentInset = contentInset
       //    scrollView.scrollIndicatorInsets = contentInset
        }
    }
    //not: scrollviewin scrollu kapamak için storyboardda scrollview in keyboard özelligini degistir! 
    @objc func keyboardWillHide(notification: NSNotification) {
       /* if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }*/
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets.zero
        //   scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
           // scrollView.frame.origin.y += keyboardSize.height
        }
    }
}
extension ViewController:UITextFieldDelegate {
 
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
    }
    
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
      //  tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
