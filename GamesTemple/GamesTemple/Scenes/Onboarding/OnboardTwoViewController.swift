//
//  OnboardTwoViewController.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 17.12.2022.
//

import UIKit

class OnboardTwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func pushMain(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
    }
    

}
