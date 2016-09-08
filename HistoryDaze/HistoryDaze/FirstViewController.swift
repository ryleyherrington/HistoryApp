//
//  FirstViewController.swift
//  HistoryDaze
//
//  Created by Ryley Herrington on 9/7/16.
//  Copyright © 2016 Herrington. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NetworkHelper.sharedInstance.getSummaryOfArticle("World_War_I") { (result) in
            print("Result:\(result)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

