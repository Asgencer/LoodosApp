//
//  UITableviewCell + Extensions.swift
//  LoodosApp
//
//  Created by Semih Gençer on 21.11.2019.
//  Copyright © 2019 Semih Gençer. All rights reserved.
//

import UIKit

extension UITableViewCell {

    var viewControllerForTableView : UIViewController?{
        return ((self.superview as? UITableView)?.delegate as? UIViewController)
    }

}
