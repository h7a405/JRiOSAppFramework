//
//  SignInViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 12/10/2015.
//  Copyright © 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.navigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    convenience init() {
        let nibNameOrNil = String?("SignInViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    @IBAction func didSignedIn() {
        Tool.setToAlreadySignedIn(true, token: "abcdefg")
        UIApplication.sharedApplication().mainWindow().rootViewController = TabBarViewController()
    }
    
    func gotoSignUp() {
        let instance = SignUpViewController()
        instance.navigationController!.navigationBarHidden = false
        self.navigationController!.pushViewController(instance, animated: true)
    }
    
    func gotoResetPassword() {
        let instance = ResetPasswordViewController()
        instance.navigationController!.navigationBarHidden = false
        self.navigationController!.pushViewController(instance, animated: true)
    }
}
extension SignInViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
