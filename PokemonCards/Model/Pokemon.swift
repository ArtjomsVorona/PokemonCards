//
//  Pokemon.swift
//  PokemonCards
//
//  Created by Artjoms Vorona on 26/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    
    let id: String
    let name: String
    var imageUrl: String?
    let supertype: String
    let subtype: String
    let number: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl
        case supertype
        case subtype
        case number
    }
}

struct Cards: Decodable {
    let cards: [Pokemon]
}
