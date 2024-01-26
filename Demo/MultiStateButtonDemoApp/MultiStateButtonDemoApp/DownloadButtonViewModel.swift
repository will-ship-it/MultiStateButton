//
//  DownloadButtonViewModel.swift
//  MultiStateButtonDemoApp
//
//  Created by Will on 1/26/24.
//

import Combine
import Foundation

import MultiStateButton

@MainActor
class DownloadButtonViewModel: MultiStateButtonViewModelProtocol, ObservableObject {

    enum DownloadState: Equatable {

        case toDownload
        case downloading(Progress)
        case downloaded
    }

    typealias State = DownloadState

    let initialState: DownloadState = .toDownload

    @Published var state: DownloadState = .toDownload

    @Published var showAlert: Bool = false

    func buttonClicked(onState state: DownloadState) async {
        switch state {
        case .toDownload:
            self.state = .downloading(.init())
            self.initiateLongRunningTask()
        case .downloading:
            break
        case .downloaded:
            self.showAlert = true
        }
    }

    var statePublisher: AnyPublisher<DownloadState, Never> {
        get async {
            $state.eraseToAnyPublisher()
        }
    }

    func deleteDownloadedItem() async {
        self.state = .toDownload
    }

    /// Simulate a long running task, like downloading a resource over the Internet.
    /// Update the progress as part of the state accordingly.
    private func initiateLongRunningTask() {
        Task {
            for i in 0...100 {
                let progress = Progress(totalUnitCount: 100)
                progress.completedUnitCount = Int64(i)
                self.state = .downloading(progress)
                try await Task.sleep(nanoseconds: 100_000_000)
            }
            self.state = .downloaded
        }
    }
}
