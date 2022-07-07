//
//  ADInitialController+TableViewDelegates.swift
//  AdyenPlacesSearch
//
//  Created by REINA on 06/07/22.
//

import UIKit

extension ADInitialController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let datasource = searchDataSource else { return 0 }
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ADString.placeCellId, for: indexPath) as! ADPlaceCell
        cell.indexPath = indexPath
        cell.setPlaceData(place: searchDataSource?[indexPath.section])
        
        cell.updateCellFooterView = {[weak self] (indexPath) in
            self?.selectedIndexPath = indexPath
            self?.tableView.reloadData()
        }
        return cell
    } 
}

extension ADInitialController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ADConstant.tableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let selectedIndexPath = selectedIndexPath, section ==  selectedIndexPath.section {
            return ADConstant.collectionViewCellHeight
        }
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let selectedIndexPath = selectedIndexPath, let place = searchDataSource?[selectedIndexPath.section], let category = place.categories {
            let footerView = ADPlaceFooterView.init(categoryDataSource: category)
            return footerView
        }
        return nil
    }
}
