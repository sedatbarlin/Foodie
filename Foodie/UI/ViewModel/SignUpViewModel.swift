//
//  SignUpViewModel.swift
//  Foodie
//
//  Created by Sedat on 16.12.2023.
//

import Foundation
import FirebaseAuth

//MARK: Kayıt ekranı için repodan func çekme ve kayıt metodu oluşturma

class SignUpViewModel{
    let repository = FoodsDaoRepository()
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        repository.signUp(email: email, password: password) { sonuc in
            completion(sonuc)
        }
    }
}
