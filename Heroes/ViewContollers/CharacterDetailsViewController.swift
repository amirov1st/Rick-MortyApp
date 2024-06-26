//
//  HeroDetails.swift
//  Heroes
//
//  Created by Amirov Foma on 13.05.2024.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {

    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    var character: Character!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeCharacter(character)
    }
 
    private func composeCharacter(_ character: Character) {
        descriptionLabel.text = character.description
        networkManager.fetchImage(url: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
