//
//  LoadingViewSwiftUI.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 14-03-24.
//

import SwiftUI

struct LoadingViewSwiftUI: View {
    @Binding var isLoading: Bool
    private let titleLoading: String

    var body: some View {
        VStack(alignment: .center) {
            Text(titleLoading)
                .font(.system(size: 18))
                .foregroundStyle(.gray)
                .padding(.top, 100)
                .padding(.bottom, 30)
            Circle()
                .trim(from: 0.0, to: 0.7)
                .stroke(Color.red, lineWidth: 5)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(isLoading ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default, value: isLoading)
            //.animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            Spacer()
        }
    }
}
