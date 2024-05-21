//
//  CharactersListViewController.swift
//  Heroes
//
//  Created by Amirov Foma on 13.05.2024.
//

import UIKit

final class CharactersListViewController: UITableViewController {
    private let networkManager = NetworkManager.shared
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        networkManager.fetchCharacters(from: Link.urlApi.url) { [unowned self] result in
            switch result {
            case .success(let characters):
                self.characters = characters
                self.tableView.reloadData()
            case .failure(let error):
                printContent(error)
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        guard let cell = cell as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: characters[indexPath.row])
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = characters[indexPath.row]
        
        let characterDetailsVC = segue.destination as? CharacterDetailsViewController
        characterDetailsVC?.character = character
    }
}
