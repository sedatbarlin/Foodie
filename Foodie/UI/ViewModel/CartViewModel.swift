//
//  CartViewModel.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023. 
//

import Foundation
import UIKit
import RxSwift 

//MARK: Sepet ekranı görünümü için repo'dan çağırılacak fonksiyonlar
 
final class CartViewModel{
    private let repository = FoodsDaoRepository()
    var foodList = BehaviorSubject<[CartFoods]>(value: [CartFoods]())
    var totalPrice = BehaviorSubject<Int>(value: Int())

    init() {
        foodList = repository.cartFoodsList
        totalPrice = repository.totalPrice
    }
    
    func bringCartFoods(kullanici_adi: String) {
        repository.bringCartFoods(kullanici_adi: kullanici_adi)
    }
    
    func deleteCartFoods(sepet_yemek_id: Int, kullanici_adi: String) {
        repository.deleteFoods(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
}
