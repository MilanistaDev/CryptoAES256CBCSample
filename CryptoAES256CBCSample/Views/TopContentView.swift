//
//  TopContentView.swift
//  CryptoAES256CBCSample
//
//  Created by Takuya Aso on 2023/05/17.
//

import SwiftUI

struct TopContentView: View {
    var body: some View {
        NavigationStack {
            List(TopContentType.allCases, id: \.self) { type in
                NavigationLink(type.title) {
                    nextContent(type: type)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Top View")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

extension TopContentView {
    @ViewBuilder
    private func nextContent(type: TopContentType) -> some View {
        switch type {
        case .encryption:
            EncryptionView()

        case .decryption:
            DecryptionView()
        }
    }
}

struct TopContentView_Previews: PreviewProvider {
    static var previews: some View {
        TopContentView()
    }
}
