//
//  SignInViewController.swift
//  Foodie
//
//  Created by Sedat on 16.12.2023.
//
 
import UIKit
import FirebaseAuth

//MARK: Kullanıcı girişi için Auth kullanılması (check) işlemi ve kayıt ekranına yönlendirme

final class SignInViewController: UIViewController {
    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signInButton: UIButton!
    //var viewModel = SignInViewModel() //SignInViewModel'dan
    private let repository = FoodsDaoRepository() //Repo'dan köprü sayesinde giriş işlemi yapılması
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        configureButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        configureButton()
    }
    private func configureButton(){
        signInButton.tintColor = UIColor(red: 113/255, green: 156/255, blue: 111/255, alpha: 1)
    }
    
    @IBAction private func showPasswordButtonAction(_ sender: Any) {
        if iconClick{
            passwordTextField.isSecureTextEntry = false
        } else{
            passwordTextField.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    
    private func hideKeyboard() { //GestureRecognizer sayesinde ekranda boş bir yerin tıklanmasıyla klavye gizlemesi
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc private func closeKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction private func signInButtonAction(_ sender: UIButton) { //giriş butonu kullanıcı check işlemi ve uygulamaya yönlendirme
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

    @IBAction private func goToSignUpButton(_ sender: UIButton) { //kayıt ol ekranına yönlendirme
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        self.present(controller, animated: true, completion: nil)
    }
}

