//
//  Article.swift
//  HistoryDaze
//
//  Created by Ryley Herrington on 9/7/16.
//  Copyright © 2016 Herrington. All rights reserved.
//

import Foundation

enum ArticleErrors : ErrorType {
    case BadJsonFormat
}

@objc public class Article : NSObject {
    
    internal var title = ""
    internal var summary = ""
    internal var links : [String] = [String]()
    internal var backLinks : [String] = [String]()
    internal var categories : [String] = [String]()
    internal var needToDisambiguate = false
    internal var articleID = ""
    internal var imgUrl = ""
    
    override init() {
        super.init()
    }
    
    public required init(withJSON JSON: NSDictionary) throws {
        super.init()
        
        guard let query = JSON["query"] as? NSDictionary else {
            throw ArticleErrors.BadJsonFormat
        }
        
        guard let pages = query["pages"] as? NSDictionary else {
            throw ArticleErrors.BadJsonFormat
        }
        
        guard let backLinks = query["backlinks"] as? [NSDictionary] else {
            throw ArticleErrors.BadJsonFormat
        }
        
        for key in pages.allKeys {
            
            guard let articleID = pages["\(key)"] as? NSDictionary else {
                throw ArticleErrors.BadJsonFormat
            }
            
            guard let summary = articleID["extract"] as? String else {
                throw ArticleErrors.BadJsonFormat
            }
            
            guard let title = articleID["title"] as? String else {
                throw ArticleErrors.BadJsonFormat
            }
            
            guard let categories = articleID["categories"] as? [NSDictionary] else {
                throw ArticleErrors.BadJsonFormat
            }
            
            guard let links = articleID["links"] as? [NSDictionary] else {
                throw ArticleErrors.BadJsonFormat
            }
            
            if let thumbnail = articleID["thumbnail"] as? NSDictionary {
                
                guard let imgUrl = thumbnail["source"] as? String else {
                    throw ArticleErrors.BadJsonFormat
                }
                
                self.imgUrl = imgUrl
                
            }
            
            for category in categories {
                
                guard let categoryString = category["title"] as? String else {
                    throw ArticleErrors.BadJsonFormat
                }
                
                if categoryString.containsString("disambiguation") || categoryString.containsString("Disambiguation") {
                    
                    // We've hit a special disambiguation page, choose the first link on the page
                    // and make a recursive call. There is a very slim chance of a stack overflow.
                    
                    self.needToDisambiguate = true
                }
            }
            
            
            // Begin filling out member fields
            self.articleID = key as! String as String
            self.summary = summary.stringByReplacingOccurrencesOfString("\n", withString: "\n\n")
            self.title = title
            
            for dict in categories {
                
                guard let title = dict["title"] as? String else {
                    throw ArticleErrors.BadJsonFormat
                }
                
                self.categories.append(title)
            }
            
            for dict in links {
                
                guard let title = dict["title"] as? String else {
                    throw ArticleErrors.BadJsonFormat
                }
                
                // Filter out any special pages since they all have ":",
                // legit pages with ":" are considered acceptable losses
                if (!title.containsString(":")) {
                    self.links.append(title)
                }
                
            }
            
            for dict in backLinks {
                guard let title = dict["title"] as? String else {
                    throw ArticleErrors.BadJsonFormat
                }
                
                // Filter out any special pages since they all have ":",
                // legit pages with ":" are considered acceptable losses
                if (!title.containsString(":")) {
                    self.backLinks.append(title)
                }
            }
            
            // only process the first key in page
            break
        }
    }
    
    public func GetImageUrl() -> NSString {
        return self.imgUrl
    }
    
    public func GetSummary() -> NSString {
        return self.summary
    }
    
    public func NeedToDisambiguate() -> Bool {
        return needToDisambiguate
    }
    
    public func GetNextSearchTerm() -> String {
        let randomNum = Int(arc4random()) % backLinks.count
        return backLinks[randomNum]
    }
    
    public func getDisambiguatedTitle() -> String {
        
        if (links.count > 0) {
            
            guard let returnValue = links.first else {
                return ""
            }
            
            return returnValue
            
        }
        
        return ""
        
    }
    
}
