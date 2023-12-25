//
//  FoodsCollectionViewCell.swift
//  Foodie
//
//  Created by Sedat on 16.12.2023.
//

import UIKit

//MARK: Anasayfa collectionview'da listelenen öğeler ve sepete ekleme butonu

final class FoodsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    var addButton: (() -> ())?
    
    @IBAction func addCartButton(_ sender: Any) {
        addButton?()
    }
}
