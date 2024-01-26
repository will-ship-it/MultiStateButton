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

    @StateObject var viewModel: MultiStateButtonViewModel<DownloadButtonViewModelAdapter> = .init(adapter: .init())

    var body: some View {
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
    }
}

#Preview {
    ContentView()
}
