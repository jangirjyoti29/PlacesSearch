//
//  ADInitialController+UISetup.swift
//  AdyenPlacesSearch
//
//  Created by REINA on 06/07/22.
//

import UIKit

extension ADInitialController {
    
    func initialSetup() {
        topbarViewSetup()
        textLabelSetup()
        tableViewSetup()
    }
    
    func textLabelSetup() {
        self.view.addSubview(textLabel)
        
        textLabel.anchor(top: topbarView.bottomAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, topConstant: ADConstant.tableViewTop, bottomConstant: 0, leadingConstant: 0, trailingConstant: 0)
    }
    
    func tableViewSetup() {
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ADPlaceCell.self, forCellReuseIdentifier: ADString.placeCellId)
        
        tableView.anchor(top: topbarView.bottomAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, topConstant: ADConstant.tableViewTop, bottomConstant: 0, leadingConstant: 0, trailingConstant: 0)
    }
    
    func topbarViewSetup() {
        self.view.addSubview(topbarView)
        topbarView.delegate = self
        
        topbarView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, topConstant: ADConstant.topBarConstant, leadingConstant: ADConstant.topBarConstant, trailingConstant: ADConstant.topBarConstant, heightConstant: ADConstant.topBarHeight)
    }
}

extension ADInitialController : ADTopBarViewDelegate {
    func didTapOnFilterButton() {
        if filterType == nil, let range = searchDataSource?[0].totalRadius {
            filterType = ADFiltersType.init(range: range, totalRange: range, sort: "", categoryCount: "")
        }
        guard let filterType = filterType else { return }
        filterView = ADFilterView.init(filterType: filterType)
        filterView?.alpha = 0.0
        self.view.addSubview(filterView!)
        filterView?.delegate = self
        
        filterView?.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, topConstant: 0, bottomConstant: 0, leadingConstant: 0, trailingConstant: 0)
        
        UIView.animate(withDuration: 0.5, delay: 0.0) {[weak self] in
            self?.filterView!.alpha = 1.0
        }
    }
}

extension ADInitialController: ADFilterViewDelegate {
    func didPerformFilter(action: ADFiltersAction, type: ADFiltersType?) {
        switch action {
        case .close: break
        case .apply:
            filterType = type
            performActionForApplyFilter()
            selectedIndexPath = nil
        case .reset:
            searchDataSource = datasource
            selectedIndexPath = nil
            filterType = nil
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {[weak self] in
            self?.filterView?.alpha = 0.0
        } completion: {[weak self] _ in
            self?.filterView?.removeFromSuperview()
            self?.filterView = nil
        }
        if searchDataSource?.count == 0 {
            textLabel.isHidden = false
            textLabel.text = ADString.noData
        }else {
            textLabel.isHidden = true
            textLabel.text = ""
        }
        tableView.reloadData()
    }
    
    func performActionForApplyFilter() {
        searchDataSource = datasource?.filter({$0.distance! <= filterType!.range!})
        if let sort = filterType?.sort {
            switch sort {
            case ADFiltersSort.distance.rawValue:
                searchDataSource = searchDataSource?.sorted(by: {$0.distance! < $1.distance!})
            case ADFiltersSort.name.rawValue:
                searchDataSource = searchDataSource?.sorted(by: {$0.name! < $1.name!})
            default:
                print("")
            }
        }
        if let category = filterType?.categoryCount {
            switch category {
            case ADFiltersCategory.one.rawValue:
                searchDataSource = searchDataSource?.filter({$0.categories!.count == 1})
            case ADFiltersCategory.two.rawValue:
                searchDataSource = searchDataSource?.filter({$0.categories!.count == 2})
            case ADFiltersCategory.three.rawValue:
                searchDataSource = searchDataSource?.filter({$0.categories!.count == 3})
            case ADFiltersCategory.more.rawValue:
                searchDataSource = searchDataSource?.filter({$0.categories!.count > 3})
            default:
                print("")
            }
        }
    }
}
