//
//  TryViewController.swift
//  LoodosApp
//
//  Created by Semih Gençer on 19.11.2019.
//  Copyright © 2019 Semih Gençer. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseAnalytics

class DetailViewController: UIViewController {
    
    var mTitle : String = "inception"
    var film : Film = Film()
    var imdbRating : Double = 0

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let posterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.45).isActive = true
        return view
    }()
    
    let posterIView: UIImageView = {
        let iv = UIImageView()
        iv.image?.withRenderingMode(.alwaysOriginal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.numberOfLines = 2;
        label.adjustsFontSizeToFitWidth = true;
        label.textAlignment = .center
        return label
    }()
    
    let titleInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.5)
        label.numberOfLines = 1;
        label.textAlignment = .center
        return label
    }()
    
    let separatorView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.5)
        v.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return v
    }()
    
    let separatorView2: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.5)
        v.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return v
    }()
    
    let infoSection: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        return view
    }()
    
    let ratingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        return view
    }()
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "IMDb"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        return label
       }()
    
    let voterCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        return view
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.5)
        label.numberOfLines = 2;
        return label
    }()
    
    let producerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.5)
        label.numberOfLines = 2;
        return label
    }()
    
    let directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.5)
        label.numberOfLines = 2;
        return label
    }()
    
    let writerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.5)
        label.numberOfLines = 2;
        return label
    }()
    
    let actorsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.5)
        label.numberOfLines = 2;
        return label
    }()
    
    let languagesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.5)
        label.numberOfLines = 2;
        return label
    }()
    
    let boxOfficeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.5)
        label.numberOfLines = 2;
        return label
    }()
    
    let plotLabel: UILabel = {
        let label = UILabel()
        label.padding = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.8)
        label.numberOfLines = 200;
        return label
    }()
    
    let plotView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return view
    }()
    
    func updateValues() {
        
        self.titleLabel.text = self.film.title
                
        self.titleInfoLabel.text = String(self.film.year) + "    " + self.film.type.capitalizingFirstLetter() + "    " + String(self.film.runtime)
                
        self.voterCountLabel.text = self.film.imdbVotes + " users"
        
        let genreText: String = "Genre: " + self.film.genre
        genreLabel.text = genreText
        genreLabel.changeFont(ofText: "Genre: ", with: .boldSystemFont(ofSize: 11))
        genreLabel.changeTextColor(ofText: "Genre: ", with: .white)
            
                
        let producerText = "Producer: " + self.film.productor
        self.producerLabel.text = producerText
        producerLabel.changeTextColor(ofText: "Producer: ", with: .white)
        producerLabel.changeFont(ofText: "Producer: ", with: .boldSystemFont(ofSize: 11))
            
        let directorText = "Director: " + self.film.director
        self.directorLabel.text = directorText
        directorLabel.changeTextColor(ofText: "Director: ", with: .white)
        directorLabel.changeFont(ofText: "Director: ", with: .boldSystemFont(ofSize: 11))
                
        let writerText = "Writer: " + self.film.writer
        self.writerLabel.text = writerText
        writerLabel.changeTextColor(ofText: "Writer: ", with: .white)
        writerLabel.changeFont(ofText: "Writer: ", with: .boldSystemFont(ofSize: 11))
                
        let actorsText: String = "Actors: " + self.film.actors
        actorsLabel.text = actorsText
        actorsLabel.changeFont(ofText: "Actors: ", with: .boldSystemFont(ofSize: 11))
        actorsLabel.changeTextColor(ofText: "Actors: ", with: .white)
                
        let languagesText: String = "Languages: " + self.film.languages
        languagesLabel.text = languagesText
        languagesLabel.changeFont(ofText: "Languages: ", with: .boldSystemFont(ofSize: 11))
        languagesLabel.changeTextColor(ofText: "Languages: ", with: .white)
                
        let boxOfficeText: String = "Box Office: " + self.film.boxOffice
        boxOfficeLabel.text = boxOfficeText
        boxOfficeLabel.changeFont(ofText: "Box Office: ", with: .boldSystemFont(ofSize: 11))
        boxOfficeLabel.changeTextColor(ofText: "Box Office: ", with: .white)
            
        plotLabel.text = self.film.plot
        
        imdbRating = Double(self.film.imdbRating)!
        
        let progressBars = animateCircle(center: CGPoint(x: view.frame.width*0.2, y: view.frame.width*0.22), rating: imdbRating, radius: view.frame.width/8)
        ratingView.layer.addSublayer(progressBars[1])
        ratingView.layer.addSublayer(progressBars[0])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setFilm()
    }
    
    var sv: UIView? = nil
    func setFilm() {
        sv = UIViewController.displaySpinner(onView: self.view)
        let variable = self.mTitle.replacingOccurrences(of: " ", with: "+")
        let requestURL: NSURL = NSURL(string: "http://omdbapi.com/?apikey=6b3ed3c&t=" + variable + "&plot=full")!
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
                    , let film = json as? [String : Any]
                    {
                        let title = film["Title"] as! String
                        let year = film["Year"] as! String
                        let releaseDate = film["Released"] as! String
                        let runtime = film["Runtime"] as! String
                        let genre = film["Genre"] as! String
                        let director = film["Director"] as! String
                        let writer = film["Writer"] as! String
                        let actors = film["Actors"] as! String
                        let plot = film["Plot"] as! String
                        let language = film["Language"] as! String
                        let country = film["Country"] as! String
                        let awards = film["Awards"] as! String
                        let imdbRating = film["imdbRating"] as! String
                        let imdbVotes = film["imdbVotes"] as! String
                        let boxOffice = film["BoxOffice"] as! String
                        let imdbId = film["imdbID"] as! String
                        let type = film["Type"] as! String
                        let poster = film["Poster"] as! String
                        let productor = film["Production"] as! String
                        let f = Film(title: title, year: year, releaseDate: releaseDate, runtime: runtime, genre: genre, director: director, writer: writer, actors: actors, plot: plot, languages: language, country: country, awards: awards, poster: poster, imdbRating: imdbRating, imdbVotes: imdbVotes, imdbID: imdbId, type: type, boxOffice: boxOffice, productor: productor)
                        self.film = f
                    }
                }
            }
            task.resume()
            DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                Alamofire.request((self.film.poster), method: .get)
                .validate()
                .responseData(completionHandler: { (responseData) in
                    let image = UIImage(data: responseData.data!)
                    self.posterIView.image = image
            })
                self.updateValues()
            UIViewController.removeSpinner(spinner: self.sv!)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = self.mTitle
        
        setAnalytics()
        
        view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -12).isActive = true
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollViewContainer.addArrangedSubview(posterView)
        
        posterView.addSubview(posterIView)
        posterIView.centerXAnchor.constraint(equalTo: posterView.centerXAnchor).isActive = true
        posterIView.topAnchor.constraint(equalTo: posterView.topAnchor, constant: 0).isActive = true
        posterIView.widthAnchor.constraint(equalToConstant: view.frame.width*0.6).isActive = true
        posterIView.heightAnchor.constraint(equalTo: posterView.heightAnchor, multiplier: 0.95).isActive = true
        
        scrollViewContainer.addArrangedSubview(titleLabel)
        titleLabel.padding = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        titleLabel.heightAnchor.constraint(equalToConstant: view.frame.height*0.05).isActive = true
        
        scrollViewContainer.addArrangedSubview(titleInfoLabel)
        titleInfoLabel.heightAnchor.constraint(equalToConstant: view.frame.height*0.02).isActive = true
        
        scrollViewContainer.addArrangedSubview(separatorView)
        
        scrollViewContainer.addArrangedSubview(infoSection)
        infoSection.heightAnchor.constraint(equalToConstant: view.frame.height*0.19).isActive = true

        infoSection.addSubview(ratingView)
        ratingView.topAnchor.constraint(equalTo: infoSection.topAnchor, constant: 0).isActive = true
        ratingView.leftAnchor.constraint(equalTo: infoSection.leftAnchor, constant: 0).isActive = true
        ratingView.bottomAnchor.constraint(equalTo: infoSection.bottomAnchor).isActive = true
        ratingView.widthAnchor.constraint(equalToConstant: view.frame.width*0.4).isActive = true
        
        ratingView.addSubview(logoLabel)
        logoLabel.topAnchor.constraint(equalTo: ratingView.topAnchor, constant: 8).isActive = true
        logoLabel.leftAnchor.constraint(equalTo: ratingView.leftAnchor).isActive = true
        logoLabel.rightAnchor.constraint(equalTo: ratingView.rightAnchor).isActive = true

        ratingView.addSubview(voterCountLabel)
        voterCountLabel.bottomAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: -4).isActive = true
        voterCountLabel.leftAnchor.constraint(equalTo: ratingView.leftAnchor).isActive = true
        voterCountLabel.rightAnchor.constraint(equalTo: ratingView.rightAnchor).isActive = true
        
        infoSection.addSubview(infoView)
        infoView.topAnchor.constraint(equalTo: infoSection.topAnchor, constant: 0).isActive = true
        infoView.leftAnchor.constraint(equalTo: ratingView.rightAnchor, constant: 0).isActive = true
        infoView.rightAnchor.constraint(equalTo: infoSection.rightAnchor, constant: 0).isActive = true
        infoView.bottomAnchor.constraint(equalTo: infoSection.bottomAnchor, constant: 0).isActive = true
        
        infoView.addSubview(genreLabel)
        genreLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 2).isActive = true
        genreLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 2).isActive = true
        genreLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -2).isActive = true
        
        infoView.addSubview(producerLabel)
        producerLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 0).isActive = true
        producerLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 2).isActive = true
        producerLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -2).isActive = true
        
        infoView.addSubview(directorLabel)
        directorLabel.topAnchor.constraint(equalTo: producerLabel.bottomAnchor, constant: 2).isActive = true
        directorLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 2).isActive = true
        directorLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -2).isActive = true
        
        infoView.addSubview(writerLabel)
        writerLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 2).isActive = true
        writerLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 2).isActive = true
        writerLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -2).isActive = true

        infoView.addSubview(actorsLabel)
        actorsLabel.topAnchor.constraint(equalTo: writerLabel.bottomAnchor, constant: 2).isActive = true
        actorsLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 2).isActive = true
        actorsLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -2).isActive = true

        infoView.addSubview(languagesLabel)
        languagesLabel.topAnchor.constraint(equalTo: actorsLabel.bottomAnchor, constant: 2).isActive = true
        languagesLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 2).isActive = true
        languagesLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -2).isActive = true

        infoView.addSubview(boxOfficeLabel)
        boxOfficeLabel.topAnchor.constraint(equalTo: languagesLabel.bottomAnchor, constant: 2).isActive = true
        boxOfficeLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 2).isActive = true
        boxOfficeLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -2).isActive = true
        
        scrollViewContainer.addArrangedSubview(separatorView2)
        
        scrollViewContainer.addArrangedSubview(plotLabel)
    }
    
    func setAnalytics() {
        Analytics.logEvent("show_detail", parameters: [
            "title" : self.mTitle,
            "imdbId" : self.film.imdbID
        ])
    }
}
