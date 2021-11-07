//
//  ViewController.swift
//  News
//
//  Created by Nguyễn Trà on 8/26/21.
//

import UIKit
import SDWebImage
import SafariServices


class ViewController : UIViewController,UITableViewDelegate,UITableViewDataSource {
    var news: Response?
    @IBOutlet weak var tableVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.delegate = self
        tableVIew.dataSource = self
        let TableViewCell_xib = UINib(nibName: "TableViewCell", bundle: nil)
        tableVIew.register(TableViewCell_xib, forCellReuseIdentifier: "myIdt")
        
        
        // Do any additional setup after loading the view.
        fetchData {data in
            self.news = data
            dump(self.news)
            DispatchQueue.main.async {
                self.tableVIew.reloadData()
            }
            
        }
    }
    
    
    
    //tblView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myIdt") as! TableViewCell
        cell.Title.text = news?.articles[indexPath.row].title
        cell.Description.text = news?.articles[indexPath.row].description
        cell.newsImg.sd_setImage(with: URL(string: news?.articles[indexPath.row].urlToImage ?? ""), completed: nil)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "view2")as! ViewController2
//        vc.passData = news?.articles[indexPath.row]
//        self.present(vc, animated: true, completion: nil)
        showTutorial(news?.articles[indexPath.row].url ?? "")
        
        
        

    }
    func showTutorial(_ url: String) {
        if let url = URL(string: url ) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    
    //API
    func fetchData (completion : @escaping (Response) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=85ab0f8f8d0149608a9a4ed1ccfbd5a3")
        else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let data = try! JSONDecoder().decode(Response.self, from: data!)
            completion(data)
        }.resume()
        
    }
    
    
}
struct Response: Codable {
    var articles : [Article]
}
struct Article: Codable {
    var author : String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var content : String
    
}



