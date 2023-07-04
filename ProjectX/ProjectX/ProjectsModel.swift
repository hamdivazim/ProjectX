//
//  ProjectsModel.swift
//  ProjectX
//
//  Created by Hamd Waseem on 01/06/2023.
//

import Foundation

struct JSONModel: Decodable {
    var projects: [Project]

    
    struct Project: Decodable, Identifiable, Hashable, Equatable {
        var id: UUID { UUID() }
        
        var title: String
        var tags: [String]
        var colour: String
        var difficulty: String
        var lang: String
        var description: String
        var content: String
    }
}
