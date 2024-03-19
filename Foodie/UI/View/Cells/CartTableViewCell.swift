//
//  CartTableViewCell.swift
//  Foodie
//
//  Created by Sedat on 16.12.2023.
//

import UIKit  

//MARK: Sepetteki tableview'da listelenen öğelerin bilgileri

final class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pieceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
