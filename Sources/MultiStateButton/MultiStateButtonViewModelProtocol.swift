//
//  MultiStateButtonViewModelProtocol.swift
//  MultiStateButton
//
//  Created by Will on 1/26/24.
//

import Combine

public protocol MultiStateButtonViewModelProtocol where Self: ObservableObject {

    associatedtype State: Equatable

    var initialState: State { get }

    func buttonClicked(onState: State) async

    var state: State { get }

    var statePublisher: AnyPublisher<State, Never> { get async }
}
