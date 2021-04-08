//
//  AuthViewController.swift
//  VKp
//
//  Created by  Sergei on 07.04.2021.
//

import UIKit

class AuthViewController: UIViewController {

//    private var authService = AuthService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9187689424, green: 0.8698328137, blue: 0.5872992873, alpha: 1)
    }

}

extension AuthViewController {
    
    @IBAction func sighInTouched(_ sender: UIButton) {
        let authService = SceneDelegate.shared.authService
        authService.wakeUpSession()
    }
    
}

