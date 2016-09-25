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
        self.addUIElementsToView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addUIElementsToView() {
        
        self.imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.addSubview(self.imageView)
        
        self.label.textAlignment = NSTextAlignment.center
        self.addSubview(self.label)
    }
    
    internal func setupUIElements() {
        DispatchQueue.main.async(execute: {
            if let appearance = self.appearance {
                self.backgroundColor = appearance.segmentOffSelectionColour
                self.label.font = appearance.titleOffSelectionFont
                self.label.textColor = appearance.titleOffSelectionColour
            }
            self.imageView.image = self.offSelectionImage
        })
    }
    
    
    // MARK: Update label and imageView frame
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        var distanceBetween: CGFloat = 0.0
        
        var verticalMargin: CGFloat = 0.0
        if let appearance = self.appearance {
            verticalMargin = appearance.contentVerticalMargin
        }
        
        var imageViewFrame = CGRect(x: 0.0, y: verticalMargin, width: 0.0, height: self.frame.size.height - verticalMargin*2)
        if self.onSelectionImage != nil || self.offSelectionImage != nil {
            // Set imageView as a square
            imageViewFrame.size.width = self.frame.size.height - verticalMargin*2
            distanceBetween = 5.0
        }
        
        // If there's no text, align image in the centre
        // Otherwise align text & image in the centre
        self.label.sizeToFit()
        if self.label.frame.size.width == 0.0 {
            imageViewFrame.origin.x = max((self.frame.size.width - imageViewFrame.size.width) / 2.0, 0.0)
        }
        else {
            imageViewFrame.origin.x = max((self.frame.size.width - imageViewFrame.size.width - self.label.frame.size.width) / 2.0 - distanceBetween, 0.0)
        }
        
        self.imageView.frame = imageViewFrame
        self.label.frame = CGRect(x: imageViewFrame.origin.x + imageViewFrame.size.width + distanceBetween, y: verticalMargin, width: self.label.frame.size.width, height: self.frame.size.height - verticalMargin * 2)
    }
    
    // MARK: Selections
    internal func setSelected(_ selected: Bool) {
        self.isSelected = selected
        if selected == true {
            DispatchQueue.main.async(execute: {
                self.backgroundColor = self.appearance?.segmentOnSelectionColour
                self.label.textColor = self.appearance?.titleOnSelectionColour
                self.imageView.image = self.onSelectionImage
            })
        }
        else {
            DispatchQueue.main.async(execute: {
                self.backgroundColor = self.appearance?.segmentOffSelectionColour
                self.label.textColor = self.appearance?.titleOffSelectionColour
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
