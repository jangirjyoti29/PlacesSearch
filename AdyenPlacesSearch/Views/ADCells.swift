//
//  ADPlaceCell.swift
//  AdyenPlacesSearch
//
//  Created by REINA on 06/07/22.
//

import UIKit

enum ADCellViewType {
    case place
    case category
}

class ADPlaceCell: UITableViewCell, ADCellContentViewDelegate {
    
    var indexPath:IndexPath?
    
    lazy var containerView: ADCellContentView = {
        let view = ADCellContentView.init(viewType: ADCellViewType.place)
        view.backgroundColor = ADColor.cellBackgroundColor
        return view
    }()
    
    var updateCellFooterView:((IndexPath) -> ())?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.contentView.backgroundColor = ADColor.clear
        self.backgroundColor = ADColor.clear
        self.selectionStyle = .none
        
        self.contentView.addSubview(containerView)
        containerView.delegate = self
        containerView.anchor(top: self.contentView.topAnchor, bottom: self.contentView.bottomAnchor, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, topConstant: ADConstant.placeCellContentViewTop, bottomConstant: ADConstant.placeCellContentViewTop, leadingConstant: ADConstant.placeCellContentViewLeft, trailingConstant: ADConstant.placeCellContentViewLeft)
        containerView.shadow()
    }
    
    func setPlaceData(place:Response.Place?) {
        guard let place = place else { return  }
        if let categoryCount = place.categories, categoryCount.count > 0 {
            containerView.exploreButton.isHidden = false
        }
        containerView.setImage(viewType: .place)
        containerView.nameLB.text = place.name
        containerView.addressLB.text = place.location?.formatted_address
        containerView.timezoneLB.text = place.timezone
        if let distance = place.distance {
            let distableValue = String(format:"%.02f", Double(distance)/Double(1000))
            containerView.distanceLB.text = "\(distableValue)\(ADString.kmAway)"
        }
        if let near = place.location?.neighborhood?.joined(separator: ","){
            containerView.neighborhoodLB.text = "\(ADString.near)\(near)"
        }
    }
    
    func didTapOnExploreButton() {
        if let updateCellFooterView = updateCellFooterView {
            updateCellFooterView(indexPath!)
        }
    }
}

class ADPlaceFooterView: UITableViewHeaderFooterView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var arrowView: UIView = {
        let view = UIView()
        view.backgroundColor = ADColor.categoryBackgroundColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var dataSource:[Response.Place.Category] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionview = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionview.bounces = true
        collectionview.alwaysBounceHorizontal = true
        collectionview.backgroundColor = ADColor.categoryBackgroundColor
        return collectionview
    }()

    init(categoryDataSource:[Response.Place.Category]) {
        super.init(reuseIdentifier: "")
        dataSource = categoryDataSource
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        self.addSubview(collectionView)
        self.addSubview(arrowView)
        
        collectionView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, topConstant: 0, bottomConstant: 0, leadingConstant: 0, trailingConstant: 0)
        
        arrowView.anchor(bottom: collectionView.topAnchor, trailing: collectionView.trailingAnchor, bottomConstant: ADConstant.arrowBottom, trailingConstant: ADConstant.arrowConstant, heightConstant: ADConstant.arrowConstant, widthConstant: ADConstant.arrowConstant)

        self.bringSubviewToFront(collectionView)
        collectionView.register(ADCategoryCell.self, forCellWithReuseIdentifier: ADString.categoryCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ADString.categoryCellId, for: indexPath) as! ADCategoryCell
        cell.setCategoryData(category: dataSource[indexPath.row], indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ADConstant.tableViewCellHeight, height: ADConstant.collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}


class ADCategoryCell: UICollectionViewCell, ADCellContentViewDelegate {
    
    lazy var containerView: ADCellContentView = {
        let view = ADCellContentView.init(viewType: ADCellViewType.category)
        view.backgroundColor = ADColor.cellBackgroundColor
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ADColor.clear
        self.contentView.addSubview(containerView)
        containerView.delegate = self
        
        containerView.anchor(top: self.contentView.topAnchor, bottom: self.contentView.bottomAnchor, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, topConstant: ADConstant.placeCellContentViewTop, bottomConstant: ADConstant.placeCellContentViewTop, leadingConstant: ADConstant.placeCellContentViewLeft, trailingConstant: ADConstant.placeCellContentViewLeft)
        containerView.shadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCategoryData(category:Response.Place.Category?, indexPath:IndexPath) {
        guard let category = category else { return  }
        containerView.setImage(viewType: .category)
        containerView.nameLB.text = category.name
    }
}

