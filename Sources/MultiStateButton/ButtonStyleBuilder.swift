//
//  ButtonStyleBuilder.swift
//  MultiStateButton
//
//  Created by Will on 1/26/24.
//

import SwiftUI

@resultBuilder
public struct ButtonStyleBuilder {

    public static func buildBlock() -> DefaultButtonStyle {
        .automatic
    }

    public static func buildBlock<Style>(_ content: Style) -> Style where Style : PrimitiveButtonStyle {
        content
    }

    public static func buildBlock<Style>(_ components: Style...) -> AnyButtonStyle where Style: PrimitiveButtonStyle {
        AnyButtonStyle(style: components.first ?? DefaultButtonStyle.automatic)
    }

    public static func buildEither<Style>(first component: Style) -> Style where Style: PrimitiveButtonStyle {
        component
    }

    public static func buildEither<Style>(second component: Style) -> Style where Style: PrimitiveButtonStyle {
        component
    }
}

public struct AnyButtonStyle: PrimitiveButtonStyle {

    public typealias Body = AnyView

    let style: any PrimitiveButtonStyle

    public func makeBody(configuration: Configuration) -> AnyView {
        AnyView(style.makeBody(configuration: configuration))
    }
}
