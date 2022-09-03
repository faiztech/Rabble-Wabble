//
//  SequentialQuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Mohammed Faizuddin on 9/3/22.
//

import Foundation

public class SequentialQuestionStrategy: QuestionStrategy {

    private let questionGroup: QuestionGroup
    private var questionIndex = 0

    public var title: String {
        questionGroup.title
    }

    public var correctCount: Int = 0
    public var incorrectCount: Int = 0

    public init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
    }

    public func advanceToNextQuestion() -> Bool {
        guard questionIndex + 1 < questionGroup.questions.count else { return false }
        questionIndex += 1
        return true
    }

    public func currentQuestion() -> Question {
        questionGroup.questions[questionIndex]
    }

    public func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }

    public func markQuestionIncorrect(_ question: Question) {
        incorrectCount += 1
    }

    public func questionIndexTitle() -> String {
        return "\(questionIndex + 1)/\(questionGroup.questions.count)"
    }
}
