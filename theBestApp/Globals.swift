//
//  Globals.swift
//  theBestApp
//
//  Created by Ashot on 1/21/19.
//  Copyright © 2019 Ashot. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire
import RSLoadingView

struct newsModel: Codable {
    let id: Int?
    let date, title: String?
    let url: String?
    let imgURL: String?
    let provider, hostname: String?
    let storyID: Int?
    let newsTags: [NewsTag]?
    
    enum CodingKeys: String, CodingKey {
        case id, date, title, url, provider, hostname
        case imgURL = "img_url"
        case storyID = "story_id"
        case newsTags = "news_tags"
    }
}

struct NewsTag: Codable {
    let id: Int?
    let name: String?
    let newsID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case newsID = "news_id"
    }
}

var serverUrl = "https://api.cryptoeye.pro/news?limit="
var serverOffsetUrl = "&offset="
var serverEndUrl = "&fbclid=IwAR3U0nj0ne7kk5NE6ZEbhu0dRrVYjqp1iuPM6cqOoth-iIF8oY-4_ZYc9QU"
var limit = 12
var offset = 0

func getNewsUrl() -> String {
    return serverUrl + String(limit) + serverOffsetUrl + String(offset) + serverEndUrl
}
var newsArray: [newsModel]? = []
func get(offset: Int, limit: Int, completion: @escaping (Bool)->()) {
    
    Alamofire.request(serverUrl + String(limit) + serverOffsetUrl + String(offset) + serverEndUrl, method: .get, parameters: nil).validate().responseDecodableObject(keyPath: nil, decoder: JSONDecoder()) { (response: DataResponse<[newsModel]>) in
        switch response.result{
        case .success(let data):
            newsArray?.append(contentsOf: data)
          //  newsArray = data
            completion(true)
            break
        case .failure(_):
            completion(false)
            break
        }
    }
}
