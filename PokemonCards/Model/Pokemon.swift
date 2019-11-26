//
//  Pokemon.swift
//  PokemonCards
//
//  Created by Artjoms Vorona on 26/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    
    let name: String
    var imageUrl: String?
    let number: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl
        case number
    }
}

struct Card: Decodable {
    let cards: [Pokemon]
}
