//
//  ExtensionView.swift
//  YNews
//
//  Created by Brusik on 5/6/25.
//

import SwiftUI

extension View {
    func maxFrame(alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    func fadeOnPhaseChange<Value: Equatable>(value: Value) -> some View {
        self
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.3), value: value)
    }
}
