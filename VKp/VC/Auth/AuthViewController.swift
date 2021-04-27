//
//  AuthViewController.swift
//  VKp
//
//  Created by  Sergei on 07.04.2021.
//

import UIKit

class AuthViewController: UIViewController {
  private var authService: AuthService?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func configure(authService: AuthService) {
    self.authService = authService
  }
}

extension AuthViewController {
  @IBAction func sighInTouched(_ sender: UIButton) {
    authService?.wakeUpSession()
  }
}
