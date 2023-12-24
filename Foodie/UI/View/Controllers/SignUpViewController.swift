//
//  SignUpViewController.swift
//  Foodie
//
//  Created by Sedat on 16.12.2023.
//

import UIKit
import FirebaseAuth

//MARK: Kullanıcı kaydı için Auth kullanılması (check) işlemi ve giriş ekranına yönlendirme

class SignUpViewController: UIViewController {
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var showpasswordButton: UIButton!
    var iconClick = true
    var viewModel = SignUpViewModel() //SignUpViewModel'dan ordaki signUp fonksiyonunu çekmek için köprü
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        signUpButton.tintColor = UIColor(red: 113/255, green: 156/255, blue: 111/255, alpha: 1)
    }
    override func viewWillAppear(_ animated: Bool) {
        signUpButton.tintColor = UIColor(red: 113/255, green: 156/255, blue: 111/255, alpha: 1)
    }
    func hideKeyboard() { //GestureRecognizer sayesinde ekranda boş bir yerin tıklanmasıyla klavye gizlemesi
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func showPasswordButtonAction(_ sender: Any) {
        if iconClick{
            passwordTextField.isSecureTextEntry = false
        } else{
            passwordTextField.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    
    
    @IBAction func signUpButtonAction(_ sender: Any) { //kayıt ol butonu kullanıcı check işlemi ve giriş ekranına yönlendirme
        if let email = self.mailTextField.text, let password = self.passwordTextField.text {
            self.viewModel.signUp(email: email, password: password) { _ in
                let alert = UIAlertController(title: "Kayıt", message: "Başarılı bir şekilde kayıt yaptınız. Sizi giriş ekranına yönlendiriyoruz.", preferredStyle: .alert)
                let okeyAction = UIAlertAction(title: "Tamam", style: .cancel){ _ in
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                    controller.modalPresentationStyle = .fullScreen
                    controller.modalTransitionStyle = .flipHorizontal
                    self.present(controller, animated: true, completion: nil)
                }
                alert.addAction(okeyAction)
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func goToSignInButton(_ sender: Any) { //giriş yap ekranına yönlendirme
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        self.present(controller, animated: true, completion: nil)
    }
}
