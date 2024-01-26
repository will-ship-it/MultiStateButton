//
//  DownloadButtonViewModelAdapter.swift
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

    var initialState: DownloadState { .toDownload }

    @Published var state: DownloadState = .toDownload

    @Published var showAlert: Bool = false

    func buttonClicked(onState state: DownloadState) {
        switch state {
        case .toDownload:
            self.state = .downloading(.init())
            Task {
                for i in 0...100 {
                    let progress = Progress(totalUnitCount: 100)
                    progress.completedUnitCount = Int64(i)
                    self.state = .downloading(progress)
                    try await Task.sleep(nanoseconds: 100_000_000)
                }
                self.state = .downloaded
            }
        case .downloading:
            break
        case .downloaded:
            self.showAlert = true
        }
    }

    typealias State = DownloadState

    var statePublisher: AnyPublisher<DownloadState, Never> {
        $state.eraseToAnyPublisher()
    }

    func deleteDownloadedItem() {
        self.state = .toDownload
    }
}
