//
//  DownloadButtonIconOnlyStyles.swift
//  MultiStateButtonDemoApp
//
//  Created by Will on 1/27/24.
//

import SwiftUI

/// A button style for the 'to download' button state of the download button,
/// with icon only as part of the button label.
struct DownloadButtonToDownloadStateIconOnlyButtonStyle: PrimitiveButtonStyle {

    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        Button {
            configuration.trigger()
        } label: {
            Image(systemName: "arrow.down.circle.fill")
                .imageScale(.large)
                .symbolRenderingMode(.hierarchical)
        }
    }
}

/// A button style for the 'download in progress' button state of the download button,
/// with icon only as part of the button label.
struct DownloadButtonDownloadInProgressStateIconOnlyButtonStyle: PrimitiveButtonStyle {

    let progress: Progress

    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        Button {
            configuration.trigger()
        } label: {
            Image(systemName: "pause.circle.fill")
                .imageScale(.large)
                .symbolRenderingMode(.hierarchical)
                .background(
                    Circle()
                        .trim(from: 0, to: progress.fractionCompleted)
                        .rotation(.degrees(-90))
                        .stroke(Color.orange, style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [1], dashPhase: 1))
                )
        }
        .tint(.orange)
    }
}

/// A button style for the 'download completed' button state of the download button,
/// with icon only as part of the button label.
struct DownloadButtonDownloadCompletedProgressStateIconOnlyButtonStyle: PrimitiveButtonStyle {

    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        Button {
            configuration.trigger()
        } label: {
            Image(systemName: "checkmark.circle.fill")
                .imageScale(.large)
                .symbolRenderingMode(.hierarchical)
        }
        .tint(.green)
    }
}
