//
//  FilmCollectionViewCell.swift
//  LoodosApp
//
//  Created by Semih Gençer on 20.11.2019.
//  Copyright © 2019 Semih Gençer. All rights reserved.
//

import UIKit
import Alamofire

class FilmCollectionViewCell: UICollectionViewCell {
    
    var film : Film? {
        didSet {
            titleLabel.text = film?.title
            request((film?.poster)!, method: .get).validate().responseData(completionHandler: { (responseData) in
                let image = UIImage(data: responseData.data!)
                self.imageView.image = image
            })
        }
    }
    
    let imageView: UIImageView = {
        let iw = UIImageView()
        iw.layer.cornerRadius = 10
        iw.translatesAutoresizingMaskIntoConstraints = false
        iw.clipsToBounds = true
        iw.layer.borderColor = UIColor.white.cgColor
        iw.layer.borderWidth = 1
        iw.image?.withRenderingMode(.alwaysOriginal)
        return iw
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 4).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
