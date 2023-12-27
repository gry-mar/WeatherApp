//
//  TrackableScrollView.swift
//  WeatherApp
//
//  Created by Martyna on 17/11/2022.
//

import SwiftUI

struct TrackableScrollView<Content: View>: View {
    let axis: Axis.Set
    let offsetChanged: (CGPoint) -> Void
    let content: Content
    
    init(axis: Axis.Set = .vertical,
         offsetChanged: @escaping (CGPoint) -> Void = { _ in },
         @ViewBuilder content: () -> Content) {
        self.axis = axis
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    
    var body: some View {
        SwiftUI.ScrollView(axis){
            GeometryReader { geometry in
                Color.clear.preference(key: ScrollOfsetPreferenceKey.self, value: geometry.frame(in: .named("scrollView")).origin)
            }
            .frame(width: 0, height: 0)
            content
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ScrollOfsetPreferenceKey.self, perform: offsetChanged)
    }
}



private struct ScrollOfsetPreferenceKey: PreferenceKey {
    static let defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint){
        
    }
}
