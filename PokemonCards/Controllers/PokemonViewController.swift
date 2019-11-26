//
//  ViewController.swift
//  PokemonCards
//
//  Created by Artjoms Vorona on 26/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    var pokemons: [Pokemon] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemon cards"
        
        getPokemonData()
    }
    
    func getPokemonData() {
        let url = URL(string: "https://api.pokemontcg.io/v1/cards")!
        
        NetworkController.performRequest(for: url, httpMethod: .Get) { (data, error) in
            if let error = error {
                print("Getting error from url: \(url.absoluteString), error: ", error.localizedDescription)
            }
            
            if let data = data {
                do {
                    let cardData = try JSONDecoder().decode(Card.self, from: data)
                    self.pokemons = cardData.cards
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
    
}//end class

extension PokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        cell.textLabel?.text = pokemons[indexPath.row].name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailSegueID" {
            if let detailVC = segue.destination as? PokemonDetailViewController, let row = tableView.indexPathForSelectedRow?.row {
                detailVC.pokemon = pokemons[row]
            }
        }
    }
    
}//end extension

