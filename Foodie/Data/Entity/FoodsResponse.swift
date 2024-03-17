//
//  FoodsResponse.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023.
//
 
import Foundation

final class FoodsResponse: Codable{ //Codable: JSON cevabını liste olarak alma
    var yemekler: [Foods]?
    var success :Int?
}
