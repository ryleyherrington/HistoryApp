//
//  NetworkHelper.swift
//  HistoryDaze
//
//  Created by Ryley Herrington on 9/7/16.
//  Copyright © 2016 Herrington. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class NetworkHelper: NSObject {
    static let sharedInstance = NetworkHelper()
    
    func getSummaryOfArticle(articleName: NSString, completion: (result: Article?) -> Void) {
        let urlPath = "https://en.wikipedia.org/w/api.php?"
        
        Alamofire.request(.GET, urlPath, parameters: ["format" : "json",
            "action" : "query",
            "prop" : "extracts|categories|links|pageimages",
            "exintro" : "",
            "list" : "backlinks",
            "explaintext" : "",
            "bltitle" : articleName,
            "titles" : articleName,
            "bllimit" : 500,
            "pithumbsize" : 1000,
            "redirects" : ""])
            .responseJSON { response in
                
                
                guard let JSON = response.result.value else {
                    completion(result: nil)
                    return
                }
                
                do {
                    let article = try Article(withJSON: JSON as! NSDictionary)
                    
                    if (article.NeedToDisambiguate() == true) {
                        let disambiguatedArticleTitle = article.getDisambiguatedTitle()
                        print("\(disambiguatedArticleTitle)")
                        
                        self.getSummaryOfArticle(disambiguatedArticleTitle, completion: { (result) -> Void in
                            
                            completion(result: result)
                            
                        })
                    }
                    else
                    {
                        completion(result: article)
                    }
                }
                catch _ as NSError {
                    // Something has gone wrong
                    
                    completion(result: nil)
                }
        }
    }
    
    
}
