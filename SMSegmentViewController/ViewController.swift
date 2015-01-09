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
        
        
        self.segmentView = SMSegmentView(frame: CGRect(x: self.margin, y: 50.0, width: self.view.frame.size.width - self.margin*2, height: 40.0), seperatorColour: UIColor.blueColor(), seperatorWidth: 1.0, segmentProperties: [keySegmentTitleFont: UIFont.systemFontOfSize(12.0), keySegmentOnSelectionColour: UIColor.blackColor(), keySegmentOffSelectionColour: UIColor.greenColor(), keyContentVerticalMargin: 5.0])
        segmentView.delegate = self
        
        // Original iOS style of border
        segmentView.layer.cornerRadius = 5.0
        segmentView.layer.borderColor = UIColor.blueColor().CGColor
        segmentView.layer.borderWidth = 1.0
        
        // Add segments
        segmentView.addSegmentWithTitle("Segment A", onSelectionImage: UIImage(named: "target_light"), offSelectionImage: UIImage(named: "target"))
        segmentView.addSegmentWithTitle("Segment B", onSelectionImage: UIImage(named: "handbag_light"), offSelectionImage: UIImage(named: "handbag"))
        segmentView.addSegmentWithTitle("Segment C", onSelectionImage: UIImage(named: "globe_light"), offSelectionImage: UIImage(named: "globe"))
        
        // Set segment with index 0 as selected by default
        //segmentView.selectSegmentAtIndex(0)
        
        self.view.addSubview(segmentView)
    }

    // SMSegment Delegate
    func didSelectSegmentAtIndex(segmentIndex: Int) {
        /*
          Implement what you want the app to do after the segment gets tapped
        */
        segmentView.segmentOnSelectionColour = UIColor.darkGrayColor()
        segmentView.segmentOffSelectionColour = UIColor.lightGrayColor()
        segmentView.segmentOnSelectionTextColour = UIColor.whiteColor()
        segmentView.segmentOffSelectionTextColour = UIColor.blackColor()
        //segmentView.segmentTitleFont = UIFont(name: "Helvetica Neue", size: 1.0)!
        segmentView.segmentVerticalMargin = 10.0
        segmentView.seperatorWidth = 10.0
        segmentView.seperatorColour = UIColor.grayColor()
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        /*
        MARK: Replace the following line to your own frame setting for segmentView
        */
        self.segmentView.frame = CGRect(x: self.margin, y: 50.0, width: self.view.frame.size.width - self.margin*2, height: 40.0)
    }
}

