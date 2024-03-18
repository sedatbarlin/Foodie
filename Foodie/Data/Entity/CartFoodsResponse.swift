//
//  CartFoodsResponse.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023.
// 

import Foundation 

final class CartFoodsResponse: Codable{ //Codable: JSON cevabını liste olarak alma
    var sepet_yemekler : [CartFoods]?
    var success: Int?
}
