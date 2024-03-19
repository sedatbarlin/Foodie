//
//  ProfileViewController.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023.
//

import UIKit
import FirebaseAuth

//MARK: Kullanıcı profil ekranı özellikleri ve alert'lar  

final class ProfileViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var nameLabel: UILabel! //Profil'de üstte görüntülenecek label
    let viewModel = ProfileViewModel() //ProfileViewModel'a köprü çünkü kullanıcı bilgisini ordan getirecek
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setProfileLabel()
    }
    
    private func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    private func setProfileLabel(){
        if let username = viewModel.bringUserName() {
            nameLabel.text = "Merhaba " + username //Profil sayfasında email'deki ismin görünmesi
        }
    }
    private func errorAlert(message: String) { //ProfileViewController için alert
        let alert = UIAlertController(title: "ERROR!", message: message, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okeyAction)
        present(alert, animated: true, completion: nil)
    }
    func logOutOfAccount() { //hesaptan çıkış yapma ve giriş sayfasına yönlendirme
        let alert = UIAlertController(title: "Çıkış Yap", message: "Çıkış yapmak üzeresiniz. Emin misiniz?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "İptal", style: .default, handler: nil)
        let logOutAction = UIAlertAction(title: "Çıkış Yap", style: .destructive) { _ in self.viewModel.signOut { [weak self] error in
            if error != nil {
                self?.errorAlert(message: "hesaptan çıkış yapamama hatası")
            } else {
                let controller = self?.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                controller.modalPresentationStyle = .fullScreen
                controller.modalTransitionStyle = .partialCurl
                self?.present(controller, animated: true, completion: nil)
            }
        }
        }
        alert.addAction(cancelAction)
        alert.addAction(logOutAction)
        present(alert, animated: true, completion: nil)
    }
}
