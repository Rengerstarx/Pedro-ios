//
//  DatingView.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 19.04.2024.
//

import UIKit
import TinyConstraints
import Shuffle_iOS

class DatingView: UIView, SwipeCardStackDataSource {
    
    let cardStack = SwipeCardStack()
    var currentButton: DatingCardView?
    
    var cardsList: [DatingModel] = [
        DatingModel(aboutMe: "32131312", tags: ["32131", "33", "fddsvvds"]),
        DatingModel(aboutMe: "32131312", tags: ["32131", "33", "fddsvvds"]),
        DatingModel(aboutMe: "32131312", tags: ["32131", "33", "fddsvvds"]),
        DatingModel(aboutMe: "32131312", tags: ["32131", "33", "fddsvvds"]),
        DatingModel(aboutMe: "32131312", tags: ["32131", "33", "fddsvvds"]),
        DatingModel(aboutMe: "32131312", tags: ["32131", "33", "fddsvvds"]),
        DatingModel(aboutMe: "32131312", tags: ["32131", "33", "fddsvvds"]),
        DatingModel(aboutMe: "32131312", tags: ["32131", "33", "fddsvvds"])
    ]
    
    func setup() {
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        cardStack.dataSource = self
        backgroundColor = .appClear
        
        // TODO: get cardList
    }
    
    private func setupLayouts() {
        addSubview(cardStack)
        cardStack.edgesToSuperview(insets: .uniform(20))
    }
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = DatingCardView()
        card.setup(model: cardsList[index])
        currentButton = card
        currentButton?.hadler = { [weak self] result in
            self?.cardStack.swipe(result ? .left : .right, animated: true)
        }
        return card
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return cardsList.count
    }
    
}
