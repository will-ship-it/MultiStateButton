//
//  MultiStateButtonViewModelProtocol.swift
//  MultiStateButton
//
//  Created by Will on 1/26/24.
//

import Combine

/// Common interface of the view model that drives ``MultiStateButton``.
public protocol MultiStateButtonViewModelProtocol where Self: ObservableObject {

    /// The type of state of the button.
    associatedtype State: Equatable

    /// The initial state of the button.
    var initialState: State { get }

    /// Routine to be invoked when a button is clicked while in a particular state.
    func buttonClicked(onState: State)

    /// The current state of the button.
    var state: State { get }

    /// A publisher that emits the current state of the button.
    var statePublisher: AnyPublisher<State, Never> { get }
}
