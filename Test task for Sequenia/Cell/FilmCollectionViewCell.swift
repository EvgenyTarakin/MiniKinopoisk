//
//  FilmCollectionViewCell.swift
//  Test task for Sequenia
//
//  Created by Евгений Таракин on 24.09.2021.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView?
    @IBOutlet weak var nameFilmLabel: UILabel?
    @IBOutlet weak var originalNameFilmLabel: UILabel?
    @IBOutlet weak var ratingFilmLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView?.backgroundColor = UIColor("ADC9FF")
        backView?.layer.borderWidth = 1.5
        backView?.layer.borderColor = UIColor.black.cgColor
    }

}
