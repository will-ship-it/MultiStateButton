//
//  MultiStateButtonViewModel.swift
//  MultiStateButton
//
//  Created by Will on 1/26/24.
//

import Combine

public class MultiStateButtonViewModel<Adapter: MultiStateButtonViewModelAdapter>: ObservableObject {

    @Published var state: Adapter.State

    let adapter: Adapter

    var cancellables: Set<AnyCancellable>

    public init(adapter: Adapter) {
        self.adapter = adapter
        self.state = adapter.initialState
        self.cancellables = .init()

        adapter
            .statePublisher.sink {
                self.state = $0
            }
            .store(in: &cancellables)
    }
}
