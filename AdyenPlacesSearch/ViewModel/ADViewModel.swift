//
//  PlacesViewModel.swift
//  AdyenPlacesSearch
//
//  Created by REINA on 06/07/22.
//

import Foundation

struct Response:Codable {
    let results:[Place]?
    let context:Context?
    
    struct Place: Codable {
        let fsq_id:String?
        let categories:[Category]?
        let distance:Int?
        let link:String?
        let location:Location?
        let name:String?
        let timezone:String?
        var totalRadius:Int?
        
        struct Category: Codable{
            let id:Int?
            let name:String?
            let icon:Icon?
            
            struct Icon:Codable {
                let prefix:String?
                let suffix:String?
            }
        }
        
        struct Location: Codable{
            let address:String?
            let country:String?
            let formatted_address:String?
            let locality:String?
            let neighborhood:[String]?
            let postcode:String?
            let region:String?
        }
    }
}

struct Context:Codable {
    let geo_bounds:GeoBounds?
    struct GeoBounds: Codable {
        let circle:Circle?
        struct Circle: Codable {
            let radius:Int?
        }
    }
}

class ADViewModel {
    struct APIMetaData {
        static let placeSearchURL = URL.init(string: "https://api.foursquare.com/v3/places/search")
        static let headers = ["Accept": "application/json", "Authorization": "fsq3Wn0nl6n8HKdu1QP+7WdKKJ/S9WLHoJv12K3gWSzxdHs="]
    }
    
    var updatePlaces:(([Response.Place]?, Error?) -> ())?
    var updateImage:((URL, Data?, Error?) -> ())?
    
    static private var sharedManager:ADViewModel? = ADViewModel()
    static func shared() -> ADViewModel{
        if sharedManager == nil {
            sharedManager = ADViewModel()
        }
        return sharedManager!
    }
    
    func fetchPlaces() {
        URLSession.shared.request(url: APIMetaData.placeSearchURL, expecting: Response.self, headers: APIMetaData.headers) {[weak self] result in
            switch result {
            case .success(let response):
                if let updatePlaces = self?.updatePlaces, var places = response.results, let radius = response.context?.geo_bounds?.circle?.radius {
                    places[0].totalRadius = radius
                    updatePlaces(places, nil)
                }
            case .failure(let error):
                if let updatePlaces = self?.updatePlaces{
                    updatePlaces(nil, error)
                }
                break
            }
        }
    }
}
