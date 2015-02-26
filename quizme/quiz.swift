//
//  quiz.swift
//  quizme
//
//  Created by Ricky Yim on 26/02/2015.
//  Copyright (c) 2015 dius. All rights reserved.
//

import Foundation
import JSONJoy

class Quiz {
    let cards = [FlashCard]()
    var index = 0
    
    init() {
        
    }
    
    init(jsonDecoder: JSONDecoder) {
        let data = jsonDecoder["data"].array!
        
        for d in data {
            cards.append(FlashCard(image: d["image"].string!, name: d["translation"].string!))
        }        
    }
    
    func currentFlashCard() -> FlashCard {
        return cards[index]
    }
    
    func next() {
        let nextIndex = index + 1
        if (nextIndex == cards.count) {
            index = 0
        } else {
            index = nextIndex
        }
    }
    
    func prev() {
        let prevIndex = index - 1
        if (prevIndex < 0) {
            index = 0
        } else {
            index = prevIndex
        }
    }
}

class FlashCard {
    let image: String
    let name: String
    
    init(image: String, name: String) {
        self.image = image
        self.name = name
    }
}