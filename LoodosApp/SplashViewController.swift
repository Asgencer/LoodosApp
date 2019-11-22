//
//  ViewController.swift
//  LoodosApp
//
//  Created by Semih Gençer on 15.11.2019.
//  Copyright © 2019 Semih Gençer. All rights reserved.
//

import UIKit
import Network
import Firebase

class SplashViewController: UIViewController {
    
    func updateValues() {
        loodosLabel.text = RemoteConfig.remoteConfig().configValue(forKey: "loodosLabel").stringValue ?? ""
    }
    
    func setUpRemoteConfigDefaults() {
        let defaultValues = [
            "loodosText" : "Default" as NSObject
        ]
        RemoteConfig.remoteConfig().setDefaults(defaultValues)
    }
    
    func fetchRemoteConfigValues() {
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
            guard error == nil else {
                self.alertMessageOk(title: "Oops..!", message: "Values could not updated from\nthe cloud")
                return
            }
            
            RemoteConfig.remoteConfig().activateFetched()
            self.updateValues()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //check conn
        checkForInternet()
        setUpRemoteConfigDefaults()
        fetchRemoteConfigValues()
        
        view.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.addSubview(loodosLabel)
        
        loodosLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loodosLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loodosLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        loodosLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 16).isActive = true
        
        
    }
    
    func checkForInternet() {
        let monitor = NWPathMonitor()
            monitor.pathUpdateHandler = { pathUpdateHandler in
                if pathUpdateHandler.status == .satisfied {
                    print("Internet connection is on.")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.presentNextPage()
                    }
                } else {
                    print("There's no internet connection.")
                }
            }
        monitor.start(queue: DispatchQueue(label: "InternetConnectionMonitor"))
    }
    
    func presentNextPage() {
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    let loodosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(70)
        label.textAlignment = .center
        label.textColor = UIColor(red: 95/255, green: 172/255, blue: 188/255, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 70)
        return label
    }()


}

