//
//  RandomQuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Mohammed Faizuddin on 9/3/22.
//

import Foundation
import GameplayKit.GKRandomSource

public class RandomQuestionStrategy: QuestionStrategy {

    private let questionGroup: QuestionGroup
    private var questionIndex = 0
    private let questions: [Question]

    public var title: String {
        questionGroup.title
    }

    public var correctCount: Int = 0
    public var incorrectCount: Int = 0

    public init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup

        let randomSource = GKRandomSource.sharedRandom()
        self.questions = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
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
        return "\(questionIndex)/\(questionGroup.questions.count)"
    }
}
