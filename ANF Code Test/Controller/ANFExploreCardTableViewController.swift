//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {

    private let segueID = "SegueToDetails"
    private var exploreData: [ExploreItem] = []
    var dataProvider: ExploreDataProvider = DefaultExploreDataProvider()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none

        if exploreData.isEmpty {
            exploreData = dataProvider.fetchData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exploreData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExploreContentCell", for: indexPath) as? ANFExploreTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: exploreData[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
