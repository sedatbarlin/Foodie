//
//  Extensions.swift
//  Foodie
//
//  Created by Sedat on 19.12.2023.
//

import Foundation
import UIKit 
 
//MARK: Home CollectionView (collectionview'da ürünlerin listelenmesi ve sepete ekleme işlemi)

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodsCollectionViewCell
        let yemek = foodList[indexPath.row]
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi)") {
            cell.imageView.kf.setImage(with: url)
        }
        cell.nameLabel.text = yemek.yemek_adi
        cell.priceLabel.text = "\(yemek.yemek_fiyat) ₺"
        cell.addButton = {[unowned self] in
            let chosenFood = foodList[indexPath.row]
            detailViewModel.addCart(yemek_adi: chosenFood.yemek_adi, yemek_resim_adi: chosenFood.yemek_resim_adi, yemek_fiyat: Int(chosenFood.yemek_fiyat)!, yemek_siparis_adet: 1, kullanici_adi: "resedat") { _ in
                let alert = UIAlertController(title: "Sepet", message: "Ürün başarıyla sepete eklendi.", preferredStyle: .alert)
                let okeyAction = UIAlertAction(title: "Tamam", style: .cancel)
                alert.addAction(okeyAction)
                self.present(alert, animated: true)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yemek = foodList[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: SearchBar (tüm ürünler arasından harf odaklı arama işlemi)
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchFoods(aramaKelimesi: searchText)
    }
}

//MARK: Cart TableView (sepetteki yemeklerin tableview'da listelenmesi ve silme işlemi)
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartViewCell", for: indexPath) as! CartTableViewCell
        let food = foodList[indexPath.row]
        if let piecePrice = Int(food.yemek_fiyat), let orderPiece = Int(food.yemek_siparis_adet) {
            cell.priceLabel.text = "\(String(piecePrice * orderPiece)) ₺"
        }
        cell.pieceLabel.text = "\(food.yemek_siparis_adet) adet"
        cell.foodNameLabel.text = food.yemek_adi
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi)") {
            cell.foodImageView.kf.setImage(with: url)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let food = self.foodList[indexPath.row]
            self.viewModel.deleteCartFoods(sepet_yemek_id: Int(food.sepet_yemek_id!)!, kullanici_adi: food.kullanici_adi)
            self.foodList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let alert = UIAlertController(title: "Silme İşlemi", message: "Ürün başarılı bir şekilde sepetten silindi.", preferredStyle: .alert)
            let okeyAction = UIAlertAction(title: "Tamam", style: .cancel)
            alert.addAction(okeyAction)
            self.present(alert, animated: true)
        }
    }
}

//MARK: Profile TableView (kullanıcının profil bilgilerinin listelenmesi ve çıkış yapma işlemi)
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileTableViewCell
        cell.cellLabel.text = viewModel.userItems[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            logOutOfAccount()
        }
    }
}
