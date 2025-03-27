//
//  RegisterViewController.swift
//  ITRootsTask
//
//  Created by Ann on 25/03/2025.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var fullName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        guard let phoneText = phone.text, !phoneText.isEmpty,
                 let emailText = email.text, !emailText.isEmpty,
                 let passwordText = password.text, !passwordText.isEmpty,
                 let userNameText = userName.text, !userNameText.isEmpty,
                 let fullNameText = fullName.text, !fullNameText.isEmpty else {
               showAlert(message: "All fields are required")
               return
           }

           UserDefaults.standard.set(userNameText, forKey: "savedUserName")
           UserDefaults.standard.set(passwordText, forKey: "savedPassword")
           UserDefaults.standard.synchronize()

           if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
               appDelegate.restartApp()
           }
        
    }
    @IBAction func LoginTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if let topViewController = UIApplication.shared.keyWindow?.rootViewController {
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
}
