//
//  DownloadButtonStyles.swift
//  MultiStateButtonDemoApp
//
//  Created by Will on 1/26/24.
//

import SwiftUI

/// A button style for the 'to download' button state of the download button.
struct DownloadButtonToDownloadStateButtonStyle: PrimitiveButtonStyle {

    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        Button {
            configuration.trigger()
        } label: {
            Label("Download", systemImage: "arrow.down.circle")
        }
    }
}

/// A button style for the 'download in progress' button state of the download button.
struct DownloadButtonDownloadInProgressStateButtonStyle: PrimitiveButtonStyle {

    let progress: Progress

    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        Button {
            configuration.trigger()
        } label: {
            Label("Downloading ... \(Int(progress.fractionCompleted * 100))%", systemImage: "arrow.down.circle.dotted")
        }
        .tint(.orange)
    }
}

/// A button style for the 'download completed' button state of the download button.
struct DownloadButtonDownloadCompletedProgressStateButtonStyle: PrimitiveButtonStyle {

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

extension PrimitiveButtonStyle where Self == DownloadButtonToDownloadStateButtonStyle {

    static var downloadButtonToDownloadStateStyle: Self {
        .init()
    }
}

extension PrimitiveButtonStyle where Self == DownloadButtonDownloadInProgressStateButtonStyle {

    static func downloadButtonDownloadInProgressStateStyle(withProgress progress: Progress) -> Self {
        .init(progress: progress)
    }
}

extension PrimitiveButtonStyle where Self == DownloadButtonDownloadCompletedProgressStateButtonStyle {

    static var downloadButtonDownloadCompletedStateStyle: Self {
        .init()
    }
}
