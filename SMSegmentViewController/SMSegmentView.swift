//
//  SMSegmentView.swift
//
//  Created by Si MA on 03/01/2015.
//  Copyright (c) 2015 Si Ma. All rights reserved.
//

import UIKit


let keyContentVerticalMargin = "VerticalMargin"
let keySegmentOnSelectionColour = "OnSelectionBackgroundColour"
let keySegmentOffSelectionColour = "OffSelectionBackgroundColour"
let keySegmentOnSelectionTextColour = "OnSelectionTextColour"
let keySegmentOffSelectionTextColour = "OffSelectionTextColour"
let keySegmentTitleFont = "TitleFont"

protocol SMSegmentViewDelegate {
    func didSelectSegmentAtIndex(segmentIndex: Int)
}

class SMSegmentView: UIView, SMSegmentDelegate {
    var delegate: SMSegmentViewDelegate?
    
    var indexOfSelectedSegment = NSNotFound
    var numberOfSegments = 0
    
    var segmentVerticalMargin: CGFloat = 5.0 {
        didSet {
            for segment in self.segments {
                segment.verticalMargin = self.segmentVerticalMargin
            }
        }
    }
    
    // Segment Seperator
    var seperatorColour: UIColor = UIColor.lightGrayColor() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var seperatorWidth: CGFloat = 1.0 {
        didSet {
            for segment in self.segments {
                segment.seperatorWidth = self.seperatorWidth
            }
            self.updateFrameForSegments()
        }
    }
    
    // Segment Colour
    var segmentOnSelectionColour: UIColor = UIColor.darkGrayColor() {
        didSet {
            for segment in self.segments {
                segment.onSelectionColour = self.segmentOnSelectionColour
            }
        }
    }
    var segmentOffSelectionColour: UIColor = UIColor.whiteColor() {
        didSet {
            for segment in self.segments {
                segment.offSelectionColour = self.segmentOffSelectionColour
            }
        }
    }
    
    // Segment Title Text Colour & Font
    var segmentOnSelectionTextColour: UIColor = UIColor.whiteColor() {
        didSet {
            for segment in self.segments {
                segment.onSelectionTextColour = self.segmentOnSelectionTextColour
            }
        }
    }
    var segmentOffSelectionTextColour: UIColor = UIColor.darkGrayColor() {
        didSet {
            for segment in self.segments {
                segment.offSelectionTextColour = self.segmentOffSelectionTextColour
            }
        }
    }
    var segmentTitleFont: UIFont = UIFont.systemFontOfSize(17.0) {
        didSet {
            for segment in self.segments {
                segment.titleFont = self.segmentTitleFont
            }
        }
    }
    
    override var frame: CGRect {
        didSet {
            self.updateFrameForSegments()
        }
    }
    
    private var segments: Array<SMSegment> = Array()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
    }
    
    init(frame: CGRect, seperatorColour: UIColor, seperatorWidth: CGFloat, segmentProperties: Dictionary<String, AnyObject>?) {
        self.seperatorColour = seperatorColour
        self.seperatorWidth = seperatorWidth
        
        if let margin = segmentProperties?[keyContentVerticalMargin] as? NSNumber {
            self.segmentVerticalMargin = CGFloat(margin)
        }
        
        if let onSelectionColour = segmentProperties?[keySegmentOnSelectionColour] as? UIColor {
            self.segmentOnSelectionColour = onSelectionColour
        }
        else {
            self.segmentOnSelectionColour = UIColor.darkGrayColor()
        }
        
        if let offSelectionColour = segmentProperties?[keySegmentOffSelectionColour] as? UIColor {
            self.segmentOffSelectionColour = offSelectionColour
        }
        else {
            self.segmentOffSelectionColour = UIColor.whiteColor()
        }
        
        if let onSelectionTextColour = segmentProperties?[keySegmentOnSelectionTextColour] as? UIColor {
            self.segmentOnSelectionTextColour = onSelectionTextColour
        }
        else {
            self.segmentOnSelectionTextColour = UIColor.whiteColor()
        }
        
        if let offSelectionTextColour = segmentProperties?[keySegmentOffSelectionTextColour] as? UIColor {
            self.segmentOffSelectionTextColour = offSelectionTextColour
        }
        else {
            self.segmentOffSelectionTextColour = UIColor.darkGrayColor()
        }
        
        if let titleFont = segmentProperties?[keySegmentTitleFont] as? UIFont {
            self.segmentTitleFont = titleFont
        }
        else {
            self.segmentTitleFont = UIFont.systemFontOfSize(17.0)
        }
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
    }
    
    func addSegmentWithTitle(title: String?, onSelectionImage: UIImage?, offSelectionImage: UIImage?) {
        
        let segment = SMSegment(seperatorWidth: self.seperatorWidth, verticalMargin: self.segmentVerticalMargin, onSelectionColour: self.segmentOnSelectionColour, offSelectionColour: self.segmentOffSelectionColour, onSelectionTextColour: self.segmentOnSelectionTextColour, offSelectionTextColour: self.segmentOffSelectionTextColour, titleFont: self.segmentTitleFont)
        segment.index = self.segments.count
        self.segments.append(segment)
        self.updateFrameForSegments()
        
        segment.delegate = self
        segment.title = title
        segment.onSelectionImage = onSelectionImage
        segment.offSelectionImage = offSelectionImage
        
        self.addSubview(segment)
        
        self.numberOfSegments = self.segments.count
    }
    
    func updateFrameForSegments() {
        if self.segments.count == 0 {
            return
        }
        
        let count = self.segments.count
        if count > 1 {
            let segmentWidth = (self.frame.size.width - self.seperatorWidth*CGFloat(count-1)) / CGFloat(count)
            var originX:CGFloat = 0.0
            for segment in self.segments {
                segment.frame = CGRect(x: originX, y: 0.0, width: segmentWidth, height: self.frame.size.height)
                originX += segmentWidth + self.seperatorWidth
            }
        }
        else {
            self.segments[0].frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        }
        
        self.setNeedsDisplay()
    }
    
    // MARK: SMSegment Delegate
    func selectSegment(segment: SMSegment) {
        if self.indexOfSelectedSegment != NSNotFound {
            let previousSelectedSegment = self.segments[self.indexOfSelectedSegment]
            previousSelectedSegment.setSelected(false)
        }
        self.indexOfSelectedSegment = segment.index
        segment.setSelected(true)
        self.delegate?.didSelectSegmentAtIndex(segment.index)
    }
    
    // MARK: Actions
    func selectSegmentAtIndex(index: Int) {
        assert(index >= 0 && index < self.segments.count, "Index at \(index) is out of bounds")
        self.selectSegment(self.segments[index])
    }
    
    func deselectSegment() {
        if self.indexOfSelectedSegment != NSNotFound {
            let segment = self.segments[self.indexOfSelectedSegment]
            segment.setSelected(false)
            self.indexOfSelectedSegment = NSNotFound
        }
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        self.drawSeperatorWithContext(context)
    }
    
    
    // MARK: Drawings
    func drawSeperatorWithContext(context: CGContextRef) {
        CGContextSaveGState(context)
        
        if self.segments.count > 1 {
            var path = CGPathCreateMutable()
            var originX: CGFloat = self.segments[0].frame.size.width + self.seperatorWidth/2.0
            for index in 1..<self.segments.count {
                CGPathMoveToPoint(path, nil, originX, 0.0)
                CGPathAddLineToPoint(path, nil, originX, self.frame.size.height)
                CGContextAddPath(context, path)
                
                CGContextSetStrokeColorWithColor(context, self.seperatorColour.CGColor)
                
                originX += self.segments[index].frame.width + self.seperatorWidth
            }
            CGContextSetLineWidth(context, self.seperatorWidth)
            CGContextDrawPath(context, kCGPathStroke)
        }
        
        CGContextRestoreGState(context)
    }
}
