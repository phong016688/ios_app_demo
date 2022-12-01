//
//  RegisterViewController.swift
//  Firebase App
//
//  Created by Vo Duc Phong on 30/11/2022.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldRepeatPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerClickListener(_ sender: Any) {
        guard let email = textFieldEmail.text else { return }
        guard let password = textFieldPassword.text else { return }
        guard let repeatPass = textFieldRepeatPassword.text else {return}
        if(repeatPass != password) {return}
        self.createAccountOnFirebase(username: email, password: password)
        
    }
    
    private func createAccountOnFirebase(username: String, password: String){
        Auth.auth().createUser(withEmail: username, password: password){result, error in
            if error != nil {
                let errorMessage = error?.localizedDescription ?? ""
                print("error: \(errorMessage)")
                self.showAlertError(errorMessage: errorMessage)
            }else {
                //goto login
                self.performSegue(withIdentifier: "registerToLogin", sender: self)
            }
        }
    }
    
    private func showAlertError(errorMessage: String){
        let alert = UIAlertController(title: "Error",message: errorMessage,preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok",style: UIAlertAction.Style.default,handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
