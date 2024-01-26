//
//  MultiStateButton.swift
//  MultiStateButton
//
//  Created by Will on 1/26/24.
//

import SwiftUI

public struct MultiStateButton<
    Adapter: MultiStateButtonViewModelAdapter,
    ButtonStyle: PrimitiveButtonStyle>: View
{
    @ObservedObject var viewModel: MultiStateButtonViewModel<Adapter>

    @ButtonStyleBuilder var styler: (Adapter.State) -> ButtonStyle

    public init(
        viewModel: MultiStateButtonViewModel<Adapter>,
        @ButtonStyleBuilder styler: @escaping (Adapter.State) -> ButtonStyle
    ) {
        self.viewModel = viewModel
        self.styler = styler
    }

    public var body: some View {
        Button {
            self.viewModel.adapter.buttonClicked(onState: viewModel.state)
        } label: {
            Text("Button")
        }
        .buttonStyle(styler(viewModel.state))
    }
}
