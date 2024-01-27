//
//  DownloadButtonStyles.swift
//  MultiStateButtonDemoApp
//
//  Created by Will on 1/27/24.
//

import Foundation

enum DownloadButtonStyles {}

// MARK: Labeled styles

extension DownloadButtonStyles {

    static let downloadButtonToDownloadStateLabeledStyle: DownloadButtonToDownloadStateLabeledButtonStyle =
        .downloadButtonToDownloadStateLabeledStyle

    static func downloadButtonDownloadInProgressStateLabeledStyle(
        withProgress progress: Progress
    ) -> DownloadButtonDownloadInProgressStateLabeledButtonStyle {
        .downloadButtonDownloadInProgressStateLabeledStyle(withProgress: progress)
    }

    static let downloadButtonDownloadCompletedStateLabeledStyle: DownloadButtonDownloadCompletedStateLabeledButtonStyle =
        .downloadButtonDownloadCompletedStateLabeledStyle
}

// MARK: Icon only styles

extension DownloadButtonStyles {

    static let downloadButtonToDownloadStateIconOnlyStyle: DownloadButtonToDownloadStateIconOnlyButtonStyle =
        .downloadButtonToDownloadStateIconOnlyStyle

    static func downloadButtonDownloadInProgressStateIconOnlyStyle(
        withProgress progress: Progress
    ) -> DownloadButtonDownloadInProgressStateIconOnlyButtonStyle {
        .downloadButtonDownloadInProgressStateIconOnlyStyle(withProgress: progress)
    }

    static let downloadButtonDownloadCompletedStateIconOnlyStyle: DownloadButtonDownloadCompletedStateIconOnlyButtonStyle =
        .downloadButtonDownloadCompletedStateIconOnlyStyle
}
