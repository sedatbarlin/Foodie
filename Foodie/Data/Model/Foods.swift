//
//  Foods.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023.
//

import Foundation  
 
final class Foods: Codable{ //Codable: JSON cevabını liste olarak alma (özel model)
    let yemek_id: String 
    let yemek_adi: String
    let yemek_resim_adi: String
    let yemek_fiyat: String
    
    init(yemek_id: String, yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String) {
        self.yemek_id = yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
    }
}
