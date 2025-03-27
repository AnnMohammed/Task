//
//  SettingsViewController.swift
//  ITRootsTask
//
//  Created by Ann on 27/03/2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var changeLan: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cahngeLangTapped(_ sender: Any) {
        
        let newLanguage = (Language.currentAppleLanguage() == "en") ? "ar" : "en"
        Language.setAppleLAnguageTo(lang: newLanguage)
        UIApplication.initWindow()
    }
    @IBAction func logOutTapped(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "savedUserName")
        UserDefaults.standard.removeObject(forKey: "savedPassword")
        UserDefaults.standard.synchronize()
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
               appDelegate.restartApp()
           }
        
    }
    
}
