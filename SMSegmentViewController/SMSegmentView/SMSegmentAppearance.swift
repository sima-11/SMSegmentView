//
//  SMSegmentAppearance.swift
//  SMSegmentViewController
//
//  Created by Si MA on 11/07/2016.
//  Copyright © 2016 si.ma. All rights reserved.
//

import UIKit

public class SMSegmentAppearance {
    
    // PROPERTIES
    public var segmentOnSelectionColour: UIColor
    public var segmentOffSelectionColour: UIColor
    public var segmentTouchDownColour: UIColor {
        get {
            var onSelectionHue: CGFloat = 0.0
            var onSelectionSaturation: CGFloat = 0.0
            var onSelectionBrightness: CGFloat = 0.0
            var onSelectionAlpha: CGFloat = 0.0
            self.segmentOnSelectionColour.getHue(&onSelectionHue, saturation: &onSelectionSaturation, brightness: &onSelectionBrightness, alpha: &onSelectionAlpha)
            
            var offSelectionHue: CGFloat = 0.0
            var offSelectionSaturation: CGFloat = 0.0
            var offSelectionBrightness: CGFloat = 0.0
            var offSelectionAlpha: CGFloat = 0.0
            self.segmentOffSelectionColour.getHue(&offSelectionHue, saturation: &offSelectionSaturation, brightness: &offSelectionBrightness, alpha: &offSelectionAlpha)
            
            return UIColor(hue: onSelectionHue, saturation: (onSelectionSaturation + offSelectionSaturation)/2.0, brightness: (onSelectionBrightness + offSelectionBrightness)/2.0, alpha: (onSelectionAlpha + offSelectionAlpha)/2.0)
        }
    }
    
    public var titleOnSelectionColour: UIColor
    public var titleOffSelectionColour: UIColor
    
    public var titleOnSelectionFont: UIFont
    public var titleOffSelectionFont: UIFont
    
    public var contentVerticalMargin: CGFloat
    
    
    // INITIALISER
    internal init() {
        
        self.segmentOnSelectionColour = UIColor.darkGrayColor()
        self.segmentOffSelectionColour = UIColor.grayColor()
        
        self.titleOnSelectionColour = UIColor.whiteColor()
        self.titleOffSelectionColour = UIColor.darkGrayColor()
        self.titleOnSelectionFont = UIFont.systemFontOfSize(17.0)
        self.titleOffSelectionFont = UIFont.systemFontOfSize(17.0)
        
        self.contentVerticalMargin = 5.0
    }
    
    internal init(contentVerticalMargin: CGFloat, segmentOnSelectionColour: UIColor, segmentOffSelectionColour: UIColor, titleOnSelectionColour: UIColor, titleOffSelectionColour: UIColor, titleOnSelectionFont: UIFont, titleOffSelectionFont: UIFont) {
        
        self.contentVerticalMargin = contentVerticalMargin
        
        self.segmentOnSelectionColour = segmentOnSelectionColour
        self.segmentOffSelectionColour = segmentOffSelectionColour
        
        self.titleOnSelectionColour = titleOnSelectionColour
        self.titleOffSelectionColour = titleOffSelectionColour
        self.titleOnSelectionFont = titleOnSelectionFont
        self.titleOffSelectionFont = titleOffSelectionFont
    }
}
