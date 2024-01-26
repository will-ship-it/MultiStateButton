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

    @StateObject var viewModel: DownloadButtonViewModel = .init()

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
                .buttonStyle(.borderedProminent)

                Spacer()

                Text("This app demonstrates the use of `MultiStateButton`. Here we have a single button element that has different appearances across its possible states. Try interact with it to simulate a button that manages download of a resource.")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding()

                Spacer()
            }
            .navigationTitle("Demo 🛠️")
            .navigationBarTitleDisplayMode(.large)
            .alert("Delete Downloaded Item", isPresented: $viewModel.showDeleteAlert) {                
                Button(role: .destructive) {
                    Task {
                        await viewModel.deleteDownloadedItem()
                    }
                } label: {
                    Text("Delete")
                }
            } message: {
                Text("Are you sure you want to delete downloaded item? This action cannot be undone.")
            }
            .alert("Cancel Download", isPresented: $viewModel.showCancelAlert) {
                Button(role: .destructive) {
                    Task {
                        await viewModel.cancelDownload()
                    }
                } label: {
                    Text("Cancel Download")
                }
            } message: {
                Text("Download is in progress. Are you sure you want to cancel it?")
            }
        }
    }
}

#Preview {
    ContentView()
}
