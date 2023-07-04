//
//  HomeView.swift
//  ProjectX
//
//  Created by Hamd Waseem on 31/05/2023.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.width

struct HomeView: View {
    @Binding var nav: Navigation
    @State var showSideMenu = false
    
    @EnvironmentObject var projectsManager: ProjectsManager
    
    var body: some View {
        ZStack {
            VStack {
                TitleBar(nav: $nav, showMenu: $showSideMenu)
                    .frame(height: 50)
                
                ScrollView {
                    VStack {
                        Text("Newest Ideas".uppercased())
                            .font(.footnote.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .offset(y: 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Array(projectsManager.projects.suffix(4).reversed())) { project in
                                    
                                    CardView(title: project.title, description: project.description, lang: project.lang, colour: .init(hex: project.colour), difficulty: project.difficulty)
                                        .frame(width: screenWidth * 0.8, height: 265)
                                        .padding(.horizontal, 10)
                                        .onTapGesture {
                                            projectsManager.currentOpened = project
                                            
                                            withAnimation(.spring()) {
                                                nav.current = 2
                                                nav.previous = 0
                                            }
                                        }
                                    
                                }
                            }
                            .padding(.horizontal, 10)
                            .frame(height: 315)
                            
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    .background(.ultraThinMaterial)
                    
                    
                    
                    VStack {
                        Text("For You".uppercased())
                            .font(.footnote.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .offset(y: 20)
                        
                        ForYouCards()
                            .environmentObject(projectsManager)
                        
                        Spacer()
                    }
                    .padding(.vertical, 5)
                }
                
                Spacer()
            }
            .offset(y: 10)
            
            if showSideMenu {
                SideMenu(nav: $nav, showMenu: $showSideMenu)
                    .transition(.move(edge: .trailing))
                    .animation(.easeInOut)
            }
        }
        .task {
            await projectsManager.fetch()
        }
        
    }
}

struct TitleBar: View {
    @Binding var nav: Navigation
    @Binding var showMenu: Bool
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
            
            HStack {
                Text("Project X")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(10)
                
                Spacer()
                
                Button {
                    nav.current = 1
                } label: {
                    CircleButton(icon: "heart.fill", colour: .red)
                }
                .padding(.horizontal, 15)
                
                Button {
                    withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) {
                        showMenu.toggle()
                    }
                } label: {
                    CircleButton(icon: "line.3.horizontal", colour: .blue)
                }
            }
            .padding(10)
            
            
        }.frame(height: 70)
            .frame(maxHeight: .infinity, alignment: .top)
        
    }
}

struct SideMenu: View {
    @Binding var nav: Navigation
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Button {
                    nav.current = 1
                } label: {
                    HStack {
                        Image(systemName: "heart.fill")
                        Text("Favourites")
                            .font(.headline)
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 360)
                            .foregroundColor(.red)
                            .shadow(color: .red, radius: 15, x: 0, y: 0)
                    )
                    .offset(x: screenWidth/2)
                    
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "sparkles")
                        Text("Suggested")
                            .font(.headline)
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 360)
                            .foregroundColor(.mint)
                            .shadow(color: .mint, radius: 15, x: 0, y: 0)
                    )
                    .offset(x: screenWidth/2)
                    
                }
                .padding(.vertical, 10)
                
                Button {
                    nav.current = 3
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("All Projects")
                            .font(.headline)
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 360)
                            .foregroundColor(.orange)
                            .shadow(color: .orange, radius: 15, x: 0, y: 0)
                    )
                    .offset(x: screenWidth/2)
                    
                }
                
                Button {
                    nav.current = 4
                } label: {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings")
                            .font(.headline)
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 360)
                            .foregroundColor(.gray)
                            .shadow(color: .gray, radius: 15, x: 0, y: 0)
                    )
                    .offset(x: screenWidth/2)
                    
                }
                .padding(.vertical, 10)

            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(10)
        .background(
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color.black.opacity(0.5),
                        Color.gray.opacity(1)
                    ]),
                startPoint: .leading,
                endPoint: .trailing)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) {
                        showMenu.toggle()
                    }
                }
        )
    }
}

struct ForYouCards: View {
    @EnvironmentObject var projectsManager: ProjectsManager
    
    @State var suggested: [Array<JSONModel.Project>.SubSequence] = []
    
    var body: some View {
        if projectsManager.getSuggested().filter({ $0.visits >= 4 }).count > 0 {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(Set(suggested.flatMap { $0 })), id: \.self) { project in
                        CardView(title: project.title, description: project.description, lang: project.lang, colour: .init(hex: project.colour), difficulty: project.difficulty)
                            .frame(width: screenWidth * 0.8, height: 265)
                            .padding(.horizontal, 10)
                    }
                }
                .padding(.horizontal, 10)
                .frame(height: 315)
                
            }
            .onAppear {
                var tags: [String] {
                    let data = projectsManager.getSuggested().sorted(by: { $0.visits > $1.visits }).prefix(3)
                    
                    return [data[0].name, data[1].name, data[2].name]
                    
                    
                }
                
                
                suggested = [projectsManager.projects.filter { $0.tags.contains(tags[0]) }.suffix(4), projectsManager.projects.filter { $0.tags.contains(tags[1]) }.suffix(3), projectsManager.projects.filter { $0.tags.contains(tags[2]) }.suffix(2)]
                
                
            }
            
        } else {
            VStack {
                Text("No Suggestions Yet!")
                    .font(.headline)
                    .padding(5)
                Text("Check out some more projects you like and a list will be curated for you.")
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 15)
            .frame(height: 315)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    @State static var nav = Navigation(current: 0, previous: 0, goingBack: false)
    
    static var previews: some View {
        HomeView(nav: $nav)
            .environmentObject(ProjectsManager())
    }
}
