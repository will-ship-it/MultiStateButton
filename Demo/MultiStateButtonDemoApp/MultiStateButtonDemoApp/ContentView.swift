//
//  ContentView.swift
//  MultiStateButtonDemoApp
//
//  Created by Will on 1/26/24.
//

import SwiftUI
import Combine

import MultiStateButton

enum ButtonBorderStyle: Equatable {

    case borderedProminent
    case borderless
}

struct ContentView: View {

    @StateObject var viewModel: DownloadButtonViewModel = .init()

    @State var buttonBorderStyle: ButtonBorderStyle = .borderedProminent

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Button Border Style", selection: $buttonBorderStyle) {
                    Text("Bordered Prominent").tag(ButtonBorderStyle.borderedProminent)
                    Text("Borderless").tag(ButtonBorderStyle.borderless)
                }
                .pickerStyle(.segmented)
                .padding()

                Spacer()

                switch buttonBorderStyle {
                case .borderedProminent:
                    MultiStateButton(viewModel: viewModel) { state in
                        switch state {
                        case .toDownload:
                            DownloadButtonToDownloadStateLabeledButtonStyle()
                        case .downloading(let progress):
                            DownloadButtonDownloadInProgressStateLabeledButtonStyle(progress: progress)
                        case .downloaded:
                            DownloadButtonDownloadCompletedProgressStateLabeledButtonStyle()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                case .borderless:
                    MultiStateButton(viewModel: viewModel) { state in
                        switch state {
                        case .toDownload:
                            DownloadButtonToDownloadStateIconOnlyButtonStyle()
                        case .downloading(let progress):
                            DownloadButtonDownloadInProgressStateIconOnlyButtonStyle(progress: progress)
                        case .downloaded:
                            DownloadButtonDownloadCompletedProgressStateIconOnlyButtonStyle()
                        }
                    }
                    .buttonStyle(.borderless)
                    .animation(.smooth, value: viewModel.state)
                }

                Text(self.subtitle)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding()

                Text(self.hintText)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding()

                Spacer()

                Text("This app demonstrates the use of `MultiStateButton`. Here we have a single button element that has different appearances across all possible states of its semantics. Try interact with it to simulate the task of downloading a resource.")
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

    private var subtitle: String {
        switch viewModel.state {
        case .toDownload:
            ""
        case .downloading(let progress):
            "Downloading ... \(Int(progress.fractionCompleted * 100))%"
        case .downloaded:
            ""
        }
    }

    private var hintText: String {
        switch viewModel.state {
        case .toDownload:
            "Click the button to initiate download."
        case .downloading:
            "Download in progress. Click the button to cancel download."
        case .downloaded:
            "Download completed. Click the button to delete downloaded resource."
        }
    }
}

#Preview {
    ContentView()
}
