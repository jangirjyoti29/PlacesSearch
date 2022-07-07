//
//  ADTopBarView.swift
//  AdyenPlacesSearch
//
//  Created by REINA on 06/07/22.
//

import UIKit

protocol ADTopBarViewDelegate : AnyObject {
    func didTapOnFilterButton()
}

class ADTopBarView: UIView {
    weak var delegate:ADTopBarViewDelegate?
    
    lazy var staticLabel:UILabel = {
        let label = UILabel()
        label.font = ADFont.systemBold_30
        label.text = ADString.allPlaces
        label.textAlignment = .left
        return label
    }()
    
    lazy var filterButton:UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [.font: ADFont.systemRegular_20,.foregroundColor: ADColor.blue,.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedTitle = NSAttributedString(string: ADString.filters, attributes:attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.addTarget(self, action: #selector(didTapOnFilterButton), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        initialSetup()
        layoutSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        self.addSubview(staticLabel)
        self.addSubview(filterButton)
    }
    
    func layoutSetup() {
        filterButton.anchor(top: self.topAnchor, bottom: self.bottomAnchor,trailing: self.trailingAnchor, topConstant: 0, bottomConstant: 0, trailingConstant: 0, widthConstant: ADConstant.filterButtonWidth)

        staticLabel.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: filterButton.leadingAnchor, topConstant: 0, bottomConstant: 0, leadingConstant: ADConstant.allPlacesLabelConstant, trailingConstant: ADConstant.allPlacesLabelConstant)
    }
    
    @objc private func didTapOnFilterButton() {
        delegate?.didTapOnFilterButton()
    }
}
