//
//  AuthService.swift
//  NewsFeed_v2
//
//  Created by Egor on 16.06.2020.
//  Copyright © 2020 TASS. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServicesDelegate: class {
    func authServicesShouldShow(viewController: UIViewController)
    func authServicesSignIn()
    func authServicesSignInDidFail()
}

class AuthServices: NSObject, VKSdkDelegate, VKSdkUIDelegate {

    private let appID: String = "7510043"
    private let vkSdk: VKSdk
    
    weak var delegate: AuthServicesDelegate?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        print("VKSdk.initialaze")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    
    func wakeUpSession() {
        let scope = ["wall, friends"]
        VKSdk.wakeUpSession(scope) {[delegate] (state, error) in
            switch state {
            
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
                delegate?.authServicesSignIn()
            default:
                print("authServicesSignInDidFail")
                delegate?.authServicesSignInDidFail()
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            print(result.token as Any)
            delegate?.authServicesSignIn()
            print(result.token as Any)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
         print(#function)
        delegate?.authServicesSignInDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
         print(#function)
        delegate?.authServicesShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
         print(#function)
    }
}
