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
    
    @IBOutlet weak var pokemonCardImage: UIImageView!
    @IBOutlet weak var markAsFavoriteButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let pokemon = pokemon {
            title = pokemon.name
            
            ImageController.getImage(for: pokemon.imageUrl ?? "") { (image) in
                self.pokemonCardImage.image = image
                self.cardImage = image
            }
            
            if Favorite.cards[pokemon.id] == false {
                markAsFavoriteButton.setTitle("Mark as favorite", for: .normal)
            } else {
                markAsFavoriteButton.setTitle("Unmark as favorite", for: .normal)
            }
            
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
        if Favorite.cards[pokemon.id] == false {
            Favorite.cards[pokemon.id] = true
            markAsFavoriteButton.setTitle("Unmark as favorite", for: .normal)
        } else {
            Favorite.cards[pokemon.id] = false
            markAsFavoriteButton.setTitle("Mark as favorite", for: .normal)
        }
    }
    
}//end class
