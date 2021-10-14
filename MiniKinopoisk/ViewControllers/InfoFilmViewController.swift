//
//  InfoFilmViewController.swift
//  MiniKinopoisk
//
//  Created by Евгений Таракин on 24.09.2021.
//

import UIKit

class InfoFilmViewController: UIViewController {

    @IBOutlet weak var imageFilm: UIImageView?
    @IBOutlet weak var noFilmImageView: UIView?
    @IBOutlet weak var originalNameFilmLabel: UILabel?
    @IBOutlet weak var yearFilmLabel: UILabel?
    @IBOutlet weak var ratingFilmLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    var infoFilm: Film? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = infoFilm?.name
        
        originalNameFilmLabel?.text = infoFilm?.originalName
        
        guard let year = infoFilm?.year else { return }
        yearFilmLabel?.text = "\(year)"
        descriptionLabel?.text = infoFilm?.description
        
        if infoFilm?.rating != nil {
            guard let rating = infoFilm?.rating else { return }
            ratingFilmLabel?.text = "\(rating)"
            switch rating {
            case 0...5:
                ratingFilmLabel?.textColor = UIColor("FF0B0B")
            case 5...6,999:
                ratingFilmLabel?.textColor = UIColor("5F5F5F")
            default:
                ratingFilmLabel?.textColor = UIColor("007B00")
            }
        } else {
            ratingFilmLabel?.text = "Нет рейтинга"
            ratingFilmLabel?.textColor = UIColor.black
        }
        
        noFilmImageView?.backgroundColor = UIColor("ADC9FF")
        noFilmImageView?.layer.borderWidth = 1.5
        noFilmImageView?.layer.borderColor = UIColor.black.cgColor
        
        guard let url = infoFilm?.image else { return }
        if let data = try? Data(contentsOf: url) {
            noFilmImageView?.isHidden = true
            imageFilm?.image = UIImage(data: data)
        } else {
            noFilmImageView?.isHidden = false
        }
    }

}
