//
//  QuestionGroupCaretaker.swift
//  Rabble Wabble
//
//  Created by Mohammed Faizuddin on 9/4/22.
//

import Foundation

public final class QuestionGroupCaretaker {

    private let fileName = "QuestionGroupData"
    public var questionGroups: [QuestionGroup] = []
    public var selectedQuestionsGroup: QuestionGroup!

    public init() {
        loadQuestionGroups()
    }

    private func loadQuestionGroups() {
        if let questionGroups = try? DiskCaretaker.retrieve([QuestionGroup].self, from: fileName) {
            self.questionGroups = questionGroups
        } else {
            let bundle = Bundle.main
            let url = bundle.url(forResource: fileName, withExtension: "json")!
            self.questionGroups = try! DiskCaretaker.retrieve([QuestionGroup].self, from: url)
            try! save()
        }
    }

    public func save() throws {
        try DiskCaretaker.save(questionGroups, to: fileName)
    }
}
