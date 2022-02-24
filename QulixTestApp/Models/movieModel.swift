//
//  movieModel.swift
//  QulixTestApp
//
//  Created by macbook on 22.02.22.
//

import UIKit

class Movies: Decodable {
    let id: Int
    let title: String
    var overview: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
    }
    
    init(id:Int, title: String) {
        self.id = id
        self.title = title
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
    }
}
