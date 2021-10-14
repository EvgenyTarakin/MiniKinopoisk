//
//  AllFilmsViewController.swift
//  MiniKinopoisk
//
//  Created by Евгений Таракин on 24.09.2021.
//

import UIKit

struct Film {
    var name: String
    var originalName: String
    var rating: Double?
    var year: Int
    var image: URL?
    var description: String?
}

class AllFilmsViewController: UIViewController {

    @IBOutlet weak var filmsCollectionView: UICollectionView?
    
    let networkService: FilmsListNetworkService = NetworkService()
    var arrayFilms: [Film] = []
    var helpArrayFilm: [[Film]] = []
    var allYears: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Фильмы"
        
        view.backgroundColor = .white
        
        filmsCollectionView?.backgroundColor = .clear
        filmsCollectionView?.delegate = self
        filmsCollectionView?.dataSource = self
        filmsCollectionView?.register(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionViewCell")
        filmsCollectionView?.register(UINib(nibName: "FilmCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilmCollectionViewCell")
        
        
        loadFilms()
    }
    
    func loadFilms() {
        networkService.getFilmsList { [self] (response, error) in
            guard let results = response?.films
            else { return }
            
            arrayFilms.append(contentsOf: results.map({ (filmResponse) -> Film in
                return Film(name: filmResponse.localized_name, originalName: filmResponse.name, rating: filmResponse.rating, year: filmResponse.year, image: filmResponse.image_url, description: filmResponse.description)
            }))
            
            for film in arrayFilms {
                allYears.append(film.year)
            }
            allYears = Array(Set(allYears))

            allYears.sort { $0 < $1 }
            print(allYears)
            
            for i in 0...allYears.count - 1 {
                helpArrayFilm.append([])
                for film in arrayFilms {
                    if film.year == allYears[i] {
                        helpArrayFilm[i].append(film)
                    }
                }
                helpArrayFilm[i].sort {
                    if let rating0 = $0.rating,
                       let rating1 = $1.rating {
                        rating0 > rating1 }
                    return false
                }
            }
            
            filmsCollectionView?.reloadData()
        }
    }

}


extension AllFilmsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "InfoFilmViewController") as? InfoFilmViewController else { return }
        
        controller.infoFilm = helpArrayFilm[indexPath.section][indexPath.item]
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}


extension AllFilmsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as? HeaderCollectionViewCell else { return UICollectionReusableView() }
        header.yearSectionLabel?.text = "\(helpArrayFilm[indexPath.section][indexPath.item].year)"
        
        return header

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        helpArrayFilm.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return helpArrayFilm[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilmCollectionViewCell", for: indexPath) as? FilmCollectionViewCell else { return UICollectionViewCell() }
        cell.nameFilmLabel?.text = helpArrayFilm[indexPath.section][indexPath.item].name
        cell.originalNameFilmLabel?.text = helpArrayFilm[indexPath.section][indexPath.item].originalName
        
        if helpArrayFilm[indexPath.section][indexPath.item].rating != nil {
            cell.ratingFilmLabel?.text = "\(helpArrayFilm[indexPath.section][indexPath.item].rating!)"
            switch helpArrayFilm[indexPath.section][indexPath.item].rating! {
            case 0...5:
                cell.ratingFilmLabel?.textColor = UIColor("FF0B0B")
            case 5...6,999:
                cell.ratingFilmLabel?.textColor = UIColor("5F5F5F")
            default:
                cell.ratingFilmLabel?.textColor = UIColor("007B00")
            }
        } else {
            cell.ratingFilmLabel?.text = "Нет рейтинга"
            cell.ratingFilmLabel?.textColor = UIColor.black
        }
        
        return cell
    }

}


extension AllFilmsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
}

