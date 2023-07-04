//
//  FavouritesView.swift
//  ProjectX
//
//  Created by Hamd Waseem on 31/05/2023.
//

import SwiftUI

struct FavouritesView: View {
    @Binding var nav: Navigation
    
    @EnvironmentObject var projectsManager: ProjectsManager
    
    var body: some View {
        VStack {
            ZStack {
                Color.clear
                    .background(.ultraThinMaterial)
                    .blur(radius: 10)
                
                HStack {
                    Button {
                        withAnimation(.spring()) {
                            nav.current = 0
                        }
                    } label: {
                        Image(systemName: "arrow.backward")
                    }
                    .buttonStyle(GrowingButton(capsule: true))
                    
                    Spacer()
                }
                
                Text("Favourites")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    
                Spacer()
            }
            .padding()
            .frame(height: 60)
            
            
            
            if projectsManager.favourites.count <= 0 {
                VStack {
                    Spacer()
                    
                    Image("fav-graphic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .padding()
                    Text("You have no favourites!")
                        .font(.title2.bold())
                    Text("Visit a project you like, then tap the heart in the top-right corner.")
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 1)
                    
                    Spacer()
                }
                .frame(maxHeight: .infinity)
                .padding()
            } else {
                ScrollView {
                    ForEach(projectsManager.projects) { project in
                        
                        if projectsManager.favourites.contains(project.title) {
                            CardView(title: project.title, description: project.description, lang: project.lang, colour: .init(hex: project.colour), difficulty: project.difficulty)
                                .frame(width: screenWidth * 0.8, height: 265)
                                .padding(.vertical, 10)
                                .onTapGesture {
                                    projectsManager.currentOpened = project
                                    
                                    withAnimation(.spring()) {
                                        nav.current = 2
                                        nav.previous = 1
                                    }
                                }
                        }
                        
                    }
                    .padding(20)
                }
                .offset(y: -8)
                .ignoresSafeArea(edges: .bottom)
            
            }
            
        }
        .task {
            await projectsManager.fetch()
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    @State static var nav = Navigation(current: 1, previous: 0, goingBack: false)
    
    static var previews: some View {
        FavouritesView(nav: $nav)
            .environmentObject(ProjectsManager())
    }
}
