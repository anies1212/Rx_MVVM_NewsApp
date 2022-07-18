//
//  Article.swift
//  Rx_MVVM_NewsApp
//
//  Created by anies1212 on 2022/07/18.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}
