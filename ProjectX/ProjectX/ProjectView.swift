//
//  ProjectView.swift
//  ProjectX
//
//  Created by Hamd Waseem on 01/06/2023.
//

import SwiftUI

struct ProjectView: View {
    @EnvironmentObject var projectsManager: ProjectsManager
    @Binding var nav: Navigation
    
    var nextScreen = 0
    
    var body: some View {
        ZStack {
            
            VStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.init(hex: projectsManager.currentOpened?.colour ?? "#FFFFFF"), Color.clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                .frame(height: UIScreen.main.bounds.height * 0.2)
                
                Spacer()
            }
            
            VStack {
                HStack {
                    
                    Button {
                        withAnimation(.spring()) {
                            nav.current = nav.previous
                            nav.previous = 0
                        }
                    } label: {
                        Image(systemName: "arrow.backward")
                    }
                    .buttonStyle(GrowingButton(capsule: true))
                    
                    Spacer()
                    
                    Button {
                        if projectsManager.favourites.contains(projectsManager.currentOpened?.title ?? "") {
                            projectsManager.favourites.removeAll { $0 == projectsManager.currentOpened?.title ?? "" }
                        } else {
                            projectsManager.favourites.append(projectsManager.currentOpened?.title ?? "")
                        }
                    } label: {
                        Image(systemName: projectsManager.favourites.contains(projectsManager.currentOpened?.title ?? "") ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            
                    }
                    .buttonStyle(GrowingButton(capsule: true))
                }
                
                Text(projectsManager.currentOpened?.title ?? "Unable to load")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .onAppear {
                        let tags = projectsManager.currentOpened?.tags
                        
                        for tag in tags ?? [] {
                            projectsManager.changeTagVisited(tag, 1)
                        }
                    }
                
                ScrollView {
                    HStack {
                        LanguageText(text: projectsManager.currentOpened?.lang ?? "Unable to load")
                        Text("•   \(projectsManager.currentOpened?.difficulty ?? "Unable to load")".uppercased())
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(projectsManager.currentOpened?.difficulty ?? "Unable to load" == "easy" ? .init(hex: "#228B22" ) : projectsManager.currentOpened?.difficulty ?? "Unable to load" == "medium" ? .init(hex: "#B7410E") : .init(hex: "#800020"))
                    }
                    .padding(-2)
                    
                    ForEach(projectsManager.getSuggested()) { tag in
                        Text("\(tag.name): \(tag.visits)")
                    }
                    
                    Text(LocalizedStringKey(projectsManager.currentOpened?.content ?? "Unable to load"))
                        .padding(.vertical)
                }
                
                Spacer()
            }.padding()
        }
        
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
