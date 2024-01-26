//
//  ContentView.swift
//  MultiStateButtonDemoApp
//
//  Created by Will on 1/26/24.
//

import SwiftUI
import Combine

import MultiStateButton

struct ContentView: View {

    @StateObject var downloadAdapter: DownloadButtonViewModelAdapter

    @StateObject var viewModel: MultiStateButtonViewModel<DownloadButtonViewModelAdapter>

    init() {
        let downloadAdapter: DownloadButtonViewModelAdapter = .init()
        self._downloadAdapter = StateObject(wrappedValue: downloadAdapter)
        self._viewModel = StateObject(wrappedValue: .init(adapter: downloadAdapter))
    }

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                MultiStateButton(viewModel: viewModel) { state in
                    switch state {
                    case .toDownload:
                        DownloadButtonToDownloadStateButtonStyle()
                    case .downloading(let progress):
                        DownloadButtonDownloadInProgressStateButtonStyle(progress: progress)
                    case .downloaded:
                        DownloadButtonDownloadCompletedProgressStateButtonStyle()
                    }
                }

                Spacer()

                Text("This app demonstrates the use of `MultiStateButton`. Here we have a single button element that has different appearances across its possible states.")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding()

                Spacer()
            }
            .navigationTitle("MultiStateButton")
            .navigationBarTitleDisplayMode(.large)
            .alert(isPresented: $downloadAdapter.showAlert) {
                Alert(
                    title: Text("Delete Downloaded Item"),
                    message: Text("Are you sure you want to delete downloaded item? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        downloadAdapter.deleteDownloadedItem()
                    },
                    secondaryButton: .cancel {
                        downloadAdapter.showAlert = false
                    }
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
