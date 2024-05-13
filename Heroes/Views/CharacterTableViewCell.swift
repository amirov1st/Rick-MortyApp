//
//  CharacterTableViewCell.swift
//  Heroes
//
//  Created by Amirov Foma on 13.05.2024.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var characterImageView: UIImageView! {
        didSet {
            characterImageView.layer.cornerRadius = characterImageView.frame.height / 5
        }
    }
    
    private let networkManager = NetworkManager.shared
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
        
//        characterImageView.kf.setImage(with: character.image)
        networkManager.fetchImage(url: character.image) { [weak self] imageData in
            self?.characterImageView.image = UIImage(data: imageData)
        }
    }
}
