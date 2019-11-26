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
    
    @IBOutlet weak var pokemonCardImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let pokemon = pokemon {
            ImageController.getImage(for: pokemon.imageUrl ?? "") { (image) in
                self.pokemonCardImage.image = image
            }
        } else {
            print("Pokemon image is nil")
        }
    }//end viewWillApper
    
}//end class
