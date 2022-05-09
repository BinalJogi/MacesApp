//
//  PeopleCollectionViewCell.swift
//  MacesApp
//
//  Created by Binal Jogi on 06/05/2022.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterImageViw: UIImageView!
    
    
    func configureData(people: People) {
        nameLabel.text = people.name
        titleLabel.text = people.jobTitle
        setPosterImageView(imageURL: people.poster)
        self.contentView.layer.borderColor = UIColor.blue.cgColor
        self.contentView.layer.borderWidth = 1.0
        
        posterImageViw.layer.cornerRadius = 35
        posterImageViw.clipsToBounds = true
    }
    
    private func setPosterImageView(imageURL:String) {
        ImageDownloader.shared.getImage(url: imageURL) { [weak self] data in
            DispatchQueue.main.async {
                self?.posterImageViw.image = UIImage(data: data)
            }
        }
    }
}

