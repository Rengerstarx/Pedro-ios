//
//  AppHapticGenerator.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 20.04.2024.
//

import UIKit

class AppHapticGenerator {

    static func impactOccuredLight() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    static func impactOccuredMedium() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    static func impactOccuredHeavy() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
    
    static func notificationSuccess() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }

}
