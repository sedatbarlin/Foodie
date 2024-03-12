//
//  FoodDetailViewModel.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023.
//

import Foundation 
import UIKit
import RxSwift

//MARK: Detay sayfa görünümü için repo'dan çağırılacak addCart fonksiyonu  

final class FoodDetailViewModel{
    private let repository = FoodsDaoRepository()
    
    func addCart(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String, completion: @escaping (Bool) -> Void) {
        repository.addCart(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: "resedat") { success in
            completion(success)
        }
    }
}
