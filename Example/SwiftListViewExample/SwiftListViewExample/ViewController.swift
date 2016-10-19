//
//  ViewController.swift
//  SwiftListViewExample
//
//  Created by Hemanta Sapkota on 19/10/16.
//  Copyright © 2016 Hemanta Sapkota. All rights reserved.
//

import UIKit
import SwiftListView
import GCDTimer

class ViewController: UIViewController {
    
    @IBOutlet var basicListViewBtn: UIButton!
    
    @IBOutlet var basicListViewBtn2: UIButton!
    
    var selectedItem = "Himalayan Cat"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBasicListViewBtnClicked() {
        let listView = BasicListView(viewTitle: "Cat Breeds", highlighted: selectedItem)
        
        listView.Items = ["American Bobtail", "American Curl", "American Shorthair", "Himalayan Cat"]
        
        listView.onSelection = { selected in
            self.basicListViewBtn.titleLabel?.text = selected
            self.selectedItem = selected
        }
        
        listView.show()
    }
    
    @IBAction func onBasicListViewBtn2Clicked() {
        let listView = BasicListView(viewTitle: "", highlighted: "")
        
        listView.ShowProgress = true
        
        listView.ItemsLoader = { (completion) in
            GCDTimer.delay(0.8, block: {
                listView.ShowProgress = false
                completion!(["Dog Breed", "Labrador Retriever", "German Shepherd"])
            })
        }
        
        listView.show()
    }

}

