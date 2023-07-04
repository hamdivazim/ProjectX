//
//  ContentView.swift
//  ProjectX
//
//  Created by Hamd Waseem on 31/05/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var projectsManager: ProjectsManager = ProjectsManager()
    
    @State var nav = Navigation(current: 0, previous: 0, goingBack: false)
    
    var body: some View {
        ZStack {
            if nav.current == 0 {
                HomeView(nav: $nav)
                    .transition(.move(edge: .leading))
                    .environmentObject(projectsManager)
            }
            if nav.current == 1 {
                FavouritesView(nav: $nav)
                    .transition(.move(edge: .trailing))
                    .environmentObject(projectsManager)
            }
            if nav.current == 2 {
                ProjectView(nav: $nav)
                    .transition(.move(edge: .trailing))
                    .environmentObject(projectsManager)
            }
            if nav.current == 3 {
                AllProjectIdeasView(nav: $nav)
                    .if(!nav.goingBack) { view in
                        view.transition(.move(edge: .trailing))
                    }
                    .if(nav.goingBack) { view in
                        view.transition(.move(edge: .leading))
                    }
                    .environmentObject(projectsManager)
            }
            if nav.current == 4 {
                SettingsView(nav: $nav)
                    .transition(.move(edge: .trailing))
                    .environmentObject(projectsManager)
            }
        }
        .onAppear {
            nav.goingBack = false
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
