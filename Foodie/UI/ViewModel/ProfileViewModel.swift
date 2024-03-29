//
//  ProfileViewModel.swift
//  Foodie
//
//  Created by Sedat on 18.12.2023.
//

import Foundation
import FirebaseAuth

//MARK: Profil sayfası için gerekli olan array içeriği, hesaptan çıkış ve kullanı cı adı getirme  
 
final class ProfileViewModel { //Profile TableView'da içerik olarak görüntülenecek kısımlar 
    var userItems: [String] = [
        "Hesabın","Gizlilik","Premium","Güvenlik","Proxy","Çıkış Yap"
    ]
    
    func signOut(completion: @escaping (Error?) -> Void) { //Auth ile hesaptan çıkış
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error as NSError {
            completion(error)
        }
    }
    
    func bringUserName() -> String? {
        if let bringUserName = Auth.auth().currentUser?.email { //mevcut kullanıcı auth bilgisini alma
            let components = bringUserName.components(separatedBy: "@") //email'deki username kısmını getirme
            if components.count == 2 {
                var username = components[0]
                username = username.prefix(1).capitalized + username.dropFirst()
                return username
            }
        }
        return nil
    }
}
