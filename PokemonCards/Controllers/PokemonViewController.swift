//
//  ViewController.swift
//  PokemonCards
//
//  Created by Artjoms Vorona on 26/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import CoreData
import UIKit

class PokemonViewController: UIViewController {
    
    var pokemons: [Pokemon] = []
    var favoriteCards: [String: Bool] = [:]
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemon cards"
        
        loadUserDefaults()
        getPokemonData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        
        loadUserDefaults()
    }
    
    func getPokemonData() {
        let url = URL(string: "https://api.pokemontcg.io/v1/cards")!
        
        NetworkController.performRequest(for: url, httpMethod: .Get) { (data, error) in
            if let error = error {
                print("Getting error from url: \(url.absoluteString), error: ", error.localizedDescription)
            }
            
            if let data = data {
                do {
                    let cardData = try JSONDecoder().decode(Cards.self, from: data)
                    self.pokemons = cardData.cards
                    
                    //setting dict of favorite cards
                    for pokemon in self.pokemons {
                        if self.favoriteCards[pokemon.id] == nil {
                            self.favoriteCards[pokemon.id] = false
                        }
                    }
                    self.userDefaults.set(self.favoriteCards, forKey: "favoriteCards")
                    
                } catch {
                    print("Failed to encode pokemon data, error: ", error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Data is nil!!!")
            }
            
        }//end networkController
    }//end getPokemonData
    
    func loadUserDefaults() {
        if let dict = userDefaults.dictionary(forKey: "favoriteCards") as? [String: Bool] {
            favoriteCards = dict
        }
    }
    
}//end class

extension PokemonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell()}
        
        let pokemon = pokemons[indexPath.row]
        
        //setting card name
        cell.nameLabel?.text = pokemon.name
        
        //setting details of the card
        var detailText = "Id: \(pokemon.id)" + "\nSupertype: \(pokemon.supertype)" + "\nSubtype: \(pokemon.subtype)"
        if let types = pokemon.types {
            detailText += "\nTypes: \(types.joined(separator: ","))"
        }
        cell.detailsLabel?.text = detailText
        cell.detailsLabel?.numberOfLines = 0
        
        //setting card HP
        var hpText = ""
        if let hp = pokemon.hp {
            hpText = "\(hp) HP"
        }
        cell.additionalDetailsLabel.text = hpText
        
        //setting if card is Favorite
        if favoriteCards[pokemon.id] == true {
            cell.favoriteImage.image = UIImage(systemName: "star.fill")
            cell.favoriteImage.alpha = 1
        } else {
            cell.favoriteImage.image = UIImage(systemName: "star")
            cell.favoriteImage.alpha = 0.5
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailSegueID" {
            if let detailVC = segue.destination as? PokemonDetailViewController, let row = tableView.indexPathForSelectedRow?.row {
                detailVC.pokemon = pokemons[row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}//end extension

