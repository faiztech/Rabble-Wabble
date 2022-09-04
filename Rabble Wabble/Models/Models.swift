//
//  Models.swift
//  Rabble Wabble
//
//  Created by Faizuddin Mohammed on 3/29/22.
//

import Foundation

public class Question: Codable {
    public let answer: String
    public let hint: String?
    public let prompt: String

    public init(answer: String, hint: String?, prompt: String) {
        self.answer = answer
        self.hint = hint
        self.prompt = prompt
    }
}

public class QuestionGroup: Codable {
    public class Score: Codable {
        public var correctCount: Int = 0
        public var incorrectCount: Int = 0
        public init() { }
    }
    public let questions: [Question]
    public var score: Score
    public let title: String

    public init(questions: [Question],
         score: Score = Score(),
         title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }
}

