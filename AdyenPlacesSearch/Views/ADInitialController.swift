//
//  ADInitialController.swift
//  AdyenPlacesSearch
//
//  Created by REINA on 06/07/22.
//

import UIKit

/**
 ADInitialController :  Entry view controller which is responsible for fetching data using View Model and displaying that data on views.
 - In `viewDidLoad` fetchPlaces method of view model is being called and In `updatePlaces` callback of view model tableview is reloaded with updated data.
 */
class ADInitialController: UIViewController {
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = ADColor.clear
        return table
    }()
    
    /***
     topbarView is an object of ADTopBarView which contains a label and a filter button.
     */
    lazy var topbarView: ADTopBarView = {
        let view = ADTopBarView()
        view.backgroundColor = ADColor.clear
        return view
    }()
    
    /***
     text Label is used to show text when data is being fetched from API, OR there is no data available for applied filters.
     */
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = ADColor.clear
        label.textAlignment = .center
        label.font = ADFont.systemBold_20
        label.textColor = ADColor.buttonColor
        label.text = ADString.dataLoading
        return label
    }()
    
    /***
     The current  selected index path for tableView.
     */
    var selectedIndexPath:IndexPath?
    
    /***
     filterView is an object of ADFilterView.
     */
    var filterView: ADFilterView?
    
    /***
     filterType is an object of ADFiltersType.
     */
    var filterType:ADFiltersType?
    
    var datasource:[Response.Place]?
    var searchDataSource:[Response.Place]?
    
    /***
     viewModel is an object of ADViewModel.
     */
    lazy var viewModel = ADViewModel.shared()
    
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
}
