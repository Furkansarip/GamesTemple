//
//  OnboardViewController.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 17.12.2022.
//

import UIKit

class OnboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func nextButton(_ sender: Any) {
        performSegue(withIdentifier: "onboard2", sender: nil)
    }

}
