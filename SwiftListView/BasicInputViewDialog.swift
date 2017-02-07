//
//  BasicListInputView.swift
//  SwiftListView
//
//  Created by Hemanta Sapkota on 11/12/16.
//  Copyright © 2016 Hemanta Sapkota. All rights reserved.
//

import Foundation
import Spring

open class BasicInputViewDialog : UIView, UIGestureRecognizerDelegate {
    
    /* Content View */
    var contentView: SpringView!
    
    /* Title Label */
    var titleView: UILabel!
    
    /* Tap Handler when there are no items */
    var tapHandler: UITapGestureRecognizer!
    
    public init(viewTitle: String) {
        super.init(frame: UIScreen.main.bounds)
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        /* Content View */
        contentView = SpringView()
        contentView.layer.cornerRadius = 4
        contentView.backgroundColor = UIColor.white
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(self.snp.width).dividedBy(1.3)
        }
        
        /* Tap handler */
        tapHandler = UITapGestureRecognizer(target: self, action: #selector(BasicListView.closeView))
        tapHandler.delegate = self
        addGestureRecognizer(tapHandler)
        
        // On Orientation Change
        NotificationCenter.default.addObserver(self, selector: #selector(BasicInputViewDialog.onOrientationChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BasicInputViewDialog {
    
    func onOrientationChange() {
        // This fixes the problem of orientation change clipping
        self.frame = UIScreen.main.bounds
        self.setNeedsLayout()
    }

    
    @objc(gestureRecognizer:shouldReceiveTouch:) public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
//        if touch.view!.isDescendant(of: tableView) {
//            return false
//        }
        
        return true
    }
    
}
