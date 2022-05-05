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
        
        let authorizationAppleIDButton: ASAuthorizationAppleIDButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .whiteOutline)
        authorizationAppleIDButton.addTarget(self, action: #selector(pressSignInWithAppleButton), for: UIControl.Event.touchUpInside)
        
        authorizationAppleIDButton.frame = CGRect(x: 0, y: 0, width: self.signInWithAppleButtonView.bounds.width * 0.9, height: self.signInWithAppleButtonView.bounds.height)
        self.signInWithAppleButtonView.addSubview(authorizationAppleIDButton)
    }
    
    
    @objc func pressSignInWithAppleButton() {
        
        let authorizationAppleIDRequest: ASAuthorizationAppleIDRequest = ASAuthorizationAppleIDProvider().createRequest()
        authorizationAppleIDRequest.requestedScopes = [.fullName, .email]
        
        let controller: ASAuthorizationController = ASAuthorizationController(authorizationRequests: [authorizationAppleIDRequest])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
}

extension AppleLoginViewController: ASAuthorizationControllerDelegate {
    
    /// 授權成功
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            print("user: \(appleIDCredential.user)")
            print("fullName: \(String(describing: appleIDCredential.fullName))")
            print("Email: \(String(describing: appleIDCredential.email))")
            print("realUserStatus: \(String(describing: appleIDCredential.realUserStatus))")
            
            let realName: String = String(describing: appleIDCredential.fullName)
            let email: String = String(describing: appleIDCredential.email)
            
            registerUser(userID: appleIDCredential.user, realName: realName , email: email) { dict, error in
                
            }
        }
    }
    
    /// 授權失敗
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        switch (error) {
        case ASAuthorizationError.canceled:
            break
        case ASAuthorizationError.failed:
            break
        case ASAuthorizationError.invalidResponse:
            break
        case ASAuthorizationError.notHandled:
            break
        case ASAuthorizationError.unknown:
            break
        default:
            break
        }
        
        print("didCompleteWithError: \(error.localizedDescription)")
    }
}

extension AppleLoginViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension AppleLoginViewController {
    
    func registerUser(userID: String, realName: String, email: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        
//        let body: [String: Any] = ["userID": userID, "realName": realName, "Email": email, ]
//        let api_url = "https://orange-sea.site/talk/register"
//        let url = URL(string: api_url)!
//        var request = URLRequest(url: url)
//
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
//            request.httpBody = jsonData
//        } catch let e {
//            print(e)
//        }
//
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJSON = responseJSON as? [String: Any] {
//                print(responseJSON)
//            }
//        }
//
//        task.resume()
    }

    func registerUserRequest() {

        RegisterUserRequest(userInfoBody: RegisterUserBody(userID: "", realName: "", Email: "")).send { result in

            switch result {
                case .success(let response):
                    print("success \(response.result)")

                case .failure(let error):
                    print("error \(error)")
            }
        }
    }
}
