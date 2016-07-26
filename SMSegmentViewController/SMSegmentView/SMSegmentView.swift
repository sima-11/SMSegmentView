//
//  SMBasicSegmentView.swift
//  SMSegmentViewController
//
//  Created by Si Ma on 01/10/15.
//  Copyright © 2015 Si Ma. All rights reserved.
//

import UIKit

public class SMSegmentView: UIControl {

    public var segmentAppearance: SMSegmentAppearance?

    // Divider colour & width
    public var dividerColour: UIColor = UIColor.lightGrayColor() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    public var dividerWidth: CGFloat = 1.0 {
        didSet {
            self.updateSegmentsLayout()
        }
    }

    public var selectedSegmentIndex: Int {
        get {
            if let segment = self.selectedSegment {
                return segment.index
            }
            else {
                return UISegmentedControlNoSegment
            }
        }
        set(newIndex) {
            self.deselectSegment()
            if newIndex >= 0 && newIndex < self.segments.count {
                let currentSelectedSegment = self.segments[newIndex]
                self.selectSegment(currentSelectedSegment)
            }
        }
    }

    public var organiseMode: SMSegmentOrganiseMode = .Horizontal {
        didSet {
            if self.organiseMode != oldValue {
                self.setNeedsDisplay()
            }
        }
    }

    public var numberOfSegments: Int {
        get {
            return segments.count
        }
    }

    private var segments: [SMSegment] = []
    private var selectedSegment: SMSegment?


    // INITIALISER
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.segmentAppearance = SMSegmentAppearance()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
        self.segmentAppearance = SMSegmentAppearance()
    }

    public init(frame: CGRect, dividerColour: UIColor, dividerWidth: CGFloat, segmentAppearance: SMSegmentAppearance) {

        super.init(frame: frame)

        self.dividerColour = dividerColour
        self.dividerWidth = dividerWidth
        
        self.segmentAppearance = segmentAppearance

        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
    }
    

    // MARK: Actions
    // MARK: Select/deselect Segment
    private func selectSegment(segment: SMSegment) {
        segment.setSelected(true)
        self.selectedSegment = segment
        self.sendActionsForControlEvents(.ValueChanged)
    }
    private func deselectSegment() {
        self.selectedSegment?.setSelected(false)
        self.selectedSegment = nil
    }

    // MARK: Add Segment
    public func addSegmentWithTitle(title: String?, onSelectionImage: UIImage?, offSelectionImage: UIImage?) {
        self.insertSegmentWithTitle(title, onSelectionImage: onSelectionImage, offSelectionImage: offSelectionImage, index: self.segments.count)
    }

    public func insertSegmentWithTitle(title: String?, onSelectionImage: UIImage?, offSelectionImage: UIImage?, index: Int) {

        let segment = SMSegment(appearance: self.segmentAppearance)

        segment.title = title
        segment.onSelectionImage = onSelectionImage
        segment.offSelectionImage = offSelectionImage
        segment.index = index
        segment.didSelectSegment = { [weak self] segment in
            if self!.selectedSegment != segment {
                self!.deselectSegment()
                self!.selectSegment(segment)
            }
        }
        segment.setupUIElements()
        
        self.resetSegmentIndicesWithIndex(index, by: 1)
        self.segments.insert(segment, atIndex: index)

        self.addSubview(segment)
        self.layoutSubviews()
    }
    
    // MARK: Remove Segment
    public func removeSegmentAtIndex(index: Int) {
        assert(index >= 0 && index < self.segments.count, "Index (\(index)) is out of range")
        
        if index == self.selectedSegmentIndex {
            self.selectedSegmentIndex = UISegmentedControlNoSegment
        }
        self.resetSegmentIndicesWithIndex(index, by: -1)
        let segment = self.segments.removeAtIndex(index)
        segment.removeFromSuperview()
        self.updateSegmentsLayout()
    }
    
    private func resetSegmentIndicesWithIndex(index: Int, by: Int) {
        if index < self.segments.count {
            for i in index..<self.segments.count {
                let segment = self.segments[i]
                segment.index += by
            }
        }
    }

    // MARK: UI
    // MARK: Update layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.updateSegmentsLayout()
    }

    private func updateSegmentsLayout() {
        
        guard self.segments.count > 0 else {
            return
        }

        if self.segments.count > 1 {
            if self.organiseMode == .Horizontal {
                let segmentWidth = ceil((self.frame.size.width - self.dividerWidth * CGFloat(self.segments.count-1)) / CGFloat(self.segments.count))

                var originX: CGFloat = 0.0
                for segment in self.segments {
                    segment.frame = CGRect(x: originX, y: 0.0, width: segmentWidth, height: self.frame.size.height)
                    originX += segmentWidth + self.dividerWidth
                }
            }
            else {
                let segmentHeight = (self.frame.size.height - self.dividerWidth * CGFloat(self.segments.count-1)) / CGFloat(self.segments.count)

                var originY: CGFloat = 0.0
                for segment in self.segments {
                    segment.frame = CGRect(x: 0.0, y: originY, width: self.frame.size.width, height: segmentHeight)
                    originY += segmentHeight + self.dividerWidth
                }
            }
        }
        else {
            self.segments[0].frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        }

        self.setNeedsDisplay()
    }

    // MARK: Drawing Segment Dividers
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)

        let context = UIGraphicsGetCurrentContext()!
        self.drawDividerWithContext(context)
    }

    private func drawDividerWithContext(context: CGContextRef) {

        CGContextSaveGState(context)

        if self.segments.count > 1 {
            let path = CGPathCreateMutable()

            if self.organiseMode == .Horizontal {
                var originX: CGFloat = self.segments[0].frame.size.width + self.dividerWidth/2.0
                for index in 1..<self.segments.count {
                    CGPathMoveToPoint(path, nil, originX, 0.0)
                    CGPathAddLineToPoint(path, nil, originX, self.frame.size.height)

                    originX += self.segments[index].frame.width + self.dividerWidth
                }
            }
            else {
                var originY: CGFloat = self.segments[0].frame.size.height + self.dividerWidth/2.0
                for index in 1..<self.segments.count {
                    CGPathMoveToPoint(path, nil, 0.0, originY)
                    CGPathAddLineToPoint(path, nil, self.frame.size.width, originY)

                    originY += self.segments[index].frame.height + self.dividerWidth
                }
            }

            CGContextAddPath(context, path)
            CGContextSetStrokeColorWithColor(context, self.dividerColour.CGColor)
            CGContextSetLineWidth(context, self.dividerWidth)
            CGContextDrawPath(context, CGPathDrawingMode.Stroke)
        }
        
        CGContextRestoreGState(context)
    }
}