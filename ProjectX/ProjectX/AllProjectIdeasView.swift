//
//  AllProjectIdeasView.swift
//  ProjectX
//
//  Created by Hamd Waseem on 25/06/2023.
//

import SwiftUI

struct AllProjectIdeasView: View {
    @Binding var nav: Navigation
    @EnvironmentObject var projectsManager: ProjectsManager
    
    @State var searchQuery = ""
    
    @State var toLoad = 12
    
    @State var initalLoad = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    if initalLoad {
                        ForEach(Array(searchResults.prefix(toLoad))) { project in
                            
                            MiniCardView(title: project.title, description: project.description, lang: project.lang, colour: .init(hex: project.colour), difficulty: project.difficulty)
                                .padding(.horizontal)
                                .onTapGesture {
                                    projectsManager.currentOpened = project
                                    
                                    withAnimation(.spring()) {
                                        nav.current = 2
                                        nav.previous = 3
                                        nav.goingBack = true
                                    }
                                }
                        }
                        
                        if toLoad < projectsManager.projects.count && searchQuery == "" {
                            
                            Button {
                                toLoad += 12
                            } label: {
                                Text("Load More")
                            }
                            .padding()
                            .buttonStyle(.borderedProminent)

                        }
                    } else {
                        ProgressView()
                            .task {
                                await projectsManager.fetch()
                                initalLoad = true
                            }
                    }
                }
            }
            .navigationTitle("All Projects")
            .toolbar {
                Button {
                    withAnimation(.spring()) {
                        nav.current = 0
                        nav.goingBack = false
                    }
                } label: {
                    Image(systemName: "arrow.backward")
                        .padding(-6)
                }
                .buttonStyle(GrowingButton(capsule: true))
                .offset(y: -10)
            }
        }
        .searchable(text: $searchQuery)
    }
    
    var searchResults: [JSONModel.Project] {
        if searchQuery.isEmpty {
            return projectsManager.projects.reversed()
        } else {
            return projectsManager.projects.reversed().filter { $0.title.contains(searchQuery) }
        }
    }
    
}

struct AllProjectIdeasView_Previews: PreviewProvider {
    @State static var nav = Navigation(current: 3, previous: 0, goingBack: false)
    
    static var previews: some View {
        AllProjectIdeasView(nav: $nav)
            .environmentObject(ProjectsManager())
    }
}
