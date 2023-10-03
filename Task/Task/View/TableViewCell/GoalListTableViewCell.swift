//
//  GoalListTableViewCell.swift
//  Task
//
//  Created by Charles on 12/05/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import UIKit
import Reusable

class GoalListTableViewCell: UITableViewCell,NibReusable {
    
    // Mark - Outlet
    @IBOutlet weak var viewMoreView: UIView!
    @IBOutlet weak var editInputView: UIView!
    @IBOutlet weak var transactionView: UIView!
    @IBOutlet weak var viewLessView: UIView!
    
    // Mark - Precentage Outlets
    @IBOutlet weak var perentageLabel: UILabel!
    
    // Mark - TopContainer
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    // Mark - Transction Outlets
    @IBOutlet weak var transactionStackView: UIStackView!
    @IBOutlet weak var transactionHeightConstraint: NSLayoutConstraint!
    
    // Mark - Transaction Height Constraint
    
    
    // Mark - Property
    private var listener:RefreshProtocol?
    private var indexPath:IndexPath!
    private var state:ViewState!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        removeSelectionStyle()
        setupTapGesture()
    }
    
    private func setupTapGesture() {
        let viewMoreTap = UITapGestureRecognizer(target: self, action: #selector(onViewMoreClicked))
        self.viewMoreView.isUserInteractionEnabled = true
        self.viewMoreView.addGestureRecognizer(viewMoreTap)
        
        let viewLessTap = UITapGestureRecognizer(target: self, action: #selector(onViewLessClicked))
        self.viewLessView.isUserInteractionEnabled = true
        self.viewLessView.addGestureRecognizer(viewLessTap)
    }
    
    override func prepareForReuse() {
        self.perentageLabel.text = ""
        self.amountLabel.text = ""
        self.descriptionLabel.text = ""
        self.transactionStackView.removeAllViews()
    }
    
    @objc func onViewMoreClicked(_ sender:UITapGestureRecognizer) {
        self.state = .viewMore
        listener?.onRefreshCell(state: self.state, selectedIndexPath: indexPath)
    }
    
    public func showViewMore() {
        self.viewMoreView.isHidden = true
        self.editInputView.isHidden = false
        self.transactionView.isHidden = false
        self.viewLessView.isHidden = false
    }
    
    public func showViewLess() {
        self.viewMoreView.isHidden = false
        self.editInputView.isHidden = true
        self.transactionView.isHidden = true
        self.viewLessView.isHidden = true
    }
    
    @objc func onViewLessClicked(_ sender:UITapGestureRecognizer) {
        self.state = .viewLess
        listener?.onRefreshCell(state: self.state, selectedIndexPath: indexPath)
    }
    
    private func removeSelectionStyle() {
        self.selectionStyle = .none
    }
    
    public func populatedData(goal:OnGoing,listener:RefreshProtocol,state:ViewState,indexPath:IndexPath,selectedIndexPath:IndexPath! = nil) {
        self.listener = listener
        self.indexPath = indexPath
        self.state = state
        let percentage = Double(goal.wish_percentage) ?? 0
        self.perentageLabel.text = "\(Int(round(percentage)))%"
        self.descriptionLabel.text = goal.wish_title
        self.amountLabel.text = "$ \(goal.total_amount).00"
        self.populatedTransactionContainer(goal: goal)
        if selectedIndexPath != nil {
             self.populatedViewState(indexPath: self.indexPath, selectedIndexPath: selectedIndexPath, state: state)
        }else {
            self.showViewLess()
        }
    }
    
    private func populatedViewState(indexPath:IndexPath,selectedIndexPath:IndexPath,state:ViewState) {
        if indexPath.row == selectedIndexPath.row {
            if state == .viewMore {
                 self.showViewMore()
            }else {
               self.showViewLess()
            }
        }else {
            self.showViewLess()
        }
    }
    
    private func populatedTransactionContainer(goal:OnGoing) {
        for transaction in goal.transactions {
            let loadFromNib = TransactionView.loadFromNib()
            loadFromNib.frame = CGRect(x: 0, y: 0, width: loadFromNib.frame.width, height: 100)
            loadFromNib.populatedData(transaction: transaction)
            self.transactionStackView.translatesAutoresizingMaskIntoConstraints = false
            self.transactionStackView.addArrangedSubview(loadFromNib)
        }
        self.transactionHeightConstraint.constant = CGFloat(100 * goal.transactions.count)
        self.transactionStackView.reloadInputViews()
        self.transactionStackView.setNeedsLayout()
        self.transactionStackView.layoutIfNeeded()
    }
}

public protocol RefreshProtocol {
    func onRefreshCell(state:ViewState,selectedIndexPath:IndexPath)
}
