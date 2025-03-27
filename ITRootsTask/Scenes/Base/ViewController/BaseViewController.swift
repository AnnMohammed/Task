//
//  BaseViewController.swift
//  Wala
//
//  Created by Ann on 05/02/2024.
//

import Foundation
import UIKit
import Combine
import NVActivityIndicatorView
import SwiftMessages
import Alamofire
import PDFKit

class BaseViewController: UIViewController {
    
    var cancellables = Set<AnyCancellable>()
    
    let loading = NVActivityIndicatorView(frame: .zero, type: .ballRotateChase, color: UIColor.black , padding: 0)
    
    private let notificationCenter = NotificationCenter.default
    let notificationCenterForeground = NotificationCenter.default
    
    lazy var containerOfLoading: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.1)
        return view
        
    }()
    
    // showIndictor
    func showIndictor() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addLoaderToView(mainView: self.view, containerOfLoading: containerOfLoading, loading: loading)
        }
    }
    
    // hideIndictor
    func hideIndictor() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.removeLoader(containerOfLoading: containerOfLoading, loading: loading)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    func bind() {}
    
    func showAlert(title: String, message: String, completion : ((UIAlertAction) -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: completion)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showAlert(title : String, message: String = "", cancelTitle : String = "Cancel".localized , okTitle : String = "OK".localized, completion :  ((UIAlertAction) -> Void)?)  {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: completion)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        alertVC.addAction(cancelAction)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true)
    }
    
    func set(_ controller: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.1
        transition.type = CATransitionType.fade
        navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.setViewControllers([controller], animated: false)
    }
    
    func push(_ controller: UIViewController) {
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func pop()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addPlure(toView view: UIView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.9
        view.addSubview(blurEffectView)
    }
    
    deinit {
        print("Deinit: " + String(describing: self))
    }
}

class BasePresntingViewController: BaseViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIViewController {

    func addLoaderToView(mainView: UIView, containerOfLoading: UIView, loading: NVActivityIndicatorView) {

        DispatchQueue.main.async {
            loading.isUserInteractionEnabled = false
            loading.translatesAutoresizingMaskIntoConstraints = false
            
            containerOfLoading.translatesAutoresizingMaskIntoConstraints = false
            

            self.view.addSubview(containerOfLoading)
            containerOfLoading.addSubview(loading)

            NSLayoutConstraint.activate([

                containerOfLoading.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0),
                containerOfLoading.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0),
                containerOfLoading.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
                containerOfLoading.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),

                loading.widthAnchor.constraint(equalToConstant: 50),
                loading.heightAnchor.constraint(equalToConstant: 50),
                loading.centerYAnchor.constraint(equalTo: containerOfLoading.centerYAnchor, constant: 0),
                loading.centerXAnchor.constraint(equalTo: containerOfLoading.centerXAnchor, constant: 0)

            ])

            loading.startAnimating()
        }

    }

    func removeLoader(containerOfLoading: UIView, loading: NVActivityIndicatorView)  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {

            containerOfLoading.removeFromSuperview()

            loading.stopAnimating()

        }
    }
    
}
