//
//  ADInitialController.swift
//  AdyenPlacesSearch
//
//  Created by REINA on 06/07/22.
//

import UIKit

class ADInitialController: UIViewController {
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = ADColor.clear
        return table
    }()
    
    lazy var topbarView: ADTopBarView = {
        let view = ADTopBarView()
        view.backgroundColor = ADColor.clear
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = ADColor.clear
        label.textAlignment = .center
        label.font = ADFont.systemBold_20
        label.textColor = ADColor.buttonColor
        label.text = ADString.dataLoading
        return label
    }()
    
    var selectedIndexPath:IndexPath?
    var filterView: ADFilterView?
    var filterType:ADFiltersType?
    var datasource:[Response.Place]?
    var searchDataSource:[Response.Place]?
    lazy var viewModel = ADViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ADColor.backgroundColor
        initialSetup()
        viewModelCallbacks()
        viewModel.fetchPlaces()
    }
    
    func viewModelCallbacks() {
        viewModel.updatePlaces = {[weak self](places, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self?.alert(message: error.localizedDescription, title: ADString.error)
                }else if let places = places{
                    self?.datasource = places
                    self?.searchDataSource = self?.datasource
                    self?.textLabel.isHidden = true
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        guard let filterView = filterView else { return }
        filterView.reload()
    }
    
    override func viewDidLayoutSubviews() {
        guard let filterView = filterView else { return }
        filterView.reload()
    }
}
