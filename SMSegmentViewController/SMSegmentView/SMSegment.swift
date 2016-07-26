//
//  SMSegment.swift
//
//  Created by Si MA on 03/01/2015.
//  Copyright (c) 2015 Si Ma. All rights reserved.
//

import UIKit

public class SMSegment: UIView {
    
    // UI components
    private var imageView: UIImageView = UIImageView()
    private var label: UILabel = UILabel()
    
    // Title
    public var title: String? {
        didSet {
            dispatch_async(dispatch_get_main_queue(), {
                self.label.text = self.title
                self.layoutSubviews()
            })
        }
    }
    
    // Image
    public var onSelectionImage: UIImage?
    public var offSelectionImage: UIImage?
    
    // Appearance
    public var appearance: SMSegmentAppearance?
    
    internal var didSelectSegment: ((segment: SMSegment)->())?
    
    public internal(set) var index: Int = 0
    public private(set) var isSelected: Bool = false
    
    
    // Init
    internal init(appearance: SMSegmentAppearance?) {
        
        self.appearance = appearance
        
        super.init(frame: CGRectZero)
        self.addUIElementsToView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addUIElementsToView() {
        
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.addSubview(self.imageView)
        
        self.label.textAlignment = NSTextAlignment.Center
        self.addSubview(self.label)
    }
    
    internal func setupUIElements() {
        dispatch_async(dispatch_get_main_queue(), {
            if let appearance = self.appearance {
                self.backgroundColor = appearance.segmentOffSelectionColour
                self.label.font = appearance.titleOffSelectionFont
                self.label.textColor = appearance.titleOffSelectionColour
            }
            self.imageView.image = self.offSelectionImage
        })
    }
    
    
    // MARK: Update label and imageView frame
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        var distanceBetween: CGFloat = 0.0
        
        var verticalMargin: CGFloat = 0.0
        if let appearance = self.appearance {
            verticalMargin = appearance.contentVerticalMargin
        }
        
        var imageViewFrame = CGRectMake(0.0, verticalMargin, 0.0, self.frame.size.height - verticalMargin*2)
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
        self.label.frame = CGRectMake(imageViewFrame.origin.x + imageViewFrame.size.width + distanceBetween, verticalMargin, self.label.frame.size.width, self.frame.size.height - verticalMargin * 2)
    }
    
    // MARK: Selections
    internal func setSelected(selected: Bool) {
        self.isSelected = selected
        if selected == true {
            dispatch_async(dispatch_get_main_queue(), {
                self.backgroundColor = self.appearance?.segmentOnSelectionColour
                self.label.textColor = self.appearance?.titleOnSelectionColour
                self.imageView.image = self.onSelectionImage
            })
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                self.backgroundColor = self.appearance?.segmentOffSelectionColour
                self.label.textColor = self.appearance?.titleOffSelectionColour
                self.imageView.image = self.offSelectionImage
            })
        }
    }
    
    // MARK: Handle touch
    override public  func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.isSelected == false {
            self.backgroundColor = self.appearance?.segmentTouchDownColour
        }
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.isSelected == false{
            self.didSelectSegment?(segment: self)
        }
    }
}