//
//  ADColors.swift
//  AdyenPlacesSearch
//
//  Created by REINA on 07/07/22.
//

import UIKit

let iPhone = (UIDevice.current.userInterfaceIdiom == .phone)

struct ADColor {
    static let backgroundColor = UIColor.init(hexaRGB: "#ADD8E6")!
    static let cellBackgroundColor = UIColor.init(hexaRGB: "#5F9EA0")!
    static let categoryBackgroundColor = UIColor.init(hexaRGB: "#8FBBBD")!
    static let selectionColor = UIColor.init(hexaRGB: "#729597")!
    static let buttonColor = UIColor.init(hexaRGB: "#088F8F")!
    static let black = UIColor.black
    static let blue = UIColor.blue
    static let clear = UIColor.clear
    static let white = UIColor.white
    static let red = UIColor.red
}

struct ADString {
    static let dataLoading = "Data is loading, Please Wait..."
    static let error = "Error"
    static let noData = "No Data Available for Applied filters."
    static let exploreCategories = "Explore Categories"
    static let foodDefaultImage = "FoodDefaultImage"
    static let categoryImage = "CategoryImage"
    static let kmAway = "Km Away"
    static let near = "Near: "
    static let allPlaces = "All Places "
    static let close = "Close"
    static let apply = "Apply"
    static let reset = "Reset"
    static let range = "Range:"
    static let sortBy = "Sort By:"
    static let categories = "Categories:"
    static let filters = "Filters"
    
    static let placeCellId = "placeCellId"
    static let categoryCellId = "categoryCellId"
}

struct ADFont {
    static let systemLight_13 = UIFont.systemFont(ofSize: iPhone ? 13 : 17, weight: .light)
    
    static let systemBold_15 = UIFont.boldSystemFont(ofSize: iPhone ? 15 : 20)
    static let systemLight_15 = UIFont.systemFont(ofSize: iPhone ? 15 : 20, weight: .light)
    static let systemRegular_15 = UIFont.systemFont(ofSize: iPhone ? 15 : 20, weight: .regular)
    
    static let systemBold_20 = UIFont.boldSystemFont(ofSize: iPhone ? 20 : 25)
    static let systemRegular_20 = UIFont.systemFont(ofSize: iPhone ? 20 : 25)
    
    static let systemBold_30 = UIFont.boldSystemFont(ofSize: iPhone ? 30 : 35)
}

struct ADConstant {
    /**Table View Constants*/
    static let tableViewCellHeight:CGFloat = iPhone ? 200 : 300
    static let tableViewTop:CGFloat = iPhone ? 5 : 10
    static let topBarHeight:CGFloat = iPhone ? 50 : 70
    static let topBarConstant:CGFloat = iPhone ? 10 : 20
    
    /**Places Cell Constants*/
    static let placeCellImageWidth:CGFloat = iPhone ? 150 : 200
    static let placeCellImageConstant:CGFloat = iPhone ? 20 : 30
    static let placeCellImageBottom:CGFloat = iPhone ? 40 : 50
    static let placeCellNameLBTop:CGFloat = iPhone ? 10 : 20
    static let placeCellNameLBRight:CGFloat = iPhone ? 5 : 10
    static let placeCellNameLBHeight:CGFloat = iPhone ? 25 : 20
    static let placeCellDistanceLBHeight:CGFloat = iPhone ? 20 : 25
    static let placeCellContentViewLeft:CGFloat = iPhone ? 10 : 15
    static let placeCellContentViewTop:CGFloat = iPhone ? 5 : 10
    
    /**Category Cell Constants*/
    static let collectionViewCellHeight:CGFloat = iPhone ? 150 : 250
    static let categoryCellImageHeight:CGFloat = iPhone ? 100 : 150
    static let categoryCellConstant:CGFloat = iPhone ? 10 : 15
    
    /**Arrow Cell Constants*/
    static let arrowBottom:CGFloat = -10
    static let arrowConstant:CGFloat = 20
    
    static let filterButtonWidth:CGFloat = iPhone ? 100 : 150
    static let allPlacesLabelConstant:CGFloat = iPhone ? 10 : 20
    
    /**Filters View Constants*/
    static let scrollViewWidth:CGFloat = iPhone ? 380 : 600
    static let scrollViewHeight:CGFloat = iPhone ? 500 : 600
    static let filterLabelHeight:CGFloat = iPhone ? 30 : 40
    static let filterLabelWidth:CGFloat = iPhone ? 100 : 200
    static let closeButtonWidth:CGFloat = iPhone ? 50 : 80
    static let closeButtonTop:CGFloat = iPhone ? 10 : 15
    static let closeButtonLeft:CGFloat = iPhone ? 5 : 10
    static let scrollViewConstant:CGFloat = iPhone ? 10 : 15
    static let rangeSliderHeight:CGFloat = iPhone ? 30 : 40
    static let rangeValueHeight:CGFloat = iPhone ? 15 : 20
    static let segmentHeight:CGFloat = iPhone ? 50 : 60
    static let resetButtonWidth:CGFloat = iPhone ? 180 : 280
    static let stackViewSpacing:CGFloat = iPhone ? 10 : 15
}
