//
//  ContentView.swift
//  AsyncImage
//
//  Created by Tiago Couto on 2/8/22.
//

import SwiftUI

extension Image {
    func modifyToFit() -> some View {
        self.resizable()
            .scaledToFit()
    }
    
    func icon() -> some View {
        self.modifyToFit()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}

struct ContentView: View {
    private let imageUrl = "https://credo.academy/credo-academy@3x.png"
    var body: some View {
        AsyncImage(url: URL(string: imageUrl), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
            switch phase {
            case .success(let image):
                image
                    .modifyToFit()
                    //.transition(.move(edge: .bottom))
                    //.transition(.slide)
                    .transition(.scale)
            case.failure(_):
                Image(systemName: "ant.circle.fill").icon()
            case .empty:
                Image(systemName: "photo.circle.fill").icon()
            @unknown default:
                ProgressView()
            }
        }
        .padding(40)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
