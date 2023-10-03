//
//  ViewController.swift
//  Task
//
//  Created by Charles on 12/05/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import UIKit
import Reusable

class GoalListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,RefreshProtocol {
    
    // Mark - Outlet
    @IBOutlet weak var goalListTableView: UITableView!
    
    // Mark - Property
    private var goals:[OnGoing] = []
    private var viewState:ViewState = .viewLess
    private var selectedIndexPath:IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeSeperateStyle()
        registerTableViewCell()
        loadGoalData()
    }
    
    private func removeSeperateStyle() {
        self.goalListTableView.separatorStyle = .none
    }
    
    private func loadGoalData() {
        guard let goals = loadData() else {
            return
        }
        self.goals = goals
        print(goals)
    }
    
    private func registerTableViewCell() {
        self.goalListTableView.register(cellType: GoalListTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:GoalListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if selectedIndexPath != nil {
            cell.populatedData(goal: self.goals[indexPath.row],
                               listener: self,
                               state: self.viewState,
                               indexPath: indexPath,
                               selectedIndexPath: self.selectedIndexPath)
        }else {
            cell.populatedData(goal: self.goals[indexPath.row],
                               listener: self,
                               state: self.viewState,
                               indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func loadData() -> [OnGoing]? {
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.result.ongoing
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func onRefreshCell(state: ViewState, selectedIndexPath: IndexPath) {
        self.viewState = state
        self.selectedIndexPath = selectedIndexPath
        self.goalListTableView.reloadData()
    }
    
    
    
}

