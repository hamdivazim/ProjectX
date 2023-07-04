//
//  CardView.swift
//  ProjectX
//
//  Created by Hamd Waseem on 01/06/2023.
//

import SwiftUI

struct CardView: View {
    var title: String
    var description: String
    var lang: String
    var colour: Color
    var difficulty: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(colour)
            
            VStack {
                Spacer()
                
                ZStack {
                    VStack {
                        Text(title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(x: -5, y: 0)
                        
                        Spacer()
                        
                        Text(description)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            LanguageText(text: lang)
                            Text("•   \(difficulty)".uppercased())
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(difficulty == "easy" ? .init(hex: "#228B22" ) : difficulty == "medium" ? .init(hex: "#B7410E") : .init(hex: "#800020"))
                        }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 2)
                            .offset(x: 3)
                            
                    }
                    .padding()
                    .background(
                        Rectangle()
                            .background(.ultraThinMaterial)
                            .blur(radius: 15)
                    )
                    .offset(x: 3)
                }
            }
            
        }
    }
}

struct MiniCardView: View {
    var title: String
    var description: String
    var lang: String
    var colour: Color
    var difficulty: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(colour)
            
            VStack {
                HStack {
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
                .padding(.top, 3)
                
                Text(description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                    .padding(.vertical, 1)
                
                HStack {
                    LanguageText(text: lang)
                    Text("•   \(difficulty)".uppercased())
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(difficulty == "easy" ? .init(hex: "#228B22" ) : difficulty == "medium" ? .init(hex: "#B7410E") : .init(hex: "#800020"))
                }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 1)
                    .offset(x: 3)
            }
            .padding()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            CardView(title: "Test Stuff", description: "A short description of some nice test stuff.", lang: "py", colour: .blue, difficulty: "easy")
                .frame(height: 350)
                .padding(30)
            MiniCardView(title: "Test Stuff", description: "Build an exhilerating 3D adventure where your players jump around avoiding enemies and reaching the goal!", lang: "js", colour: .init(hex: "#f03af1"), difficulty: "medium")
                .padding(30)
        }
    }
}
