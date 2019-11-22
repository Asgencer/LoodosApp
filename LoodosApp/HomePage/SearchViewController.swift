//
//  SearchViewController.swift
//  LoodosApp
//
//  Created by Semih Gençer on 19.11.2019.
//  Copyright © 2019 Semih Gençer. All rights reserved.
//

import UIKit
import IQKeyboardManager

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
    var filmList: [Film] = []
    let cellId = "cellId"
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar()
        
        let selectedRow: IndexPath? = tableview.indexPathForSelectedRow
        if let selectedRowNotNill = selectedRow {
            tableview.deselectRow(at: selectedRowNotNill, animated: true)
        }
    }
    
    
    func setNavBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Search"
    }
    
    let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.separatorColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.3)
        tableview.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        return tableview
    }()
    
    let searchTextField: UITextField = {
        let text = UITextField()
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderColor = UIColor.gray.cgColor
        text.placeholder = "Search by title of films..."
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.5).cgColor
        text.returnKeyType = .done
        text.textInsets = CGPoint(x: 10, y: 0)
        return text
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchClicked), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.5)
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    @objc func searchClicked () {
        self.searchTextField.resignFirstResponder()
        let sv = UIViewController.displaySpinner(onView: self.view)
        let variable = self.searchTextField.text!.replacingOccurrences(of: " ", with: "+")
        let requestURL: NSURL = NSURL(string: "http://omdbapi.com/?apikey=6b3ed3c&plot=short&s="+variable)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
                if (statusCode == 200) {
                    print("Everyone is fine, file downloaded successfully.")
                }
                else  {
                print("Failed")
                }
            do{
                self.filmList = []
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
                        self.filmList.append(f)
                        }
                    }
                }
            }
        task.resume()
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
            self.tableview.reloadData()
            if(self.filmList.count == 0) {
                self.alertMessageOk(title: "Oops..!", message: "There is no result or are \ntoo many results.")
            }
            UIViewController.removeSpinner(spinner: sv)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchTableViewCell
        cell.film = filmList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.mTitle = filmList[indexPath.row].title
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        
        view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.2)
        
        view.addSubview(searchTextField)
        
        searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
        searchTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:0.7).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        view.addSubview(searchButton)
        
        searchButton.topAnchor.constraint(equalTo: searchTextField.topAnchor).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor).isActive = true
        searchButton.leftAnchor.constraint(equalTo: searchTextField.rightAnchor, constant: 8).isActive = true
        searchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        view.addSubview(tableview)
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(SearchTableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableview.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 12).isActive = true
        tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}
