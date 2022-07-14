//
//  ViewController.swift
//  newsapp
//
//

import UIKit
import Alamofire
import SDWebImage
import SafariServices

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var newsTV: UITableView!
    
    //MARK: - Local Variable
    
    var articles = [Article]()
    lazy var refreshControl = UIRefreshControl()
    lazy var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    //MARK: - Class functions
   
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(isRefreshEnabled: true)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        newsTV.refreshControl = refreshControl
        newsTV.delegate = self
        newsTV.dataSource = self
        newsTV.register(UINib(nibName: "NewsTVC", bundle: nil), forCellReuseIdentifier: "NewsTVC")
    }
    
    //MARK: - Fetch data from web
    
    func getData(isRefreshEnabled : Bool) {
        if isRefreshEnabled {
            activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5)
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
        }
        let request = AF.request("https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=d8fa64f1d8184ea78504cdcd45ab64d6")
        request.responseDecodable(of: News.self) { (response) in
            guard let data = response.value else { return }
            self.articles = data.articles
            self.refreshControl.endRefreshing()
            if isRefreshEnabled {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
            }
            self.newsTV.reloadData()
        }
    }
    
    //MARK: - Refresh Control Functions
    @objc func refresh(_ sender: AnyObject) {
    refreshControl.beginRefreshing()
        getData(isRefreshEnabled: false)
    }
    
    //MARK: - Tableview delegates and datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "NewsTVC", for: indexPath) as! NewsTVC
        cell.newsImage.sd_setImage(with: URL(string: articles[indexPath.row].urlToImage))
        cell.newsTitle.text = articles[indexPath.row].title
        cell.newsAuthor.text = "By "+articles[indexPath.row].author
        cell.newsDescription.text = articles[indexPath.row].articleDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = articles[indexPath.row].url
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}



