//
//  GroupFilterButton.swift
//  SwiftListView
//
//  Created by Hemanta Sapkota on 15/11/16.
//  Copyright © 2016 Hemanta Sapkota. All rights reserved.
//

import OpenSansSwift

/* Group Filter Button */
open class GroupFilterButton : UIView {
    
    /* Label */
    public var label: UILabel!
    
    /* Button */
    public var button: UIButton!
    
    /* Handler */
    public var onSelection: ( (String) -> Void)?
    
    /* Selected Text */
    public var selectedText: String {
        get {
            return label.text!
        }
        set {
            label.text = newValue
        }
    }
    
    public init() {
        super.init(frame: UIScreen.main.bounds)
        
        /* Some background settings */
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 0.5
        
        // #d8e3e2
        self.layer.borderColor = UIColor(red: 216/255, green: 227/255, blue: 226/255, alpha: 1).cgColor
        // #d8e3e2
        self.layer.backgroundColor = UIColor(red: 216/255, green: 227/255, blue: 226/255, alpha: 1).cgColor
        
        /* Button */
        button = UIButton(type: UIButtonType.system)
        button.addTarget(self, action: #selector(GroupFilterButton.onTap), for: UIControlEvents.touchUpInside)
        button.tintColor = UIColor.white
        addSubview(button)
        button.snp.makeConstraints { (make) -> () in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.right).offset(off(-10))
            make.right.lessThanOrEqualTo(self.snp.right).offset(off(-10))
            make.width.equalTo(off(20))
            make.height.equalTo(off(20))
        }
        
        /* Label */
        label = UILabel()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.openSansFontOfSize(13)
        label.numberOfLines = 1
        
//        #85a5a0
        label.textColor = UIColor(red: 133, green: 165, blue: 160, alpha: 1)
        
        addSubview(label)
        label.snp.makeConstraints { (make) -> () in
            make.left.equalTo(off(10))
            make.right.lessThanOrEqualTo(self.button.snp.left)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        /* Tap Recognizer */
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(GroupFilterButton.onTap)))
    }
    
    func onTap() {
        if let handle = onSelection {
            let text = label.text?.trimmingCharacters(in: CharacterSet.whitespaces)
            handle(text!)
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

