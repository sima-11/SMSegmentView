//
//  SMSegment.swift
//
//  Created by Si MA on 03/01/2015.
//  Copyright (c) 2015 Si Ma. All rights reserved.
//

import UIKit

open class SMSegment: UIView {
    
    // UI components
    private var imageView: UIImageView = UIImageView()
    private var label: UILabel = UILabel()
    
    // Title
    public var title: String? {
        didSet {
            self.label.text = title
            self.setNeedsLayout()
        }
    }
    
    // Image
    open var onSelectionImage: UIImage?
    open var offSelectionImage: UIImage?
    
    // Appearance
    open var appearance: SMSegmentAppearance?
    
    internal var didSelectSegment: ((_ segment: SMSegment)->())?
    
    internal(set) var index: Int = 0
    private(set) var isSelected: Bool = false
    
    
    // Init
    internal init(appearance: SMSegmentAppearance?) {
        
        self.appearance = appearance
        
        super.init(frame: CGRect.zero)
        self.addUIElementsToView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        fatalError("init(frame:) won't work properly. Use init(appearance:) instead")
    }
    
    private func addUIElementsToView() {
        
        self.imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.addSubview(self.imageView)
        
        self.label.textAlignment = NSTextAlignment.center
        self.addSubview(self.label)
    }
    
    internal func setupUIElements() {
        if let appearance = self.appearance {
            self.backgroundColor = appearance.segmentOffSelectionColour
            self.label.font = appearance.titleOffSelectionFont
            self.label.textColor = appearance.titleOffSelectionColour
        }
        self.imageView.image = self.offSelectionImage
    }
    
    
    // MARK: Update label and imageView frame
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        var distanceBetween: CGFloat = 0.0
        
        var verticalMargin: CGFloat = 0.0
        if let appearance = self.appearance {
            verticalMargin = appearance.contentVerticalMargin
        }
        
        var imageViewFrame = CGRect(x: 0.0, y: verticalMargin, width: 0.0, height: self.frame.size.height - verticalMargin * 2)
        if self.onSelectionImage != nil || self.offSelectionImage != nil {
            // Set imageView as a square
            imageViewFrame.size.width = imageViewFrame.height
            distanceBetween = 5.0
        }
        
        // Initialize empty title frame
        var titleViewFrame: CGRect = CGRect()
        
        // If there's no text, align image in the centre
        // Otherwise align text & image in the centre and apply title gravity
        self.label.sizeToFit()
        if self.label.frame.size.width == 0.0 {
            imageViewFrame.origin.x = max((self.frame.size.width - imageViewFrame.size.width) / 2.0, 0.0)
        }
        else {
            titleViewFrame.size.width = self.label.frame.size.width
            
            switch self.appearance?.titleGravity {
            case .some(SMSTitleGravity.bottom):
                // Setup title width and height properties according to image size
                titleViewFrame.size.height = self.label.frame.size.height // Need to be as small as possible to fit
                
                // Place image horizontally in centre and vertically to the top + vertical margin (changed to fit two vertical items)
                imageViewFrame.size.height = self.frame.size.height - verticalMargin * 2.5
                
                if imageViewFrame.size.height + self.label.font.lineHeight > self.frame.size.height {
                    imageViewFrame.size.height -= self.label.font.lineHeight / 2
                }
                
                imageViewFrame.size.width = imageViewFrame.size.height
                imageViewFrame.origin.x = (self.frame.size.width - imageViewFrame.size.width)/2
                imageViewFrame.origin.y = verticalMargin / 2
                
                // Place the title horizontally in centre and vertivally below image + vertical margin (changed to fit two vertical items)
                titleViewFrame.origin.x = (self.frame.size.width - titleViewFrame.size.width)/2
                titleViewFrame.origin.y = imageViewFrame.size.height + verticalMargin / 1.5
                break
            case .some(SMSTitleGravity.top):
                // Setup title width and height properties according to image size
                titleViewFrame.size.height = self.label.frame.size.height // Need to be as small as possible to fit
                
                // Place title horizontally in centre and vertically to the top + vertical margin (changed to fit two vertical items)
                titleViewFrame.origin.x = (self.frame.size.width - titleViewFrame.size.width)/2
                titleViewFrame.origin.y = verticalMargin / 2
                
                // Place the image horizontally in centre and vertivally below title + vertical margin (changed to fit two vertical items)
                imageViewFrame.size.height = self.frame.size.height - verticalMargin * 2.5
                
                if imageViewFrame.size.height + self.label.font.lineHeight > self.frame.size.height {
                    imageViewFrame.size.height -= self.label.font.lineHeight / 2
                }
                
                imageViewFrame.size.width = imageViewFrame.size.height
                imageViewFrame.origin.x = (self.frame.size.width - imageViewFrame.size.width)/2
                imageViewFrame.origin.y = titleViewFrame.size.height + verticalMargin / 1.5
                break
            case .some(SMSTitleGravity.left):
                // Setup title width and height properties according to image size
                titleViewFrame.size.height = self.frame.size.height - verticalMargin * 2
                
                // If left space > 0, set half of it as initial X point of title
                titleViewFrame.origin
                    .x = max(
                        (self.frame.size.width - imageViewFrame.size.width - self.label.frame.size.width) / 2.0 - distanceBetween,
                        0.0
                    )
                
                titleViewFrame.origin
                    .y = verticalMargin
                
                // Place image to the right of title
                imageViewFrame.origin.x = titleViewFrame.origin.x + titleViewFrame.size.width + distanceBetween
                break
                
            default:
                // Setup title width and height properties according to image size
                titleViewFrame.size.width = self.label.frame.size.width
                titleViewFrame.size.height = self.frame.size.height - verticalMargin * 2
                // If left space > 0, set half of it as initial X point og image
                imageViewFrame.origin.x = max(
                    (self.frame.size.width - imageViewFrame.size.width - self.label.frame.size.width) / 2.0 - distanceBetween,
                    0.0
                )
                // Place title to the right of image
                titleViewFrame.origin.x = imageViewFrame.origin.x + imageViewFrame.size.width + distanceBetween
                titleViewFrame.origin.y = verticalMargin
            }
        }
        
        self.imageView.frame = imageViewFrame
        self.label.frame = titleViewFrame
    }
    
    // MARK: Selections
    internal func setSelected(_ selected: Bool) {
        self.isSelected = selected
        if selected == true {
            self.backgroundColor = self.appearance?.segmentOnSelectionColour
            self.label.textColor = self.appearance?.titleOnSelectionColour
            self.imageView.image = self.onSelectionImage
        }
        else {
            self.backgroundColor = self.appearance?.segmentOffSelectionColour
            self.label.textColor = self.appearance?.titleOffSelectionColour
            self.imageView.image = self.offSelectionImage
        }
    }
    
    // MARK: Handle touch
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isSelected == false {
            self.backgroundColor = self.appearance?.segmentTouchDownColour
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isSelected == false{
            self.didSelectSegment?(self)
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isSelected == false {
            self.backgroundColor = self.appearance?.segmentOffSelectionColour
        }
        else {
            if self.isSelected == false {
                self.backgroundColor = self.appearance?.segmentOnSelectionColour
            }
        }
    }
}
