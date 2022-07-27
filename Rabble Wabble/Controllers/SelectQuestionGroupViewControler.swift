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

    public let questionsGroup = QuestionGroup.allGroups()
    private var selectedQuestionGroup: QuestionGroup!
}

extension SelectQuestionViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsGroup.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
        let questionGroup = questionsGroup[indexPath.row]
        cell.titleLabel.text = questionGroup.title
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
        guard let viewController = segue.destination as? QuestionViewController else { return }
        viewController.questionGroup = selectedQuestionGroup
        viewController.delegate = self
    }
}

extension SelectQuestionViewController: QuestionViewControllerDelegate {
    public func questionViewController(_ viewController: UIViewController,
                                       didCancel questionGroup: QuestionGroup,
                                       at questionIndex: Int) {
        navigationController?.popToViewController(self, animated: true)
    }

    public func questionViewController(_ viewController: UIViewController,
                                       didComplete questionGroup: QuestionGroup) {
        navigationController?.popToViewController(self, animated: true)
    }
}
