//
//  SettingsView.swift
//  ProjectX
//
//  Created by Hamd Waseem on 27/06/2023.
//

import SwiftUI

struct SettingsView: View {
    @Binding var nav: Navigation
    @EnvironmentObject var projectsManager: ProjectsManager
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        NavigationLink {
                            SuggestionDataView()
                                .environmentObject(projectsManager)
                        } label: {
                            Text("Manage Suggestion Data")
                        }

                    } header: {
                        Text("Data")
                    }
                }
            }
            .navigationTitle("Settings")
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
        
    }
}

struct SuggestionDataView: View {
    @EnvironmentObject var projectsManager: ProjectsManager
    
    @State var showAlert = false
    
    var body: some View {
        VStack {
            List {
                Section {
                    Button(role: .destructive) {
                        showAlert = true
                    } label: {
                        Text("Clear Suggestions Data")
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Confirm Action"), message: Text("Are you sure you want to clear all suggestion data?"), primaryButton: .destructive(Text("Clear")) {
                            
                            projectsManager.setSuggested([])
                            
                        }, secondaryButton: .cancel())
                    }
                    

                }
                
                Section {
                    ForEach(projectsManager.getSuggested()) { tag in
                        Text("\(tag.name): \(tag.visits)")
                    }
                }
                
                
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var nav = Navigation(current: 4, previous: 0, goingBack: false)
    
    static var previews: some View {
        SettingsView(nav: $nav)
            .environmentObject(ProjectsManager())
    }
}
