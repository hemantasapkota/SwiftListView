//
//  BasicListView.swift
//  SwiftListView
//
//  Created by Hemanta Sapkota on 19/10/16.
//  Copyright © 2016 Hemanta Sapkota. All rights reserved.
//

import Foundation

import Foundation
import Spring
import GCDTimer
import SnapKit
import MRProgress
import OpenSansSwift

let kRetinaScaleFactor:CGFloat = 1.2

func isPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
}

func off(_ value: CGFloat) -> Float {
    if isPad() {
        return Float(value * kRetinaScaleFactor)
    }
    return Float(value)
}

class UIProgress {
    
    class func show(_ view: UIView, title: String) {
        if MRProgressOverlayView.overlay(for: view) == nil {
            MRProgressOverlayView.showOverlayAdded(to: view, title: title, mode: MRProgressOverlayViewMode.indeterminateSmall, animated: true)
        }
    }
    
    class func showSuccess(_ view: UIView, title: String) {
        if MRProgressOverlayView.overlay(for: view) == nil {
            MRProgressOverlayView.showOverlayAdded(to: view, title: title, mode: MRProgressOverlayViewMode.checkmark, animated: true)
        }
    }
    
    class func hide(_ view: UIView) {
        DispatchQueue.main.async { () -> Void in
            MRProgressOverlayView.dismissOverlay(for: view, animated: true)
        }
    }
}


/* List View */
open class BasicListView : UIView, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    static let ROW_HEIGHT = CGFloat(off(40))
    
    /* Content View */
    var contentView: SpringView!
    
    /* Title Label */
    var titleView: UILabel!
    
    /* Table View */
    var tableView: UITableView!
    
    /* Handler */
    open var onSelection: ((String) -> Void)!
    
    /* Selected string */
    open var selectedText: String!
    
    /* Tap Handler when there are no items */
    var tapHandler: UITapGestureRecognizer!
    
    fileprivate var _showProgress: Bool = false
    open var ShowProgress: Bool {
        get { return _showProgress }
        
        set {
            _showProgress = newValue
            if !_showProgress {
                UIProgress.hide(self)
            }
        }
    }
    
    /* View Title */
    var _viewTitle: String!
    open var VewTitle: String {
        get {
            return _viewTitle
        }
        set {
            _viewTitle = newValue
        }
    }
    
    /* List Items */
    var _items: [String]!
    open var Items: [String] {
        get {
            return _items
        }
        set {
            _items = newValue
            
            // Update constraints if items less than 5
            if _items.count <= 5 {
                var height:CGFloat = 0
                for _ in 0 ..< _items.count {
                    height += BasicListView.ROW_HEIGHT
                }
                contentView.snp.remakeConstraints { (make) -> Void in
                    make.centerX.equalTo(self.snp.centerX)
                    make.centerY.equalTo(self.snp.centerY)
                    make.width.equalTo(self.snp.width).dividedBy(1.3)
                    
                    make.height.greaterThanOrEqualTo(height + 30)
                }
            } else {
                contentView.snp.remakeConstraints({ (make) -> Void in
                    make.centerX.equalTo(self.snp.centerX)
                    make.centerY.equalTo(self.snp.centerY)
                    make.width.equalTo(self.snp.width).dividedBy(1.3)
                    
                    make.height.equalTo(self.snp.height).dividedBy(1.6)
                })
            }
        }
    }
    
    /* Items Loader */
    open var ItemsLoader: ( (_ done:(([String]) -> Void)?) -> Void)? {
        get { return nil }
        
        set {
            newValue! { items in
                self.Items = items
                self.tableView.reloadData()
            }
        }
    }
    
    public init(viewTitle: String, highlighted:String) {
        super.init(frame: UIScreen.main.bounds)
        
        selectedText = highlighted
        _viewTitle = viewTitle
        _items = []
        
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
        
        /* Table View */
        tableView = UITableView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        tableView.dataSource = self
        tableView.delegate = self
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.width.equalTo(self.contentView.snp.width)
            make.height.equalTo(self.contentView.snp.height).offset(-20)
        }
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        
        /* Title View */
        titleView = UILabel()
        titleView.textColor = UIColor.white
        titleView.font = UIFont.openSansFontOfSize(12)
        titleView.text = _viewTitle
        addSubview(titleView)
        titleView.snp.updateConstraints { (make) -> Void in
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.bottom.lessThanOrEqualTo(self.tableView.snp.top).offset(-15)
        }
        
        /* Tap handler */
        tapHandler = UITapGestureRecognizer(target: self, action: #selector(BasicListView.closeView))
        tapHandler.delegate = self
        addGestureRecognizer(tapHandler)
        
        // On Orientation Change
        NotificationCenter.default.addObserver(self, selector: #selector(BasicListView.onOrientationChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    func onOrientationChange() {
        // This fixes the problem of orientation change clipping
        self.frame = UIScreen.main.bounds
        self.setNeedsLayout()
    }
    
    open func closeView() {
        self.removeFromSuperview()
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        
        let text = _items[(indexPath as NSIndexPath).item]
        cell.Bold = text == selectedText
        cell.label.text = text
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BasicListView.ROW_HEIGHT
    }
    
    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let _ = onSelection {
            onSelection(self._items[(indexPath as NSIndexPath).item])
        }
    }
    
    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        GCDTimer.delay(0.1) { () -> Void in
            self.closeView()
        }
    }
    
    open func show() {
        let rv = UIApplication.shared.keyWindow?.subviews.last
        rv!.addSubview(self)
        
        self.contentView.animation = "slideDown"
        self.contentView.animate()
        
        if _showProgress {
            UIProgress.show(self, title: "")
        }
    }
    
    /* List Table View Cell */
    class ListTableViewCell : UITableViewCell {
        
        /* Bold Property */
        var Bold: Bool {
            get {
                return label.font == UIFont.openSansBoldFontOfSize(12)
            }
            
            set {
                if newValue {
                    label.font = UIFont.openSansBoldFontOfSize(12)
                } else {
                    label.font = UIFont.openSansFontOfSize(12)
                }
            }
        }
        
        /* Label */
        var label: UILabel!
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: UITableViewCellStyle.default, reuseIdentifier: "ListTableViewCell")
            
            label = UILabel()
            label.font = UIFont.openSansFontOfSize(12)
            label.numberOfLines = 2
            label.lineBreakMode = NSLineBreakMode.byTruncatingTail
            label.textAlignment = NSTextAlignment.center
            contentView.addSubview(label)
            
            label.snp.makeConstraints { (make) -> Void in
                make.center.equalTo(self.snp.center)
                make.width.equalTo(self.snp.width).dividedBy(1.3)
            }
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

extension BasicListView {
    
    @objc(gestureRecognizer:shouldReceiveTouch:) public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: tableView) {
            return false
        }
        return true
    }
    
}
