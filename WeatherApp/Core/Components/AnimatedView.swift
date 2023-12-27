//
//  AnimatedView.swift
//  WeatherApp
//
//  Created by Martyna on 04/11/2022.
//

import SwiftUI
import Lottie

struct SplashScreen : View {
    var body: some View {
        VStack {
            AnimatedView()
        }
    }
}

struct SplashScreen_previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

struct AnimatedView: UIViewRepresentable {
    var name = "clearNight"
    var shouldPlay = true
    func makeUIView(context: UIViewRepresentableContext<AnimatedView>) -> UIView {
        let view = UIView(frame: .zero)
        let lottieView = LottieAnimationView(name: name,
                                             bundle: Bundle.main)
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        if(shouldPlay){
            lottieView.play()
            lottieView.backgroundBehavior = .pauseAndRestore
        }
            view.addSubview(lottieView)
    
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lottieView.widthAnchor.constraint(equalTo: view.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
