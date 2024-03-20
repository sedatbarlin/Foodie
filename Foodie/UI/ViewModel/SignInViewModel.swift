//
//  SignInViewModel.swift
//  Foodie
//
//  Created by Sedat on 16.12.2023.
//

import Foundation
import FirebaseAuth
 
//MARK: Giriş ekranı için repodan func çekme ve giriş metodu oluşturma

final class SignInViewModel{
    private let repository = FoodsDaoRepository()
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        repository.signIn(email: email, password: password) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}
