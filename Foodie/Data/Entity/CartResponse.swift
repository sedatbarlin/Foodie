//
//  CRUDResponse.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023.
// 

import Foundation
 
final class CartResponse: Codable{ //Codable: JSON cevabını liste olarak alma
    var success: Int?
    var message: String? 
}
