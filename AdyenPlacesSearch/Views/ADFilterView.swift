//
//  ADFilterView.swift
//  AdyenPlacesSearch
//
//  Created by REINA on 06/07/22.
//

import UIKit

enum ADFiltersSort: String {
    case distance
    case name
}

enum ADFiltersCategory: String {
    case one
    case two
    case three
    case more
}

enum ADFiltersAction: Int {
    case close
    case reset
    case apply
}

/**
 All the filter types.
 */
struct ADFiltersType {
    var range:Int?
    var totalRange:Int?
    var sort:String?
    var categoryCount:String?
}

protocol ADFilterViewDelegate : AnyObject {
    func didPerformFilter(action:ADFiltersAction, type:ADFiltersType?)
}

/**
 An object which is resposible for Filter View.
 - It is having Range, Sorting and Categories filters.
 - On Tap on reset button, All the applied filter will be removed and original data will be reloaded.
 - On Tap on apply button, Places data will be loaded according to applied filters.
 */
class ADFilterView: UIView {
    weak var delegate:ADFilterViewDelegate?
    private var filterType:ADFiltersType?
    
    lazy var filterLabel:UILabel = {
        let label = UILabel()
        label.font = ADFont.systemBold_30
        label.textAlignment = .center
        label.text = ADString.filters
        label.textColor = ADColor.black
        return label
    }()
    
    lazy var closeButton:UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [.font: ADFont.systemRegular_15,.foregroundColor: ADColor.red]
        let attributedTitle = NSAttributedString(string: ADString.close, attributes:attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    lazy var applyButton:UIButton = {
        let button = UIButton()
        button.setTitle(ADString.apply, for: .normal)
        button.setTitleColor(ADColor.white, for: .normal)
        button.titleLabel?.font = ADFont.systemBold_20
        button.backgroundColor = ADColor.buttonColor
        button.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    
    lazy var resetButton:UIButton = {
        let button = UIButton()
        button.setTitle(ADString.reset, for: .normal)
        button.setTitleColor(ADColor.white, for: .normal)
        button.titleLabel?.font = ADFont.systemBold_20
        button.backgroundColor = ADColor.buttonColor
        button.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
        button.tag = 3
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = ADColor.clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var verticalStackView: UIStackView = {
        let verticalFirstStackView = UIStackView()
        verticalFirstStackView.axis = .vertical
        verticalFirstStackView.alignment = .center
        verticalFirstStackView.spacing = ADConstant.stackViewSpacing
        verticalFirstStackView.distribution = .equalSpacing
        return verticalFirstStackView
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let horizontalFirstStackView = UIStackView()
        horizontalFirstStackView.axis = .horizontal
        horizontalFirstStackView.alignment = .leading
        horizontalFirstStackView.spacing = ADConstant.stackViewSpacing
        horizontalFirstStackView.distribution = .equalSpacing
        return horizontalFirstStackView
    }()
    
    lazy var rangeValue:UILabel = {
        let label = UILabel()
        label.font = ADFont.systemBold_15
        label.textColor = ADColor.blue
        label.textAlignment = .center
        return label
    }()
    
    lazy var rangeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.thumbTintColor = ADColor.buttonColor
        slider.tintColor = ADColor.buttonColor
        slider.addTarget(self, action: #selector(didSliderMove), for: .valueChanged)
        return slider
    }()
    
    lazy var sortSegmentedControl: UISegmentedControl = {
        let sortSegment = UISegmentedControl.init(items: [ADFiltersSort.distance.rawValue, ADFiltersSort.name.rawValue])
        sortSegment.addTarget(self, action: #selector(didSegmentedControlTap), for: .valueChanged)
        sortSegment.selectedSegmentTintColor = ADColor.buttonColor
        sortSegment.setTitleTextAttributes([.font: ADFont.systemRegular_15,.foregroundColor: ADColor.black], for: .normal)
        sortSegment.tag = 1
        return sortSegment
    }()
    
    lazy var categorySegmentedControl: UISegmentedControl = {
        let categorySegment = UISegmentedControl.init(items: [ADFiltersCategory.one.rawValue, ADFiltersCategory.two.rawValue, ADFiltersCategory.three.rawValue, ADFiltersCategory.more.rawValue])
        categorySegment.addTarget(self, action: #selector(didSegmentedControlTap), for: .valueChanged)
        categorySegment.selectedSegmentTintColor = ADColor.buttonColor
        categorySegment.tag = 2
        categorySegment.setTitleTextAttributes([.font: ADFont.systemRegular_15,.foregroundColor: ADColor.black], for: .normal)
        return categorySegment
    }()
    
    init(filterType:ADFiltersType) {
        super.init(frame: .zero)
        self.backgroundColor = ADColor.backgroundColor
        self.filterType = filterType
        initialSetup()
        layoutSetup()
        updateData()
        reload()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        self.addSubview(filterLabel)
        self.addSubview(closeButton)
        self.addSubview(scrollView)
        scrollView.addSubview(verticalStackView)
        
        applyButton.shadow()
        resetButton.shadow()
    }
    
    func layoutSetup() {
        filterLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, topConstant: ADConstant.closeButtonTop, heightConstant: ADConstant.filterLabelHeight, widthConstant: ADConstant.filterLabelWidth)
        filterLabel.centerAnchors(centerX: self.centerXAnchor, centerY: nil)
        
        closeButton.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, topConstant: ADConstant.closeButtonTop, leadingConstant: ADConstant.closeButtonLeft,  heightConstant: ADConstant.filterLabelHeight, widthConstant: ADConstant.closeButtonWidth)
        
        scrollView.anchor(top: filterLabel.bottomAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, topConstant: ADConstant.scrollViewConstant, bottomConstant: ADConstant.scrollViewConstant, leadingConstant: ADConstant.scrollViewConstant, trailingConstant: ADConstant.scrollViewConstant)
        
        verticalStackView.anchor(top: scrollView.topAnchor, topConstant: 0, heightConstant: ADConstant.scrollViewHeight, widthConstant:ADConstant.scrollViewWidth)
        verticalStackView.centerAnchors(centerX: scrollView.centerXAnchor, centerY: nil)
        
        let range = label(text: ADString.range)
        range.anchor(heightConstant: ADConstant.rangeSliderHeight, widthConstant: ADConstant.scrollViewWidth)
        rangeValue.anchor(heightConstant: ADConstant.rangeValueHeight, widthConstant: ADConstant.scrollViewWidth)
        rangeSlider.anchor(heightConstant: ADConstant.rangeSliderHeight, widthConstant: ADConstant.scrollViewWidth)
        
        verticalStackView.addArrangedSubview(range)
        verticalStackView.addArrangedSubview(rangeValue)
        verticalStackView.addArrangedSubview(rangeSlider)
        
        let sortBy = label(text: ADString.sortBy)
        sortBy.anchor(heightConstant: ADConstant.rangeSliderHeight, widthConstant: ADConstant.scrollViewWidth)
        sortSegmentedControl.anchor(heightConstant: ADConstant.segmentHeight, widthConstant: ADConstant.scrollViewWidth)
        
        verticalStackView.addArrangedSubview(sortBy)
        verticalStackView.addArrangedSubview(sortSegmentedControl)
        
        let categories = label(text: ADString.categories)
        categories.anchor(heightConstant: ADConstant.rangeSliderHeight, widthConstant: ADConstant.scrollViewWidth)
        categorySegmentedControl.anchor(heightConstant: ADConstant.segmentHeight, widthConstant: ADConstant.scrollViewWidth)
        
        verticalStackView.addArrangedSubview(categories)
        verticalStackView.addArrangedSubview(categorySegmentedControl)
        
        let empty = label(text: "")
        empty.anchor(heightConstant: ADConstant.segmentHeight, widthConstant: ADConstant.scrollViewWidth)
        verticalStackView.addArrangedSubview(empty)
        
        
        horizontalStackView.anchor(heightConstant: ADConstant.segmentHeight, widthConstant: ADConstant.scrollViewWidth)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        resetButton.anchor(heightConstant: ADConstant.segmentHeight, widthConstant: ADConstant.resetButtonWidth)
        applyButton.anchor(heightConstant: ADConstant.segmentHeight, widthConstant: ADConstant.resetButtonWidth)
        
        horizontalStackView.addArrangedSubview(resetButton)
        horizontalStackView.addArrangedSubview(applyButton)
    }
    
    func label(text:String) -> UILabel{
        let label = UILabel()
        label.font = ADFont.systemBold_20
        label.textAlignment = .left
        label.text = text
        label.textColor = ADColor.black
        return label
    }
    
    @objc private func didButtonTap(button:UIButton) {
        switch button.tag {
        case 1:
            delegate?.didPerformFilter(action: .close, type: filterType)
        case 2:
            delegate?.didPerformFilter(action: .apply, type: filterType)
        case 3:
            delegate?.didPerformFilter(action: .reset, type: filterType)
        default:
            print("")
        }
    }
    
    @objc private func didSegmentedControlTap(segmentedControl:UISegmentedControl) {
        switch segmentedControl.tag {
        case 1:
            filterType!.sort = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        case 2:
            filterType!.categoryCount = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        default:
            print("")
        }
    }
    
    @objc private func didSliderMove(slider:UISlider) {
        rangeValue.alpha = 1
        rangeValue.text = "\(Int(slider.value))m"
        filterType!.range = Int(slider.value)
        UIView.animate(withDuration: 2, delay: 0) {[weak self] in
            self?.rangeValue.alpha = 0
        }
    }
    
    func updateData() {
        rangeSlider.maximumValue = Float(filterType!.totalRange!)
        rangeSlider.value = Float(filterType!.range!)
        if let sort = filterType?.sort, sort != "" {
            switch sort {
            case ADFiltersSort.distance.rawValue:
                sortSegmentedControl.selectedSegmentIndex = 0
            case ADFiltersSort.name.rawValue:
                sortSegmentedControl.selectedSegmentIndex = 1
            default:
                print("")
            }
        }
        
        if let categoryCount = filterType?.categoryCount, categoryCount != "" {
            switch categoryCount {
            case ADFiltersCategory.one.rawValue:
                categorySegmentedControl.selectedSegmentIndex = 0
            case ADFiltersCategory.two.rawValue:
                categorySegmentedControl.selectedSegmentIndex = 1
            case ADFiltersCategory.three.rawValue:
                categorySegmentedControl.selectedSegmentIndex = 2
            case ADFiltersCategory.more.rawValue:
                categorySegmentedControl.selectedSegmentIndex = 3
            default:
                print("")
            }
        }
    }
    
    func reload() {
        scrollView.contentSize = CGSize.init(width: ADConstant.scrollViewWidth, height: ADConstant.scrollViewHeight)
    }
}
