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
import SnapKit

class ViewController: UIViewController {
    
    var selectedItem = "Himalayan Cat"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = View()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

class View : UIView {
    
    var showCatBreed: GroupFilterButton!
    
    var showDogBreed: GroupFilterButton!
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        
        self.backgroundColor = UIColor.white
        
        // Cat Breed
        var selectedCat = ""
        
        showCatBreed = GroupFilterButton()
        showCatBreed.SelectedText = "Choose Cat Breed"
        showCatBreed.onSelection = { selected in
            let listView = BasicListView(viewTitle: "Cat Breeds", highlighted: selectedCat)
            
            listView.Items = ["American Bobtail", "American Curl", "American Shorthair", "Himalayan Cat"]
            listView.onSelection = { selected in
                self.showCatBreed.SelectedText = selected
                selectedCat = selected
            }
            
            listView.show()
            
        }
        addSubview(showCatBreed)
        showCatBreed.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.snp.top).offset(50)
            
            make.centerX.equalTo(self.snp.centerX)
//            make.centerY.equalTo(self.snp.centerY).offset(-60)
            
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        
        // Dog Breed
        var selectedDog = ""
        
        showDogBreed = GroupFilterButton()
        showDogBreed.SelectedText = "Choose dog breed"
        showDogBreed.onSelection = { selected in
            let listView = BasicListView(viewTitle: "", highlighted: selectedDog)
            listView.ShowProgress = true
            listView.onSelection = { selected in
                self.showDogBreed.SelectedText = selected
                selectedDog = selected
            }
            listView.ItemsLoader = { (completion) in
                GCDTimer.delay(0.8, block: {
                    listView.ShowProgress = false
                    completion!(["Dog Breed", "Labrador Retriever", "German Shepherd"])
                })
            }
            listView.show()
        }
        addSubview(showDogBreed)
        showDogBreed.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(showCatBreed.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX)
            
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

