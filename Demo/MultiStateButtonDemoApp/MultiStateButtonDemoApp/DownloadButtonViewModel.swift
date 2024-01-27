//
//  DownloadButtonViewModel.swift
//  MultiStateButtonDemoApp
//
//  Created by Will on 1/26/24.
//

import Combine
import Foundation

import MultiStateButton

class DownloadButtonViewModel: MultiStateButtonViewModelProtocol, ObservableObject {

    enum DownloadState: Equatable {

        case toDownload
        case downloading(Progress)
        case downloaded
    }

    typealias State = DownloadState

    let initialState: DownloadState = .toDownload

    @MainActor
    @Published var state: DownloadState = .toDownload

    @Published var showDeleteAlert: Bool = false

    @Published var showCancelAlert: Bool = false

    private var downloadTask: Task<Void, Error>? = nil

    @MainActor
    func buttonClicked(onState state: DownloadState) {
        switch state {
        case .toDownload:
            self.state = .downloading(.init())
            self.initiateLongRunningTask()
        case .downloading:
            self.showCancelAlert = true
        case .downloaded:
            self.showDeleteAlert = true
        }
    }

    var statePublisher: AnyPublisher<DownloadState, Never> {
        $state.eraseToAnyPublisher()
    }

    @MainActor
    func deleteDownloadedItem() async {
        self.state = .toDownload
    }

    @MainActor
    func cancelDownload() async {
        self.downloadTask?.cancel()
        self.downloadTask = nil
        self.state = .toDownload
        self.showCancelAlert = false
    }

    /// Simulate a long running task, like downloading a resource over the Internet.
    /// Update the progress as part of the state accordingly.
    @MainActor
    private func initiateLongRunningTask() {
        self.downloadTask = Task {
            for i in 0...100 {
                let progress = Progress(totalUnitCount: 100)
                progress.completedUnitCount = Int64(i)
                self.state = .downloading(progress)
                try await Task.sleep(nanoseconds: .nanosecondsPerSecond / 2)
            }
            self.state = .downloaded
        }
    }
}

fileprivate extension UInt64 {

    static let nanosecondsPerSecond: Self = 100_000_000
}
