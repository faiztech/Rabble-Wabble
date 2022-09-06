//
//  BaseQuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Mohammed Faizuddin on 9/6/22.
//

import Foundation

public class BaseQuestionStrategy: QuestionStrategy {

    public var correctCount: Int {
        get { return questionGroup.score.correctCount }
        set { questionGroup.score.correctCount = newValue }
    }
    public var incorrectCount: Int {
        get { return questionGroup.score.incorrectCount }
        set { questionGroup.score.incorrectCount = newValue }
    }

    private var questionGroupCaretaker: QuestionGroupCaretaker

    private var questionGroup: QuestionGroup {
        questionGroupCaretaker.selectedQuestionsGroup
    }

    private var questionIndex = 0
    private let questions: [Question]

    public init(questionGroupCaretaker: QuestionGroupCaretaker, questions: [Question]) {
        self.questionGroupCaretaker = questionGroupCaretaker
        self.questions = questions

        self.questionGroupCaretaker.selectedQuestionsGroup.score = QuestionGroup.Score()
    }

    public var title: String {
        questionGroup.title
    }

    public func advanceToNextQuestion() -> Bool {
        try? questionGroupCaretaker.save()
        guard questionIndex + 1 < questionGroup.questions.count else { return false }
        questionIndex += 1
        return true
    }

    public func currentQuestion() -> Question {
        questions[questionIndex]
    }

    public func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }

    public func markQuestionIncorrect(_ question: Question) {
        incorrectCount += 1
    }

    public func questionIndexTitle() -> String {
        return "\(questionIndex + 1)/\(questions.count)"
    }
}
