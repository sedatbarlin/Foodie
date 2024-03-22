//
//  FoodsDaoRepository.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023.
//
 
import Foundation
import RxSwift 
import Alamofire   
import UIKit 
import FirebaseFirestore
import FirebaseAuth

//MARK: REPO işlemleri

final class FoodsDaoRepository {
    var foodList = BehaviorSubject<[Foods]>(value: [Foods]())
    var cartFoodsList = BehaviorSubject<[CartFoods]>(value: [CartFoods]())
    var totalPrice = BehaviorSubject<Int>(value: Int())
    
    //MARK: Tüm yemekleri listele - yükle fonksiyonu
    func loadFoods() {
        let url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php"
        AF.request(url, method: .get).response { response in
            if let data = response.data {
                do{
                    let response = try JSONDecoder().decode(FoodsResponse.self, from: data)
                    if let list = response.yemekler {
                        self.foodList.onNext(list)
                    }
                }catch{
                    print("yemek listeleme hatası")
                }
            }
        }
    }
    
    //MARK: Sepete yemek ekleme
    func addCart(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String, completion: @escaping (Bool) ->Void){
        let url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
        let parameters: [String: Any] = ["yemek_adi": yemek_adi, "yemek_resim_adi": yemek_resim_adi, "yemek_fiyat": yemek_fiyat, "yemek_siparis_adet": yemek_siparis_adet, "kullanici_adi": kullanici_adi]
        AF.request(url, method: .post, parameters: parameters).response { response in
            switch response.result {
            case .success(_):
                completion(false)
            case .failure(_):
                completion(true)
            }
        }
    }
    
    //MARK: Sepetten yemek silme ve total ücreti güncelleme
    func deleteFoods(sepet_yemek_id: Int, kullanici_adi: String) {
        let params: Parameters = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi]
        let url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php"
        AF.request(url,method: .post,parameters: params).response { response in
            if let data = response.data {
                do{
                    _ = try JSONDecoder().decode(CartResponse.self, from: data)
                    self.bringCartFoods(kullanici_adi: kullanici_adi) { _ , error in
                        if error != nil {
                            self.totalPrice.onNext(0)
                        } else {
                        }
                    }
                }catch{
                    print("sepetten yemek silme hatası")
                }
            }
        }
    }
    
    //MARK: Sepetteki yemekleri getirme işlemi - adet ve kullanıcı adı güncelleme
    func bringCartFoods(kullanici_adi: String) {
        var amount = 0
        let params: Parameters = ["kullanici_adi": kullanici_adi]
        let url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php"
        AF.request(url, method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(CartFoodsResponse.self, from: data)
                    if let list = response.sepet_yemekler {
                        self.cartFoodsList.onNext(list)
                        for food in list {
                            amount += Int(food.yemek_siparis_adet)! * Int(food.yemek_fiyat)!
                            self.totalPrice.onNext(amount)
                        }
                    }
                } catch {
                    print("sepetten yemek getirirken hata")
                }
            }
        }
    }
    
    //MARK: Alamofire sayesinde yemek arama - veri çekme işlemi
    func searchFoods(aramaKelimesi:String){
        var searchFoods = [Foods]()
        if aramaKelimesi != "" {
            let url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php"
            AF.request(url, method: .get).response { response in
                if let data = response.data {
                    do{
                        let response = try JSONDecoder().decode(FoodsResponse.self, from: data)
                        if let list = response.yemekler {
                            for foods in list {
                                if foods.yemek_adi.contains(aramaKelimesi) {
                                    searchFoods.append(foods)
                                }
                            }
                            self.foodList.onNext(searchFoods)
                        }
                    }catch{
                        print("tüm yemekler getirilirken hata")
                    }
                }
            }
        } else {
            loadFoods()
        }
    }
    
    //MARK: Auth ile kullanıcı giriş işlemi ve Service'ye aktarma - karşılaştırma
    func signUp(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        if let mail = email, let password = password {
            let user = Users(email: mail, password: password)
            let data = ["email": user.email, "password": user.password]
            Auth.auth().createUser(withEmail: mail, password: password) { authResult, error in
                if error == nil {
                    let myUsers = Firestore.firestore()
                    let userCollection = myUsers.collection("Users").document(authResult?.user.uid ?? "").collection(user.email)
                    userCollection.document("UserInfo").setData(data) { error in
                        if error != nil {
                            completion(false)
                        } else {
                            completion(true)
                        }
                    }
                } else {
                    completion(false)
                }
            }
        }
    }
    
    //MARK: Auth ile kullanıcı giriş işlemi ve Service'ye aktarma - karşılaştırma
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _ , error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    //MARK: Yemekleri kategorilere ayırmak için tüm yemekleri getirme
    func categorizedList(listContens: [String]) {
        let url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php"
        AF.request(url, method: .get).response { response in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(FoodsResponse.self, from: data)
                    if let list = response.yemekler {
                        let filteredList = list.filter { food in //yemekleri id'ye göre sınıflandırma
                            return listContens.contains(food.yemek_id)
                        }
                        self.foodList.onNext(filteredList)
                    }
                } catch {
                    print("kategorideki tüm yemekleri getirirken hata")
                }
            }
        }
    }
    
    //MARK: Sepetteki yemekleri çekme (post)
    func bringCartFoods(kullanici_adi: String, completion: @escaping([CartFoods]?, Error?) -> Void) {
        var amount = 0
        let params: Parameters = ["kullanici_adi": kullanici_adi]
        let url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php"
        AF.request(url, method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(CartFoodsResponse.self, from: data)
                    if let list = response.sepet_yemekler {
                        self.cartFoodsList.onNext(list)
                        for food in list {
                            amount += Int(food.yemek_siparis_adet)! * Int(food.yemek_fiyat)!
                            self.totalPrice.onNext(amount)
                        }
                        completion(list, nil)
                    }
                } catch {
                    print("sepetteki yemekleri getirme hatası")
                    completion(nil, error)
                }
            }
        }
    }
    
    //MARK: Kullanıcı bilgilerinin Firestore service'den çekme
    private func fetchUserData(completion: @escaping (Users) -> Void) {
        let myUsers = Firestore.firestore()
        if let user = Auth.auth().currentUser {
            let userCollection = myUsers.collection("Users").document(user.uid).collection(user.email!).document("UserInfo")
            userCollection.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let userData = document.data() {
                        if let email = userData["email"] as? String, let password = userData["password"] as? String {
                            let user = Users(email: email, password: password)
                            completion(user)
                        }
                    }
                } else {
                    print("kullanıcı bilgisi çekme hatası")
                }
            }
        }
    }
}
