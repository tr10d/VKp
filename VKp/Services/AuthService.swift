//
//  AuthService.swift
//  VKp
//
//  Created by  Sergei on 07.04.2021.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
  func authServiceShouldPresent(viewController: UIViewController)
  func authServiceAccessAuthorizationFinished()
  func authServiceUserAuthorizationFailed()
}

final class AuthService: NSObject {
  private let vkSdk: VKSdk
  weak var delegate: AuthServiceDelegate?
  var token: String {
    VKSdk.accessToken()?.accessToken ?? ""
  }

  override init() {
    vkSdk = VKSdk.initialize(withAppId: API.appId, apiVersion: API.version)
    super.init()
    vkSdk.register(self)
    vkSdk.uiDelegate = self
  }
}

extension AuthService {
  func wakeUpSession() {
    VKSdk.wakeUpSession(API.scope) { [delegate] (state, _) in
      switch state {
      case .initialized:
        print("initialized")
        VKSdk.authorize(API.scope)
      case .authorized:
        print("authorized")
        delegate?.authServiceAccessAuthorizationFinished()
      default:
        delegate?.authServiceUserAuthorizationFailed()
      }
    }
  }
}

extension AuthService: VKSdkDelegate {
  func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
    #if DEBUG
    debugPrint(#function)
    #endif
    if result.token != nil {
      delegate?.authServiceAccessAuthorizationFinished()
    }
  }

  func vkSdkUserAuthorizationFailed() {
    #if DEBUG
    debugPrint(#function)
    #endif
    delegate?.authServiceUserAuthorizationFailed()
  }
}

extension AuthService: VKSdkUIDelegate {
  func vkSdkShouldPresent(_ controller: UIViewController!) {
    #if DEBUG
    debugPrint(#function)
    #endif
    delegate?.authServiceShouldPresent(viewController: controller)
  }

  func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
    #if DEBUG
    debugPrint(#function)
    #endif
  }
}
