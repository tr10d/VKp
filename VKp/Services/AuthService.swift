//
//  AuthService.swift
//  VKp
//
//  Created by  Sergei on 07.04.2021.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: class {
  func authServiceShouldPresent(viewController: UIViewController)
  func authServiceAccessAuthorizationFinished()
  func authServiceUserAuthorizationFailed()
}

final class AuthService: NSObject {
//  private let appId = "7816753"
//  private let apiVersion = "5.130"
  private let vkSdk: VKSdk
//  private let scope = ["offline", "friends", "photos", "groups"]
  weak var delegate: AuthServiceDelegate?

  override init() {
    vkSdk = VKSdk.initialize(withAppId: VKApi.appId, apiVersion: VKApi.apiVersion)
    super.init()
    vkSdk.register(self)
    vkSdk.uiDelegate = self
  }
}

extension AuthService {
  func wakeUpSession() {
    VKSdk.wakeUpSession(VKApi.scope) { [delegate] (state, _) in
      switch state {
      case .initialized:
        print("initialized")
        VKSdk.authorize(VKApi.scope)
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
    print(#function)
    #endif
    if result.token != nil {
      delegate?.authServiceAccessAuthorizationFinished()
    }
  }

  func vkSdkUserAuthorizationFailed() {
    #if DEBUG
    print(#function)
    #endif
    delegate?.authServiceUserAuthorizationFailed()
  }
}

extension AuthService: VKSdkUIDelegate {
  func vkSdkShouldPresent(_ controller: UIViewController!) {
    #if DEBUG
    print(#function)
    #endif
    delegate?.authServiceShouldPresent(viewController: controller)
  }

  func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
    #if DEBUG
    print(#function)
    #endif
  }
}
