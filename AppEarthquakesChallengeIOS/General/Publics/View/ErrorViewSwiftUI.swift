//
//  ErrorViewSwiftUI.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 14-03-24.
//

import SwiftUI
struct ErrorViewModel {
    let namedImage: String
    let title: String
    let description: String
    let action: () -> Void
}

struct ErrorViewSwiftUI: View {
    let viewModel: ErrorViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Image(viewModel.namedImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100, alignment: .center)
                .padding(.top, 100)
                .padding(.bottom, 30)
            Text(viewModel.title)
                .font(.title)
                .padding(.horizontal, 50)
                .padding(.bottom, 16)
            Text(viewModel.description)
                .font(.body)
                .padding(.horizontal, 50)
            Spacer()
            Button(action: viewModel.action) {
                Text("Reintentar")
            }
            .padding(.bottom, 36)
        }
        .padding()
    }
}
