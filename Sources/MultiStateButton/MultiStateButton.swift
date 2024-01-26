//
//  MultiStateButton.swift
//  MultiStateButton
//
//  Created by Will on 1/26/24.
//

import SwiftUI

public struct MultiStateButton<
    ViewModel: MultiStateButtonViewModelProtocol,
    ButtonStyle: PrimitiveButtonStyle>: View
{
    @ObservedObject var viewModel: ViewModel

    @ButtonStyleBuilder var styler: (ViewModel.State) -> ButtonStyle

    public init(
        viewModel: ViewModel,
        @ButtonStyleBuilder styler: @escaping (ViewModel.State) -> ButtonStyle
    ) {
        self.viewModel = viewModel
        self.styler = styler
    }

    public var body: some View {
        Button {
            self.viewModel.buttonClicked(onState: viewModel.state)
        } label: {
            Text("Button")
        }
        .buttonStyle(styler(viewModel.state))
    }
}
