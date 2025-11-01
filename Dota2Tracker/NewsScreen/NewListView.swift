//
//  NewListView.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 01.11.2025.
//

import SwiftUI
import Dota2APIKit

struct NewListView: View {
    @StateObject var vm: NewsListModel

    init(vm: NewsListModel) {
        _vm = StateObject(wrappedValue: vm)
    }

    var body: some View {
        ZStack {
            GradientBackgroundRepresentable()
                .ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing: 16) {
                    if let error = vm.errorText {
                        Text(error).foregroundColor(.red).padding(.top, 32)
                    }
                    ForEach(vm.items) { item in
                        NewCardView(title: item.title,
                                    imageURL: item.previewURL,
                                    tapURL: item.linkURL
                        )
                        .padding(.horizontal, 16)
                    }
                    if vm.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .tint(.white)
                            .scaleEffect(1.2)
                            .padding(.vertical, 24)
                    }
                }
                .padding(.top, 16)
            }
            .task { await vm.load(limit: 5) }
            .refreshable {
                await vm.load(limit: 5)
            }
        }
    }
}
