//
//  FoodDetailViewController.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023.
//

import UIKit
import Kingfisher

//MARK: Anasayfa'da üzerine basılınca açılan Detay ekranının özellikleri

final class FoodDetailViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView! //yemek resmi
    @IBOutlet private weak var pieceLabel: UILabel! //yemek adedi
    @IBOutlet private weak var nameLabel: UILabel! //yemek ismi
    @IBOutlet private weak var totalPriceLabel: UILabel! //toplam fiyat
    
    var food: Foods? //Model Foods dosyasına köprü
    private var piece = 1
    private let viewModel = FoodDetailViewModel() //FoodDetailViewModel'a köprü
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let f = food {
            nameLabel.text = f.yemek_adi
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(f.yemek_resim_adi)") {
                imageView.kf.setImage(with: url) //kf: KingFisher'dan nesne
            }
        }
        pieceLabel.text = String(piece)
        totalPriceLabel.text = "\(String(piece * Int(food!.yemek_fiyat)!)) ₺"
    }
    
    @IBAction private func minusPlusButton(_ sender: UIButton) { //Detay'daki ürün adedi eksiltme artırma butonu
        if sender.tag == 0 {
            if piece > 0{
                piece -= 1
            }
        } else {
            piece += 1
        }
        pieceLabel.text = String(piece)
        totalPriceLabel.text = "\(String(piece * Int(food!.yemek_fiyat)!)) ₺" //eksi artıya göre label güncelleme
    }
    
    
    @IBAction private func addCartButton(_ sender: UIButton) { //Detay'daki sepete ekle butonu
        viewModel.addCart(yemek_adi: food!.yemek_adi, yemek_resim_adi: food!.yemek_resim_adi, yemek_fiyat: Int(food!.yemek_fiyat)!, yemek_siparis_adet: piece, kullanici_adi: "resedat") { _ in
            let alert = UIAlertController(title: "Sepet İşlemi", message: "Ürün başarıyla sepete eklendi.", preferredStyle: .alert)
            let okeyAction = UIAlertAction(title: "Tamam", style: .cancel)
            alert.addAction(okeyAction)
            self.present(alert, animated: true)
        }
    }
}
