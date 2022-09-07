//
//  Models.swift
//  Rabble Wabble
//
//  Created by Faizuddin Mohammed on 3/29/22.
//

import Foundation
import Combine

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
        public var correctCount: Int = 0 {
            didSet { updateRunningPercentage() }
        }

        public var incorrectCount: Int = 0 {
            didSet { updateRunningPercentage() }
        }

        @Published public var runningPercentage: Double = 0

        public init() { }

        private enum CodingKeys: String, CodingKey {
            case correctCount
            case incorrectCount
        }

        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.correctCount = try container.decode(Int.self, forKey: .correctCount)
            self.incorrectCount = try container.decode(Int.self, forKey: .incorrectCount)
            updateRunningPercentage()
        }

        private func updateRunningPercentage() {
            let totalCount = correctCount + incorrectCount
            guard totalCount > 0 else {
                runningPercentage = 0
                return
            }
            runningPercentage = Double(correctCount) / Double(incorrectCount)
        }

        public func reset() {
            correctCount = 0
            incorrectCount = 0
        }
    }


    public let questions: [Question]
    public private(set) var score: Score
    public let title: String

    public init(questions: [Question],
         score: Score = Score(),
         title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }
}

