//
//  CartFoods.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023.
// 
  
import Foundation

final class CartFoods: Codable{ //Codable: JSON cevabını liste olarak alma (özel model)
    let sepet_yemek_id: String?
    let yemek_adi: String
    let yemek_resim_adi: String
    let yemek_fiyat: String
    let yemek_siparis_adet: String
    let kullanici_adi: String
    
    init(sepet_yemek_id: String, yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String, yemek_siparis_adet: String, kullanici_adi: String) {
        self.sepet_yemek_id = sepet_yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
        self.yemek_siparis_adet = yemek_siparis_adet
        self.kullanici_adi = kullanici_adi
    }
}
