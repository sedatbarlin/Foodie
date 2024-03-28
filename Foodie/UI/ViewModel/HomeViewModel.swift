//
//  HomeViewModel.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023.
//

import Foundation
import RxSwift
import UIKit  
 
//MARK: Anasayfa görünümü için repo'dan çağırılacak fonksiyonlar 

final class HomeViewModel{
    private let repository = FoodsDaoRepository() //köprü
    //BehaviorSubject RXSwift ile çalışan veri aktarımına ve yüklemeye yardımcı bir nesne
    var foodList = BehaviorSubject<[Foods]>(value: [Foods]())
    private var orderQuantity = BehaviorSubject<Int>(value: 1)
    private var cartFoodList = BehaviorSubject<[CartFoods]>(value: [CartFoods]())
    
    //pdf'deki ürünlerin ID'lerine göre sıralandı
    let drinks = ["1", "3", "7", "12"]
    let deserts = ["2", "6", "14"]
    let meals = ["4", "5","8","9","10","11", "13"]
    
    init() {
        foodList = repository.foodList //yemek listesi initialization
    }
    
    func loadFoods() { //yemekleri yükleme repo dan çağırma
        repository.loadFoods()
    }
    
    func searchFoods(aramaKelimesi: String) { //yemekleri harfe göre arama repo dan çağırma
        repository.searchFoods(aramaKelimesi: aramaKelimesi)
    }
    
    func segmentedFoodList(idList: [String]){ //segment kontrolü ve kategorileme repo dan çağırılması
        repository.categorizedList(listContens: idList)
    }
    private func uploadFoods(){ // yemekleri güncelleme repodan çağırma
        repository.loadFoods()
    }
}
