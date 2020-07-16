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


func getPreviousStrDate(with number: Int) -> String {
    
    guard let previousDate = Calendar.current.date(byAdding: .day, value: -number, to: Date()) else { return "" }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.string(from: previousDate)
    return date
}


func loadNews(with number: Int, completionHandler: (() -> Void)?) {
    
    let date = getPreviousStrDate(with: number)
    guard let url = URL(string: "http://newsapi.org/v2/everything?q=football&from=\(date)&to=\(date)&sortBy=popularity&apiKey=1e1b7bbe50cb49258a50ff635e64929a") else { return }
    
    let session = URLSession(configuration: .default)
    
    let downloadTask = session.dataTask(with: url) { (data, response, error) in
        if let result = data {
            let flag = number == 0 ? true : false
            openNews(with: result, with: flag)
            completionHandler?()
        }
    }
    downloadTask.resume()
}

// parsing json file
func openNews(with data: Data, with flag: Bool) {
    // get binary data
    
    let fundamentalDictionaryOfAny = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
    if fundamentalDictionaryOfAny == nil {
        return
    }
    
    let fundamentalDictionary = fundamentalDictionaryOfAny as? Dictionary<String, Any>
    if fundamentalDictionary == nil {
        return
    }
    
    if let arrayOfArticles = fundamentalDictionary!["articles"] as? [Dictionary<String, Any>] {
        
        if flag {
            articles.removeAll()
        }
        
        for dictionary in arrayOfArticles {
            let newArticle = Article(dictionary: dictionary)
            articles.append(newArticle)
        }
    }
}
