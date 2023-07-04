//
//  ProjectsManager.swift
//  ProjectX
//
//  Created by Hamd Waseem on 01/06/2023.
//

import Foundation
import SwiftUI

class ProjectsManager: ObservableObject {
    @Published var projects: [JSONModel.Project] = []
    
    var currentOpened: JSONModel.Project? = nil
    
    @Published var favourites: [String] {
        didSet {
            UserDefaults.standard.set(favourites, forKey: "favourites")
        }
    }
    
    @Published var suggested: [String] {
        didSet {
            UserDefaults.standard.set(suggested, forKey: "suggested")
        }
    }
    
    init() {
        if let favourites = UserDefaults.standard.array(forKey: "favourites") as? [String] {
            self.favourites = favourites
        } else {
            self.favourites = []
        }
        if let suggested = UserDefaults.standard.array(forKey: "suggested") as? [String] {
            self.suggested = suggested
        } else {
            self.suggested = []
        }
    }
    
    func fetch(_ prefix: Int = 0) async {
        guard let url = URL(string: "https://raw.githubusercontent.com/hamdivazim/ProjectX/library/projects.json") else { fatalError("Missing url") }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error while fetching data")}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            
            let decoded = try decoder.decode(JSONModel.self, from: data)
            
            DispatchQueue.main.async {
                self.projects = decoded.projects
            }
            
        } catch {
            print("Error fetching projects: \(error)")
        }
    }
    
    func addSuggestedTag(_ append: TagData) {
        var data = self.getSuggested()
    
        data.append(append)
        
        setSuggested(data)
    }
    
    func changeTagVisited(_ name: String, _ by: Int) {
        var data = self.getSuggested()
        var found = data.first(where: { $0.name == name })
        
        data = data.filter { $0.name != name }
        
        found?.visits += by
        
        if let f = found {
            data.append(f)
        } else {
            data.append(TagData(name: name, visits: 0))
        }
        
        self.setSuggested(data)
    }
    
    func setSuggested(_ toSet: [TagData]) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(toSet) {
            UserDefaults.standard.set(encodedData, forKey: "suggested")
        }
    }
    
    func getSuggested() -> [TagData] {
        var data: [TagData] = []
        
        if let encodedData = UserDefaults.standard.data(forKey: "suggested") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([TagData].self, from: encodedData) {
                data = decoded
            }
        }
        
        return data
    }
}
