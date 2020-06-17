//
//  AuthViewController.swift
//  NewsFeed_v2
//
//  Created by Egor on 16.06.2020.
//  Copyright © 2020 TASS. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private var authServices : AuthServices!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authServices = SceneDelegate.shared().authService
        view.backgroundColor = .blue
    }
    
    @IBAction func signinTouch(_ sender: UIButton) {
        authServices.wakeUpSession()
    }
    

}
