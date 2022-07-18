//
//  ViewController.swift
//  Rx_MVVM_NewsApp
//
//  Created by anies1212 on 2022/07/18.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    static let apiKey = "75570e641e864d829cf53ce39456f4c4"
    static let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey="
    let bag = DisposeBag()
    private var articleListViewModel: ArticleListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadData(){
        let url = NewsTableViewController.url + NewsTableViewController.apiKey
        let resource = Resource<ArticleResponse>(url: URL(string: url)!)
        URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] articleResponse in
                let articles = articleResponse.articles
                self?.articleListViewModel = ArticleListViewModel(articles)
                self?.tableView.reloadData()
            })
            .disposed(by: bag)
    }
}
extension NewsTableViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListViewModel == nil ? 0 : self.articleListViewModel.articlesVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        let article = articleListViewModel.articleAt(indexPath.row)
        article.title.asDriver(onErrorJustReturn: "nil")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: bag)
        article.description.asDriver(onErrorJustReturn: "nil")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: bag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
