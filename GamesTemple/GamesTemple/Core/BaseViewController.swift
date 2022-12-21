//
//  BaseViewController.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 11.12.2022.
//

import UIKit
import MaterialActivityIndicator
import SwiftAlertView

class BaseViewController: UIViewController {

    let indicator = MaterialActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
        
    }
    
    private func setupActivityIndicatorView() {
            view.addSubview(indicator)
            setupActivityIndicatorViewConstraints()
        }
    
    private func setupActivityIndicatorViewConstraints() {
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    
    func showErrorAlert(message: String) {
            SwiftAlertView.show(title: "Error",message: message,buttonTitles: ["OK"])
        }

}
