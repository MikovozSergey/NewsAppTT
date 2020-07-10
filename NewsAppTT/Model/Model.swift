//
//  Model.swift
//  NewsAppTT
//
//  Created by Дарья Станкевич on 7/10/20.
//  Copyright © 2020 Sergey Mikovoz. All rights reserved.
//

import Foundation

var articles: [Article] = [] // array of news

var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json"
    // convert to url our path
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}

// MARK: Functions

func loadNews(completionHandler: (() -> Void)?) {
    let url = URL(string: "http://newsapi.org/v2/everything?q=bitcoin&from=2020-06-10&sortBy=publishedAt&apiKey=542fc32d19d34ae68f9b3aa671fda5ac")
    
    let session = URLSession(configuration: .default)
    
    let downloadTask = session.downloadTask(with: url!) { (urlFile, response, error) in
        // check in error
        if urlFile != nil {
            // copy to local FileManager
            try? FileManager.default.copyItem(at: urlFile!, to: urlToData)
            
            openNews()
            
            completionHandler?()
        }
    }
    
    downloadTask.resume()
}

// parsing json file
func openNews() {
    // get binary data
    let data = try? Data(contentsOf: urlToData)
    if data == nil {
        return
    }
    
    let fundamentalDictionaryOfAny = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
    if fundamentalDictionaryOfAny == nil {
        return
    }
    
    let fundamentalDictionary = fundamentalDictionaryOfAny as? Dictionary<String, Any>
    if fundamentalDictionary == nil {
        return
    }
    
    if let arrayOfArticles = fundamentalDictionary!["articles"] as? [Dictionary<String, Any>] {
        
        // get values
        var returnArrayOfArticles : [Article] = []
        
        for dictionary in arrayOfArticles {
            let newArticle = Article(dictionary: dictionary)
            returnArrayOfArticles.append(newArticle)
        }
        
        articles = returnArrayOfArticles
    }
}
