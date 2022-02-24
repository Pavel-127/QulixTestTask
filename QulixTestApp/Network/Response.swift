//
//  Response.swift
//  QulixTestApp
//
//  Created by macbook on 22.02.22.
//

import Foundation

struct Response: Decodable {
    let page: Int
    let results: [Movies]
    let total_results: Int
    let total_pages: Int
}
