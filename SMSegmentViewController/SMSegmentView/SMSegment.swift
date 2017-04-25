//
//  SMSegment.swift
//
//  Created by Si MA on 03/01/2015.
//  Copyright (c) 2015 Si Ma. All rights reserved.
//

import UIKit

open class SMSegment: UIView {
    
    // UI components
    fileprivate var imageView: UIImageView = UIImageView()
    fileprivate var label: UILabel = UILabel()
    
    // Title
    open var title: String? {
        didSet {
            DispatchQueue.main.async(execute: {
                self.label.text = self.title
                self.layoutSubviews()
            })
        }
    }
    
    // Image
    open var onSelectionImage: UIImage?
    open var offSelectionImage: UIImage?
    
    // Appearance
    open var appearance: SMSegmentAppearance?
    
    internal var didSelectSegment: ((_ segment: SMSegment)->())?
    
    open internal(set) var index: Int = 0
    open fileprivate(set) var isSelected: Bool = false
    
    
    // Init
    internal init(appearance: SMSegmentAppearance?) {
        
        self.appearance = appearance
        
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupUIElements() {
        self.imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        
        self.label.textAlignment = NSTextAlignment.center
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        var verticalMargin: CGFloat = 0.0
        if let appearance = self.appearance {
            verticalMargin = appearance.contentVerticalMargin
        }
        
        let imagePresent = (self.offSelectionImage != nil) || (self.onSelectionImage != nil)
        var titlePresent = false
        if let title = self.title {
            titlePresent = (title != "")
        }
        if imagePresent && titlePresent {
            // we have both image and title so we need to center them together
            let view = UIView(frame: CGRect.zero) // this will be used to hold the image and label inside
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(self.imageView)
            view.addSubview(self.label)
            
            view.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.label.trailingAnchor).isActive = true
            self.label.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 5.0).isActive = true // this is used to separate image and label
            
            view.topAnchor.constraint(lessThanOrEqualTo: self.imageView.topAnchor).isActive = true
            view.topAnchor.constraint(lessThanOrEqualTo: self.label.topAnchor).isActive = true
            
            view.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: self.label.centerYAnchor).isActive = true
            
            self.addSubview(view)
            
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            self.topAnchor.constraint(equalTo: view.topAnchor, constant:-verticalMargin).isActive = true
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        else if imagePresent {
            self.addSubview(self.imageView)
            self.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor).isActive = true
            self.topAnchor.constraint(lessThanOrEqualTo: self.imageView.topAnchor, constant: -verticalMargin).isActive = true
        }
        else if titlePresent {
            self.addSubview(self.label)
            self.centerXAnchor.constraint(equalTo: self.label.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: self.label.centerYAnchor).isActive = true
            self.topAnchor.constraint(lessThanOrEqualTo: self.label.topAnchor, constant: -verticalMargin).isActive = true
        }
        
        
        
        
        DispatchQueue.main.async(execute: {
            if let appearance = self.appearance {
                self.backgroundColor = appearance.segmentOffSelectionColour
                self.label.font = appearance.titleOffSelectionFont
                self.label.textColor = appearance.titleOffSelectionColour
            }
            self.imageView.image = self.offSelectionImage
        })
    }
    
    // MARK: Selections
    internal func setSelected(_ selected: Bool) {
        self.isSelected = selected
        if selected == true {
            DispatchQueue.main.async(execute: {
                self.backgroundColor = self.appearance?.segmentOnSelectionColour
                self.label.textColor = self.appearance?.titleOnSelectionColour
                self.label.font = self.appearance?.titleOnSelectionFont
                self.imageView.image = self.onSelectionImage
            })
        }
        else {
            DispatchQueue.main.async(execute: {
                self.backgroundColor = self.appearance?.segmentOffSelectionColour
                self.label.textColor = self.appearance?.titleOffSelectionColour
                self.label.font = self.appearance?.titleOffSelectionFont
                self.imageView.image = self.offSelectionImage
            })
        }
    }
    
    // MARK: Handle touch
    override open  func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isSelected == false {
            self.backgroundColor = self.appearance?.segmentTouchDownColour
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isSelected == false{
            self.didSelectSegment?(self)
        }
    }
}
