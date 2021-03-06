//
//  BeerDetailViewController.swift
//  bierjohann
//
//  Created by Kohler Manuel on 23.10.17.
//  Copyright © 2017 Manuel Kohler. All rights reserved.
//

import UIKit
import os.log

class BeerViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var beerNewLabel: UILabel!
    @IBOutlet weak var beerBrandLabel: UILabel!
    @IBOutlet weak var beerNumberLabel: UILabel!
    @IBOutlet weak var beerFlagLabel: UILabel!
    @IBOutlet weak var beerTypelabel: UILabel!
//      @IBOutlet weak var beerRatingValue: UITextField!
    @IBOutlet weak var beerRatingCount: UILabel!
    @IBOutlet weak var beerAbv: UILabel!
    @IBOutlet weak var beerOverallScore: UILabel!
    @IBOutlet weak var beerStyleName: UILabel!
    @IBOutlet weak var beerBrewerCity: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var webAddressTextView: UITextView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var overallScoreLabel: UILabel!
    @IBOutlet weak var StyleLabel: UILabel!
    @IBOutlet weak var ratingcountLabel: UILabel!
    @IBOutlet weak var brewerCity: UILabel!
    @IBOutlet weak var beerDescr: UILabel!
    
    @IBOutlet weak var beerImageView: UIImageView!
    
    var beer: Beer?
    let apollo = createApolloClient()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        scrollView.contentSize = CGSize(width: self.view.frame.size.width-100, height: 1000)
        
        if let beer = beer {
            navigationItem.title = ""
            navigationItem.hidesBackButton = false

            beerNewLabel.isHidden = beer.new
            beerBrandLabel.text = beer.brand
            beerNumberLabel.text = String(beer.runningNumber)
            beerFlagLabel.text = countryCodeToEmoji(country: beer.countryCode)
            beerTypelabel.text = beer.type
//            beerRatingValue.text = String(roundOneDecimals(d: beer.ratingValue))
            beerRatingCount.text = String(beer.ratingCount)
            beerAbv.text = String(roundOneDecimals(d: beer.abv)) + " %"
            beerOverallScore.text = String(roundOneDecimals(d: beer.overallScore)) + "/100"
            beerStyleName.text = beer.style.name
            beerBrewerCity.text = beer.brewer.city
            beerDescription.text = beer.desc
            webAddressTextView.text = beer.brewer.web
            beerImageView.image = beer.imageData
            print(beer.imageUrl)
            
//            typeLabel.text = NSLocalizedString("BeerName", comment: "Beer Name")
//            brandLabel.text  = NSLocalizedString("BrewerName", comment: "Brewery")
            abvLabel.text = NSLocalizedString("ABV", comment: "ABV")
            overallScoreLabel.text = NSLocalizedString("UserRating", comment: "UserRating")
            StyleLabel.text = NSLocalizedString("BeerStyle", comment: "BeerStyle")
            ratingcountLabel.text = NSLocalizedString("NumberOfRatings", comment: "NumberOfRatings")
            brewerCity.text = NSLocalizedString("Brewerscity", comment: "Brewerscity")
            beerDescr.text = NSLocalizedString("BeerDescription", comment: "BeerDescription")
            
        }
        
        searchButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
    }
    
    @objc private func buttonClicked() {
        let encodedBrand = prepareStringForURLSearch(s: (beer?.brand)!)
        let encodedType = prepareStringForURLSearch(s: (beer?.type)!)

        guard let url = URL(string: Constants.GOOGLE_SEARCH_STRING + "\(encodedBrand  )+\(encodedType)")
            else {
                return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        func run() {
            print("Running viewWillAppear")
            
            let searchString = [beer?.brand, beer?.type].flatMap({$0}).joined(separator: " ")
            
            _ = queryGraphql(apolloClient: apollo, searchString: searchString, beer: beer!)
            
            
//            beerBrewerCity.text = beer?.brewer.city
//            beerDescription.text = beer?.desc
            
        }
        run()
    }    
}

