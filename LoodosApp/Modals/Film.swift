//
//  Film.swift
//  LoodosApp
//
//  Created by Semih Gençer on 16.11.2019.
//  Copyright © 2019 Semih Gençer. All rights reserved.
//

import Foundation
import SwiftyJSON

class Film: Codable {

    let title: String
    let year: String
    let releaseDate: String
    let runtime: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let languages: String
    let country: String
    let awards: String
    let poster: String
    let imdbRating: String
    let imdbVotes: String
    let imdbID: String
    let type: String
    let boxOffice: String
    let productor: String
    
    
    init() {
        self.title = ""
        self.year = ""
        self.releaseDate = ""
        self.runtime = ""
        self.genre = ""
        self.director = ""
        self.writer = ""
        self.actors = ""
        self.plot = ""
        self.languages = ""
        self.country = ""
        self.awards = ""
        self.poster = ""
        self.imdbRating = ""
        self.imdbVotes = ""
        self.imdbID = ""
        self.type = ""
        self.boxOffice = ""
        self.productor = ""
    }
    
    init(title: String, year: String, imdbID: String, type: String, poster: String ) {
        self.title = title
        self.year = year
        self.releaseDate = ""
        self.runtime = ""
        self.genre = ""
        self.director = ""
        self.writer = ""
        self.actors = ""
        self.plot = ""
        self.languages = ""
        self.country = ""
        self.awards = ""
        self.poster = poster
        self.imdbRating = ""
        self.imdbVotes = ""
        self.imdbID = imdbID
        self.type = type
        self.boxOffice = ""
        self.productor = ""
    }
    
    init(title: String, year: String, releaseDate: String, runtime: String, genre: String, director: String, writer: String, actors: String, plot: String, languages: String, country: String, awards: String, poster: String, imdbRating: String, imdbVotes: String, imdbID: String, type: String, boxOffice: String, productor: String) {
        self.title = title
        self.year = year
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.genre = genre
        self.director = director
        self.writer = writer
        self.actors = actors
        self.plot = plot
        self.languages = languages
        self.country = country
        self.awards = awards
        self.poster = poster
        self.imdbRating = imdbRating
        self.imdbVotes = imdbVotes
        self.imdbID = imdbID
        self.type = type
        self.boxOffice = boxOffice
        self.productor = productor
    }
}

