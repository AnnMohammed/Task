//
//  LoginViewController.swift
//  ITRootsTask
//
//  Created by Ann on 25/03/2025.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    @IBOutlet weak var dropview: UIView!
    var selectedLanguage = Language.currentAppleLanguage()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func userTypeTapped(_ sender: Any) {
        dropview.isHidden.toggle()
    }
    @IBAction func adminTapped(_ sender: Any) {
        userTypeLabel.text = "Admin".localized
        dropview.isHidden = true
    }
    
    @IBAction func usertapped(_ sender: Any) {
        userTypeLabel.text = "User".localized
        dropview.isHidden = true
    }
    @IBAction func loginTapped(_ sender: Any) {
        
        if let userName = userNameLabel.text, !userName.isEmpty,
           let password = passwordTextFeild.text, !password.isEmpty {
            UserDefaults.standard.set(userName, forKey: "savedUserName")
            UserDefaults.standard.set(password, forKey: "savedPassword")
            let mainTabBarController = MainTabBarController()
            if let window = UIApplication.shared.delegate?.window ?? nil {
                window.rootViewController = mainTabBarController
                window.makeKeyAndVisible()
            }
        } else {
            showAlert(message: "All data is required")
        }
    }
    @IBAction func signUpTapped(_ sender: Any) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if let topViewController = UIApplication.shared.keyWindow?.rootViewController {
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
}
