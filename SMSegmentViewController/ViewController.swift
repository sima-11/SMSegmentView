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
        
        /*
          Init SMsegmentView
          Use a Dictionary here to set its properties.
          Each property has its own default value, so you only need to specify for those you are interested.
        */
        self.segmentView = SMSegmentView(frame: CGRect(x: self.margin, y: 50.0, width: self.view.frame.size.width - self.margin*2, height: 40.0), seperatorColour: UIColor.blueColor(), seperatorWidth: 1.0, segmentProperties: [keySegmentTitleFont: UIFont.systemFontOfSize(12.0), keySegmentOnSelectionColour: UIColor.blackColor(), keySegmentOffSelectionColour: UIColor.greenColor(), keyContentVerticalMargin: 5.0])
        
        self.segmentView.delegate = self
        
        // Original iOS style of border
        self.segmentView.layer.cornerRadius = 5.0
        self.segmentView.layer.borderColor = UIColor.blueColor().CGColor
        self.segmentView.layer.borderWidth = 1.0
        
        // Add segments
        self.segmentView.addSegmentWithTitle("Segment A", onSelectionImage: UIImage(named: "target_light"), offSelectionImage: UIImage(named: "target"))
        self.segmentView.addSegmentWithTitle("Segment B", onSelectionImage: UIImage(named: "handbag_light"), offSelectionImage: UIImage(named: "handbag"))
        self.segmentView.addSegmentWithTitle("Segment C", onSelectionImage: UIImage(named: "globe_light"), offSelectionImage: UIImage(named: "globe"))
        
        // Set segment with index 0 as selected by default
        segmentView.selectSegmentAtIndex(0)
        
        self.view.addSubview(self.segmentView)
    }

    // SMSegment Delegate
    func didSelectSegmentAtIndex(segmentIndex: Int) {
        /*
          Implement what you want the app to do after the segment gets tapped.
        */
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        /*
        MARK: Replace the following line to your own frame setting for segmentView.
        */
        self.segmentView.frame = CGRect(x: self.margin, y: 50.0, width: self.view.frame.size.width - self.margin*2, height: 40.0)
    }
}

