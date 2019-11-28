//
//  PokemonDetailViewController.swift
//  PokemonCards
//
//  Created by Artjoms Vorona on 26/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: Pokemon?
    var cardImage: UIImage?
    var favoriteCards: [String: Bool] = [:]
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var pokemonCardImage: UIImageView!
    @IBOutlet weak var markAsFavoriteButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadUserDefaults()
        
        if let pokemon = pokemon {
            title = pokemon.name
            
            ImageController.getImage(for: pokemon.imageUrl ?? "") { (image) in
                self.pokemonCardImage.image = image
                self.cardImage = image
            }
            
            updateFavoriteButtonTitle(id: pokemon.id)
            
        } else {
            print("Pokemon image is nil")
        }
    }//end viewWillAppear
    
    //IBActions
    @IBAction func shareBarButtonTapped(_ sender: UIBarButtonItem) {
        guard let image = cardImage else {
            basicAlert(title: "Error!", message: "Unable to share. Apparently there is no image to share.")
            return }
        ShareManager.share(image: image, text: "Here is a Pokemon card I like.", vc: self)
    }
    
    
    @IBAction func markAsFavoriteButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        print("Favorite tapped")
        if favoriteCards[pokemon.id] == false {
            favoriteCards[pokemon.id] = true
        } else {
            favoriteCards[pokemon.id] = false
        }
        userDefaults.set(favoriteCards, forKey: "favoriteCards")
        updateFavoriteButtonTitle(id: pokemon.id)
    }
    
    //MARK: Functions
    
    func loadUserDefaults() {
        if let dict = userDefaults.dictionary(forKey: "favoriteCards") as? [String: Bool] {
            favoriteCards = dict
        }
    }
    
    func updateFavoriteButtonTitle(id: String) {
        if favoriteCards[id] == false {
            markAsFavoriteButton.setTitle("Mark as favorite", for: .normal)
        } else {
            markAsFavoriteButton.setTitle("Unmark as favorite", for: .normal)
        }
    }
    
}//end class
