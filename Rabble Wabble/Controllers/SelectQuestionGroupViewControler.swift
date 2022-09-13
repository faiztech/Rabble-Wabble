//
//  SelectQuestionGroupViewControler.swift
//  Rabble Wabble
//
//  Created by Mohammed Faizuddin on 7/20/22.
//

import UIKit

public class SelectQuestionViewController: UIViewController {

    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    private let appSettings = AppSettings.shared

    private let questionGroupsCaretaker = QuestionGroupCaretaker()
    private var questionsGroup: [QuestionGroup] {
        questionGroupsCaretaker.questionGroups
    }
    private var selectedQuestionGroup: QuestionGroup! {
        get { return questionGroupsCaretaker.selectedQuestionsGroup }
        set { questionGroupsCaretaker.selectedQuestionsGroup = newValue }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        questionsGroup.forEach {
            print("\($0.title)" + "correctCount \($0.score.correctCount), " + "incorrectCount \($0.score.incorrectCount)")
        }
    }
}

extension SelectQuestionViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsGroup.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
        let questionGroup = questionsGroup[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        cell.percentageSubscriber = questionGroup.score.$runningPercentage.receive(on: DispatchQueue.main)
            .map() {
                return String(format: "%.0f %%", round(100 * $0))
            }.assign(to: \.text, on: cell.percentageLabel)
        return cell
    }
}

extension SelectQuestionViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionsGroup[indexPath.row]
        return indexPath
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? QuestionViewController {
        viewController.questionStrategy = appSettings.questionStrategy(for: questionGroupsCaretaker)
        viewController.delegate = self
        } else if let navController = segue.destination as? UINavigationController,
                  let viewController = navController.topViewController as? CreateQuestionGroupViewController {
            viewController.delegate = self
        }
    }
}

extension SelectQuestionViewController: QuestionViewControllerDelegate {
    public func questionViewController(_ viewController: UIViewController,
                                       didCancel questionGroup: QuestionStrategy,
                                       at questionIndex: Int) {
        navigationController?.popToViewController(self, animated: true)
    }

    public func questionViewController(_ viewController: UIViewController,
                                       didComplete questionGroup: QuestionStrategy) {
        navigationController?.popToViewController(self, animated: true)
    }
}

extension SelectQuestionViewController: CreateQuestionGroupViewControllerDelegate {
    public func createQuestionGroupViewControllerDidCancel(_ viewController: CreateQuestionGroupViewController) {
        dismiss(animated: true)
    }

    public func createQuestionGroupViewController(_ viewController: CreateQuestionGroupViewController, created questionGroup: QuestionGroup) {
        questionGroupsCaretaker.questionGroups.append(questionGroup)
        try? questionGroupsCaretaker.save()

        dismiss(animated: true)
        tableView.reloadData()
    }
}
