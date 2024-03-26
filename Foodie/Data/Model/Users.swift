//
//  Kisiler.swift
//  Foodie
//
//  Created by Sedat on 18.12.2023.
//
 
import Foundation 

final class Users { //Codable: JSON cevabını liste olarak alma (özel model)
    let email: String 
    let password: String
     
    init(email: String, password: String) {
        self.email = email
        self.password = password 
    }
}
