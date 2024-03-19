//
//  ProfileTableViewCell.swift
//  Foodie
//
//  Created by Sedat on 18.12.2023.
//

import UIKit

//MARK: Kullanıcı tableview'da cell içerisinde bulunan label ve seçili öğe işlemi
  
final class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
