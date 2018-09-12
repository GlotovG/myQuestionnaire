//
//  Question.swift
//  myQuestionnaire
//
//  Created by Gennadiy Glotov on 10.09.2018.
//  Copyright © 2018 Gennadiy Glotov. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case coctale = "🍹", beer = "🍻", vine = "🥂", vodka = "🥃"
    
    var definition: String {
        switch self {
        case .coctale:
            return "Вам потребоуется много разного алкоголя 💃"
        case .beer:
            return "Вам потребуется пиво"
        case .vine:
            return "Вам потребуется вино/шампанское"
        case .vodka:
            return "Тут потребуется что-то крепкое(40С)"
        }
    }
}
