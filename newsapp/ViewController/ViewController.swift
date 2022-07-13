//
//  ViewController.swift
//  newsapp
//
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var newsTV: UITableView!
    
    //MARK: - Local Variable
    
    var articles = [Article]()
    
    //MARK: - Class functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newsTV.register(UINib(nibName: "NewsTVC", bundle: nil), forCellReuseIdentifier: "NewsTVC")
    }
    
    //MARK: - Fetch data from web
    
    func getData() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        
        let request = AF.request("https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=d8fa64f1d8184ea78504cdcd45ab64d6")
        request.responseDecodable(of: News.self) { (response) in
            guard let data = response.value else { return }
            self.articles = data.articles
            activityIndicator.stopAnimating() // On response stop animating
            activityIndicator.removeFromSuperview()
            self.newsTV.reloadData()
        }
    }
    
    //MARK: - Tableview delegates and datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "NewsTVC", for: indexPath) as! NewsTVC
//        cell.newsImage.image
        cell.newsTitle.text = articles[indexPath.row].title
        cell.newsAuthor.text = articles[indexPath.row].author
        cell.newsDescription.text = articles[indexPath.row].articleDescription
        return cell
    }
    
}



