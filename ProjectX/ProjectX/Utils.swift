//
//  Utils.swift
//  ProjectX
//
//  Created by Hamd Waseem on 31/05/2023.
//

import SwiftUI
import Foundation

struct CircleButton: View {
    var icon: String
    var colour: Color
    
    var body: some View {
        ZStack {
            Circle()
                  .frame(width: 44, height: 44)
                  .shadow(color: colour, radius: 10, x: 0, y: 0)
                  .foregroundColor(colour)
              
             Image(systemName: icon)
                .foregroundColor(.primary)
        }
        .frame(width: 44, height: 44)
   }
}


struct LanguageText: View {
    var text: String
    
    var body: some View {
        Text(getLang(text).uppercased())
            .font(.footnote)
            .fontWeight(.bold)
    }
    
}

struct GrowingButton: ButtonStyle {
    var capsule: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.thickMaterial)
            .foregroundColor(.blue)
            .if(capsule) { view in
                view.clipShape(Capsule())
            }
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

func getLang(_ text: String) -> String {
    if text == "py" {
        return "python"
    } else if text == "js" {
        return "javascript"
    } else if text == "cs" {
        return "c sharp"
    } else {
        return text
    }
}

struct Navigation {
    var current: Int
    var previous: Int
    var goingBack: Bool
}

struct TagData: Codable, Identifiable {
    var name: String
    var visits: Int
    
    var id: UUID { UUID() }
}

