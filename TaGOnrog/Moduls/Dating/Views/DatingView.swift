//
//  DatingView.swift
//  TaGOnrog
//
//  Created by Сергей Бекезин on 19.04.2024.
//

import UIKit
import TinyConstraints
import Shuffle_iOS

class DatingView: UIView, SwipeCardStackDataSource, SwipeCardStackDelegate {
    
    let cardStack = SwipeCardStack()
    var currentButton: DatingCardView?
    
    var hand: ((Int) -> Void)?
    
    var cardsList: [DatingModel] = [
        DatingModel(aboutMe: "Привет! Я Александра, 28-летняя писательница и путешественница.", tags: ["путешествия", "дорога", "приключения", "туризм", "туса", "поход", "мир"]),
        DatingModel(aboutMe: "Привет! Меня зовут Максим", tags: ["32131", "33", "fddsvvds"]),
        DatingModel(aboutMe: "Привет! Меня зовут Екатерина, и я - профессиональный фотограф. Моя страсть к фотографии началась в детстве, когда я получила свою первую камеру.", tags: ["32131", "33", "fddsvvds"]),
        DatingModel(aboutMe: "Привет! Я Дмитрий, амбициозный предприниматель и путешественник. Я всегда мечтал создать собственный бизнес, и сейчас я владею несколькими успешными компаниями в разных отраслях.", tags: ["32131", "33", "fddsvvds"]),
        DatingModel(aboutMe: "Привет! Меня зовут Анна, и я - фрилансер-дизайнер. Мое творческое воображение и любовь к искусству позволяют мне создавать уникальные и привлекательные дизайны для различных проектов.", tags: ["пианино", "музыка", "выступления"]),
        DatingModel(aboutMe: "Привет! Я Иван, и я - психолог по образованию и писатель по призванию. Мое стремление понять человеческую природу и помочь людям привело меня к изучению психологии.", tags: ["пианино", "музыка", "выступления"]),
        DatingModel(aboutMe: "Привет! Я Алиса, и я - педагог с большим опытом работы. Я обожаю работать с детьми и помогать им раскрыть свой потенциал. В моей работе я стараюсь создать комфортную и вдохновляющую обучающую среду, чтобы каждый ребенок мог расти и развиваться", tags: ["пианино", "музыка", "выступления"]),
        DatingModel(aboutMe: "Привет! Я Марина, и я - профессиональный пианист. Музыка всегда была моей страстью, и я посвятила всю свою жизнь игре на пианино.", tags: ["пианино", "музыка", "выступления"])
    ]
    
    func setup() {
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        cardStack.dataSource = self
        cardStack.delegate = self
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
    
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        hand?(index)
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return cardsList.count
    }
    
}
