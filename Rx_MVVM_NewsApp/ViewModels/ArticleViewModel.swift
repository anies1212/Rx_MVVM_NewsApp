//
//  ArticleViewModel.swift
//  Rx_MVVM_NewsApp
//
//  Created by anies1212 on 2022/07/18.
//

import Foundation
import RxCocoa
import RxSwift

struct ArticleListViewModel {
    let articlesVM: [ArticleViewModel]
}

extension ArticleListViewModel {
    init(_ articles: [Article]){
        self.articlesVM = articles.compactMap(ArticleViewModel.init)
    }
}

extension ArticleListViewModel {
    
    func articleAt(_ index: Int) -> ArticleViewModel {
        return self.articlesVM[index]
    }
    
}

struct ArticleViewModel {
    let article: Article
    
    init(_ article: Article){
        self.article = article
    }
}

extension ArticleViewModel {
    
    var title: Observable<String> {
        return Observable<String>.just(article.title)
    }
    var description: Observable<String> {
        return Observable<String>.just(article.description ?? "nil")
    }
    
    
    
}
