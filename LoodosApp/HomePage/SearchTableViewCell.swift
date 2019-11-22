//
//  SearchTableViewCell.swift
//  LoodosApp
//
//  Created by Semih Gençer on 21.11.2019.
//  Copyright © 2019 Semih Gençer. All rights reserved.
//

import UIKit
import Alamofire

class SearchTableViewCell: UITableViewCell {
    
    var film : Film? {
        didSet {
            titleLabel.text = film?.title
            yearLabel.text = "Year: " + film!.year
            yearLabel.changeFont(ofText: "Year: ", with: UIFont.boldSystemFont(ofSize: 12))
            typeLabel.text = "Type: " + film!.type.capitalizingFirstLetter()
            typeLabel.changeFont(ofText: "Type: ", with: UIFont.boldSystemFont(ofSize: 12))
            request((film?.poster)!, method: .get).validate().responseData(completionHandler: { (responseData) in
                let image = UIImage(data: responseData.data!)
                self.posterImageView.image = image
            })
        }
    }
    
    let posterImageView: UIImageView = {
        let iw = UIImageView()
        iw.translatesAutoresizingMaskIntoConstraints = false
        iw.layer.cornerRadius = 10
        iw.clipsToBounds = true
        iw.layer.borderColor = UIColor.white.cgColor
        iw.layer.borderWidth = 1
        iw.backgroundColor = .clear
        iw.image?.withRenderingMode(.alwaysOriginal)
        return iw
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 2;
        label.textAlignment = .left
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 220, green: 220, blue: 220, alpha: 0.5)
        label.numberOfLines = 2;
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 220, green: 220, blue: 220, alpha: 0.5)
        label.numberOfLines = 2;
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 60, green: 60, blue: 60, alpha: 0.5)
        
        addSubview(posterImageView)
        
        posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        posterImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        
        addSubview(yearLabel)
        yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        yearLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12).isActive = true
        yearLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        
        addSubview(typeLabel)
        typeLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 8).isActive = true
        typeLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12).isActive = true
        typeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
