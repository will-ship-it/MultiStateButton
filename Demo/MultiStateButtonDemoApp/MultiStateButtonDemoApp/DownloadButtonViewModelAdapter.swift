//
//  DownloadButtonViewModelAdapter.swift
//  MultiStateButtonDemoApp
//
//  Created by Will on 1/26/24.
//

import Combine
import Foundation
import MultiStateButton

class DownloadButtonViewModelAdapter: MultiStateButtonViewModelAdapter {

    enum DownloadState: Equatable {

        case toDownload
        case downloading(Progress)
        case downloaded
    }

    var initialState: DownloadState { .toDownload }

    @Published var state: DownloadState = .toDownload

    func buttonClicked(onState state: DownloadState) {
        switch state {
        case .toDownload:
            self.state = .downloading(.init())
        case .downloading(let progress):
            break
        case .downloaded:
            self.state = .downloaded
        }
    }

    typealias State = DownloadState

    var statePublisher: AnyPublisher<DownloadState, Never> {
        $state.eraseToAnyPublisher()
    }
}
