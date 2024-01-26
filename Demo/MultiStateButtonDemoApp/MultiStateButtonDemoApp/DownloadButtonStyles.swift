//
//  DownloadButtonStyles.swift
//  MultiStateButtonDemoApp
//
//  Created by Will on 1/26/24.
//

import SwiftUI

struct DownloadButtonToDownloadStateButtonStyle: PrimitiveButtonStyle {

    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        Button {
            configuration.trigger()
        } label: {
            Label("Download", systemImage: "arrow.down.circle")
        }
    }
}

struct DownloadButtonDownloadInProgressStateButtonStyle: PrimitiveButtonStyle {

    let progress: Progress

    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        Button {
            configuration.trigger()
        } label: {
            Label("Downloading ... \(Int(progress.fractionCompleted * 100))%", systemImage: "circle.dashed")
        }
    }
}

struct DownloadButtonDownloadCompletedProgressStateButtonStyle: PrimitiveButtonStyle {

    func makeBody(configuration: PrimitiveButtonStyleConfiguration) -> some View {
        Button {
            configuration.trigger()
        } label: {
            Label("Completed", systemImage: "checkmark.circle")
        }
    }
}
