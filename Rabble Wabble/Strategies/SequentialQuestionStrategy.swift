//
//  SequentialQuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Mohammed Faizuddin on 9/3/22.
//

import Foundation

public class SequentialQuestionStrategy: BaseQuestionStrategy {

    public convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionsGroup!
        let questions = questionGroup.questions
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
}
