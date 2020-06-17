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
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    weak var delegate: AuthServicesDelegate?
    
    func wakeUpSession() {
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) {[delegate] (state, error) in
            switch state {
            
            case .initialized:
                VKSdk.authorize(scope)
        
            case .authorized:
                print("authorized")
                delegate?.authServicesSignIn()
            default:
                delegate?.authServicesSignInDidFail()
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
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
