//
//  HomeViewController.swift
//  LoodosApp
//
//  Created by Semih Gençer on 20.11.2019.
//  Copyright © 2019 Semih Gençer. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let sectionTitles = ["Batman Movies","Harry Potter Movies","Star Wars Movies"]
    var filmList: [[Film]] = [[],[],[]]
    let cellId = "cellId"
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar()
    }
    
    
    func setNavBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Home"
    }
    
    let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.separatorColor = .clear
        tableview.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        return tableview
    }()
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor = UIColor.white
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FilmListTableViewCell
        cell.list = filmList[indexPath.section]
        cell.collectionReloadData()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.addSubview(tableview)
        tableview.register(FilmListTableViewCell.self, forCellReuseIdentifier: cellId)
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        // Do any additional setup after loading the view.
        
        setBatmanFilms()
        setHarryPotterFilms()
        setStarWarsFilms()
    }
    
    var sv: UIView? = nil
    func setBatmanFilms() {
        sv = UIViewController.displaySpinner(onView: self.view)
        let requestURL: NSURL = NSURL(string: "http://omdbapi.com/?apikey=6b3ed3c&s=batman&type=movie")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
            } else  {
                print("Failed")
            }
            
            do{
                if let json =  (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:Any]
                    , let filmsArray = json["Search"] as? [Any]
                {
                    for i in 0...filmsArray.count-1 {
                        let film = filmsArray[i] as! [String:Any]
                        let title = film["Title"] as! String
                        let year = film["Year"] as! String
                        let imdb = film["imdbID"] as! String
                        let type = film["Type"] as! String
                        let poster = film["Poster"] as! String
                        let f = Film(title: title, year: year, imdbID: imdb, type: type, poster: poster)
                        self.filmList[0].append(f)
                    }
                }
            }
        }
        task.resume()
    }
    
    func setHarryPotterFilms() {
        let requestURL: NSURL = NSURL(string: "http://omdbapi.com/?apikey=6b3ed3c&s=harry+potter")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
                if (statusCode == 200) {                    print("Everyone is fine, file downloaded successfully.")
                } else  {
                print("Failed")
            }
        
            do{
                if let json =  (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:Any]
                    , let filmsArray = json["Search"] as? [Any]
                {
                    for i in 0...filmsArray.count-1 {
                        let film = filmsArray[i] as! [String:Any]
                        let title = film["Title"] as! String
                        let year = film["Year"] as! String
                        let imdb = film["imdbID"] as! String
                        let type = film["Type"] as! String
                        let poster = film["Poster"] as! String
                        let f = Film(title: title, year: year, imdbID: imdb, type: type, poster: poster)
                        self.filmList[1].append(f)
                        }
                    }
                }
            }
        task.resume()
    }
    
    func setStarWarsFilms() {
        let requestURL: NSURL = NSURL(string: "http://omdbapi.com/?apikey=6b3ed3c&s=star+wars")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
            } else  {
                print("Failed")
            }
            do{
                if let json =  (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:Any]
                    , let filmsArray = json["Search"] as? [Any]
                {
                    for i in 0...filmsArray.count-1 {
                        let film = filmsArray[i] as! [String:Any]
                        let title = film["Title"] as! String
                        let year = film["Year"] as! String
                        let imdb = film["imdbID"] as! String
                        let type = film["Type"] as! String
                        let poster = film["Poster"] as! String
                        let f = Film(title: title, year: year, imdbID: imdb, type: type, poster: poster)
                        self.filmList[2].append(f)
                    }
                }
            }
        }
        task.resume()
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            self.tableview.reloadData()
            UIViewController.removeSpinner(spinner: self.sv!)
        }
    }
}



