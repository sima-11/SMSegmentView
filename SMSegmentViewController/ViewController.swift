//
//  SMSegmentViewController
//
//  Created by Si Ma on 05/01/2015.
//  Copyright (c) 2015 Si Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SMSegmentViewDelegate {
    
    var segmentView: SMSegmentView!
    var margin: CGFloat = 10.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        /*
          Init SMsegmentView
          Use a Dictionary here to set its properties.
          Each property has its own default value, so you only need to specify for those you are interested.
        */
        self.segmentView = SMSegmentView(frame: CGRect(x: self.margin, y: 120.0, width: self.view.frame.size.width - self.margin*2, height: 40.0), separatorColour: UIColor(white: 0.95, alpha: 0.3), separatorWidth: 0.5, segmentProperties: [keySegmentTitleFont: UIFont.systemFontOfSize(12.0), keySegmentOnSelectionColour: UIColor(red: 245.0/255.0, green: 174.0/255.0, blue: 63.0/255.0, alpha: 1.0), keySegmentOffSelectionColour: UIColor.whiteColor(), keyContentVerticalMargin: Float(10.0)])
        
        self.segmentView.delegate = self
        
        self.segmentView.layer.cornerRadius = 5.0
        self.segmentView.layer.borderColor = UIColor(white: 0.85, alpha: 1.0).CGColor
        self.segmentView.layer.borderWidth = 1.0
        
        // Add segments
        self.segmentView.addSegmentWithTitle("Clip", onSelectionImage: UIImage(named: "clip_light"), offSelectionImage: UIImage(named: "clip"))
        self.segmentView.addSegmentWithTitle("Blub", onSelectionImage: UIImage(named: "bulb_light"), offSelectionImage: UIImage(named: "bulb"))
        self.segmentView.addSegmentWithTitle("Cloud", onSelectionImage: UIImage(named: "cloud_light"), offSelectionImage: UIImage(named: "cloud"))
        
        // Set segment with index 0 as selected by default
        //segmentView.selectSegmentAtIndex(0)
        
        self.view.addSubview(self.segmentView)
    }

    // SMSegment Delegate
    func segmentView(segmentView: SMSegmentView, didSelectSegmentAtIndex index: Int) {
        /*
        Replace the following line to implement what you want the app to do after the segment gets tapped.
        */
        println("Select segment at index: \(index)")
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        /*
        MARK: Replace the following line to your own frame setting for segmentView.
        */
        if toInterfaceOrientation == UIInterfaceOrientation.LandscapeLeft || toInterfaceOrientation == UIInterfaceOrientation.LandscapeRight {
            self.segmentView.organiseMode = .SegmentOrganiseVertical
            self.segmentView.segmentVerticalMargin = 25.0
            self.segmentView.frame = CGRect(x: self.view.frame.size.width/2 - 40.0, y: 100.0, width: 80.0, height: 220.0)
        }
        else {
            self.segmentView.organiseMode = .SegmentOrganiseHorizontal
            self.segmentView.segmentVerticalMargin = 10.0
            self.segmentView.frame = CGRect(x: self.margin, y: 120.0, width: self.view.frame.size.width - self.margin*2, height: 40.0)
        }
    }
}

