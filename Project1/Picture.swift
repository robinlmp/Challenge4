//
//  Picture.swift
//  Project1
//
//  Created by Robin Phillips on 05/02/2022.
//

import Foundation

class Picture: Codable, Comparable {
    static func == (lhs: Picture, rhs: Picture) -> Bool {
        lhs.caption < rhs.caption && lhs.filePath < rhs.filePath
    }
    
    static func < (lhs: Picture, rhs: Picture) -> Bool {
        lhs.caption < rhs.caption
    }
    
    var caption: String
    var filePath: String
    
    init(name: String, filePath: String) {
        self.caption = name
        self.filePath = filePath
    }
}
