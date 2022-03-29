//
//  Models.swift
//  Rabble Wabble
//
//  Created by Faizuddin Mohammed on 3/29/22.
//

import Foundation

public struct Question {
    public let answer: String
    public let hint: String?
    public let prompt: String
}

public struct QuestionGroup {
    public let questions: [Question]
    public let title: String
}

