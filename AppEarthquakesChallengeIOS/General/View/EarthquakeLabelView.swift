//
//  EarthquakeLabelView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import SwiftUI

struct EarthquakeLabelView: View {
    struct ViewModel {
        var title: String
        var value: String
        var fontSize: CGFloat
        var fontWeight: Font.Weight
    }
    var viewModel: ViewModel
    var body: some View {
        HStack {
            Text(viewModel.title)
                .font(.system(size: viewModel.fontSize))
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Text(viewModel.value)
                .font(.system(size: viewModel.fontSize))
                .fontWeight(viewModel.fontWeight)
                .foregroundColor(.secondary)
        }
    }
}

struct EarthquakeLabelView_Previews: PreviewProvider {
    static var previews: some View {
        EarthquakeLabelView(viewModel: .init(title: "Titulo: ", value: "Temblor gashjah hjahasj", fontSize: 18, fontWeight: .semibold))
    }
}

