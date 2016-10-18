//
//  ViewController.swift
//  SwiftListViewExample
//
//  Created by Hemanta Sapkota on 19/10/16.
//  Copyright © 2016 Hemanta Sapkota. All rights reserved.
//

import UIKit
import SwiftListView

class ViewController: UIViewController {
    
    @IBOutlet var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onButtonClicked() {
        let listView = BasicListView(coder: nil)
    }

}

