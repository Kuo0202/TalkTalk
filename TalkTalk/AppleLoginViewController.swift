//
//  AppleLoginViewController.swift
//  TalkTalk
//
//  Created by PeterKuo on 2022/4/13.
//

import UIKit
import AuthenticationServices

class AppleLoginViewController: UIViewController {

    @IBOutlet weak var signInWithAppleButtonView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let authorizationAppleIDButton: ASAuthorizationAppleIDButton = ASAuthorizationAppleIDButton()
        authorizationAppleIDButton.addTarget(self, action: #selector(pressSignInWithAppleButton), for: UIControl.Event.touchUpInside)

        authorizationAppleIDButton.frame = self.signInWithAppleButtonView.bounds
        self.signInWithAppleButtonView.addSubview(authorizationAppleIDButton)
    }


    @objc func pressSignInWithAppleButton() {

    }
}
