//
//  ADCellContentView.swift
//  AdyenPlacesSearch
//
//  Created by REINA on 07/07/22.
//

import UIKit

protocol ADCellContentViewDelegate : AnyObject {
    func didTapOnExploreButton()
    func loadImage(url:URL)
}

extension ADCellContentViewDelegate {
    func didTapOnExploreButton() {}
    func loadImage(url:URL) {}
}

class ADCellContentView: UIView {
    weak var delegate:ADCellContentViewDelegate?
    
    lazy var nameLB:UILabel = {
        let name = UILabel()
        name.font = ADFont.systemBold_20
        name.textAlignment = .left
        name.numberOfLines = 2
        return name
    }()
    
    lazy var addressLB:UILabel = {
        let address = UILabel()
        address.font = ADFont.systemRegular_15
        address.textAlignment = .left
        address.numberOfLines = 3
        return address
    }()
    
    lazy var distanceLB:UILabel = {
        let distance = UILabel()
        distance.font = ADFont.systemLight_15
        distance.textAlignment = .left
        return distance
    }()
    
    lazy var timezoneLB:UILabel = {
        let timezone = UILabel()
        timezone.font = ADFont.systemLight_13
        timezone.textAlignment = .left
        return timezone
    }()
    
    lazy var neighborhoodLB:UILabel = {
        let neighborhood = UILabel()
        neighborhood.font = ADFont.systemLight_15
        neighborhood.textAlignment = .left
        neighborhood.numberOfLines = 2
        return neighborhood
    }()
    
    lazy var imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.backgroundColor = ADColor.clear
        return imageview
    }()
    
    lazy var exploreButton:UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [.font: ADFont.systemRegular_15,.foregroundColor: ADColor.blue,.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedTitle = NSAttributedString(string: ADString.exploreCategories, attributes:attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.isHidden = true
        button.addTarget(self, action: #selector(didExploreButtonTap), for: .touchUpInside)
        return button
    }()
    
    init(viewType:ADCellViewType) {
        super.init(frame: .zero)
        if viewType == .place {
            placeInitialSetup()
            placeLayoutSetup()
        }else {
            categoryInitialSetup()
            categoryLayoutSetup()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func placeInitialSetup() {
        self.addSubview(nameLB)
        self.addSubview(addressLB)
        self.addSubview(distanceLB)
        self.addSubview(timezoneLB)
        self.addSubview(neighborhoodLB)
        self.addSubview(imageView)
        self.addSubview(exploreButton)
    }
    
    func placeLayoutSetup() {
        imageView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, topConstant: ADConstant.placeCellImageConstant, bottomConstant: ADConstant.placeCellImageBottom, trailingConstant: ADConstant.placeCellImageConstant, widthConstant: ADConstant.placeCellImageWidth)
        exploreButton.anchor(top: imageView.bottomAnchor, bottom: self.bottomAnchor,trailing: self.trailingAnchor, topConstant: 0, bottomConstant: 0, trailingConstant: ADConstant.placeCellImageConstant, widthConstant: ADConstant.placeCellImageWidth)
        
        nameLB.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: imageView.leadingAnchor, topConstant: ADConstant.placeCellNameLBTop, leadingConstant: ADConstant.placeCellNameLBTop, trailingConstant: ADConstant.placeCellNameLBRight, heightConstant: ADConstant.placeCellNameLBHeight, heightGreater: true)
        addressLB.anchor(top: nameLB.bottomAnchor, leading: self.leadingAnchor, trailing: imageView.leadingAnchor, topConstant: ADConstant.placeCellNameLBRight, leadingConstant: ADConstant.placeCellNameLBTop, trailingConstant: ADConstant.placeCellNameLBRight, heightConstant: ADConstant.placeCellNameLBHeight, heightGreater: true)
        distanceLB.anchor(top: addressLB.bottomAnchor, leading: self.leadingAnchor, trailing: imageView.leadingAnchor, topConstant: ADConstant.placeCellNameLBRight, leadingConstant: ADConstant.placeCellNameLBTop, trailingConstant: ADConstant.placeCellNameLBRight, heightConstant: ADConstant.placeCellDistanceLBHeight)
        timezoneLB.anchor(top: distanceLB.bottomAnchor, leading: self.leadingAnchor, trailing: imageView.leadingAnchor, topConstant: 0, leadingConstant: ADConstant.placeCellNameLBTop, trailingConstant: ADConstant.placeCellNameLBRight, heightConstant: ADConstant.placeCellDistanceLBHeight)
        neighborhoodLB.anchor(top: timezoneLB.bottomAnchor, leading: self.leadingAnchor, trailing: imageView.leadingAnchor, topConstant: ADConstant.placeCellNameLBRight, leadingConstant: ADConstant.placeCellNameLBTop, trailingConstant: ADConstant.placeCellNameLBRight, heightConstant: ADConstant.placeCellNameLBHeight, heightGreater: true)
    }
    
    @objc private func didExploreButtonTap(button:UIButton) {
        delegate?.didTapOnExploreButton()
    }
    
    func categoryInitialSetup() {
        self.addSubview(imageView)
        self.addSubview(nameLB)
    }
    
    func categoryLayoutSetup() {
        nameLB.font = ADFont.systemBold_15
        nameLB.textAlignment = .center
        imageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, topConstant: ADConstant.categoryCellConstant, leadingConstant:  ADConstant.categoryCellConstant, trailingConstant: ADConstant.categoryCellConstant, heightConstant: ADConstant.categoryCellImageHeight)
        nameLB.anchor(top: imageView.bottomAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, topConstant: ADConstant.categoryCellConstant, bottomConstant: 0, leadingConstant: 0, trailingConstant: 0)
    }
    
    func setImage(viewType:ADCellViewType) {
        if viewType == .place {
            imageView.image = UIImage.init(named: ADString.foodDefaultImage)
        }else {
            imageView.image = UIImage.init(named: ADString.categoryImage)
        }
    }
}
