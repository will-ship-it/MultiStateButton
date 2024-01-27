//
//  DownloadButtonStyles.swift
//  MultiStateButtonDemoApp
//
//  Created by Will on 1/26/24.
//

import SwiftUI

/// A button style for the 'to download' button state of the download button,
/// with label text as part of the style.
struct DownloadButtonToDownloadStateLabeledButtonStyle: PrimitiveButtonStyle {

    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        Button {
            configuration.trigger()
        } label: {
            Label("Download", systemImage: "arrow.down.circle")
        }
    }
}

/// A button style for the 'download in progress' button state of the download button,
/// with label text as part of the style.
struct DownloadButtonDownloadInProgressStateLabeledButtonStyle: PrimitiveButtonStyle {

    let progress: Progress

    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        Button {
            configuration.trigger()
        } label: {
            Label("Downloading ...", systemImage: "arrow.down.circle.dotted")
        }
        .tint(.orange)
    }
}

/// A button style for the 'download completed' button state of the download button,
/// with label text as part of the style.
struct DownloadButtonDownloadCompletedProgressStateLabeledButtonStyle: PrimitiveButtonStyle {

    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        Button {
            configuration.trigger()
        } label: {
            Label("Completed", systemImage: "checkmark.circle")
        }
        .tint(.green)
    }
}

// MARK: Extensions

extension PrimitiveButtonStyle where Self == DownloadButtonToDownloadStateLabeledButtonStyle {

    static var downloadButtonToDownloadStateStyle: Self {
        .init()
    }
}

extension PrimitiveButtonStyle where Self == DownloadButtonDownloadInProgressStateLabeledButtonStyle {

    static func downloadButtonDownloadInProgressStateStyle(withProgress progress: Progress) -> Self {
        .init(progress: progress)
    }
}

extension PrimitiveButtonStyle where Self == DownloadButtonDownloadCompletedProgressStateLabeledButtonStyle {

    static var downloadButtonDownloadCompletedStateStyle: Self {
        .init()
    }
}
