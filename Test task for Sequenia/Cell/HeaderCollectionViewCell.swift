//
//  HeaderCollectionViewCell.swift
//  Test task for Sequenia
//
//  Created by Евгений Таракин on 26.09.2021.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView?
    @IBOutlet weak var yearSectionLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView?.backgroundColor = UIColor("BABABA")
        backView?.layer.borderWidth = 1.5
        backView?.layer.borderColor = UIColor.black.cgColor
    }

}
