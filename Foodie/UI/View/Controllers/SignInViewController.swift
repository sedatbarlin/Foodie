//
//  SignInViewController.swift
//  Foodie
//
//  Created by Sedat on 16.12.2023.
//

import UIKit
import FirebaseAuth

//MARK: Kullanıcı girişi için Auth kullanılması (check) işlemi ve kayıt ekranına yönlendirme

class SignInViewController: UIViewController {
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    //var viewModel = SignInViewModel() //SignInViewModel'dan
    private let repository = FoodsDaoRepository() //Repo'dan köprü sayesinde giriş işlemi yapılması
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.tintColor = UIColor(red: 113/255, green: 156/255, blue: 111/255, alpha: 1)
        hideKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        signInButton.tintColor = UIColor(red: 113/255, green: 156/255, blue: 111/255, alpha: 1)
    }
    
    @IBAction func showPasswordButtonAction(_ sender: Any) {
        if iconClick{
            passwordTextField.isSecureTextEntry = false
        } else{
            passwordTextField.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    
    
    func hideKeyboard() { //GestureRecognizer sayesinde ekranda boş bir yerin tıklanmasıyla klavye gizlemesi
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) { //giriş butonu kullanıcı check işlemi ve uygulamaya yönlendirme
        if let email = mailTextField.text, let password = passwordTextField.text {
            repository.signIn(email: email, password: password) { error in
                if error != nil {
                    let alert = UIAlertController(title: "UYARI", message: "Kullanıcı adı veya şifre hatalı. Lütfen tekrar deneyiniz, eğer hesabınız yoksa lütfen kayıt olunuz.", preferredStyle: .alert)
                    let okeyAction = UIAlertAction(title: "Tamam", style: .cancel){ _ in
                    }
                    alert.addAction(okeyAction)
                    self.present(alert, animated: true)
                }else {
                    let alert = UIAlertController(title: "Hoşgeldiniz", message: "Başarılı bir şekilde giriş yaptınız.", preferredStyle: .alert)
                    let okeyAction = UIAlertAction(title: "Tamam", style: .cancel){ _ in
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabBarViewController") as! CustomTabBarViewController
                        controller.modalPresentationStyle = .fullScreen
                        controller.modalTransitionStyle = .flipHorizontal
                        self.present(controller, animated: true, completion: nil)
                    }
                    alert.addAction(okeyAction)
                    self.present(alert, animated: true)
                }
            }
        }
    }

    @IBAction func goToSignUpButton(_ sender: UIButton) { //kayıt ol ekranına yönlendirme
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        self.present(controller, animated: true, completion: nil)
    }
}

