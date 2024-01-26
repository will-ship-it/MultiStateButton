//
//  MultiStateButtonViewModelAdapter.swift
//  MultiStateButton
//
//  Created by Will on 1/26/24.
//

import Combine

public protocol MultiStateButtonViewModelAdapter {

    associatedtype State: Equatable

    var initialState: State { get }

    func buttonClicked(onState: State)

    var statePublisher: AnyPublisher<State, Never> { get }
}
