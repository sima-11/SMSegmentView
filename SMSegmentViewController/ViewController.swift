//
//  ViewController.swift
//  SMSegmentViewController
//
//  Created by si.ma on 05/01/2015.
//  Copyright (c) 2015 si.ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SMSegmentViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segmentView = SMSegmentView(frame: CGRect(x: 10.0, y: 50.0, width: 330.0, height: 40.0), seperatorColour: UIColor.blueColor(), seperatorWidth: 1.0, segmentProperties: [keySegmentTitleFont: UIFont.systemFontOfSize(12.0), keySegmentOnSelectionColour: UIColor.blackColor(), keySegmentOffSelectionColour: UIColor.greenColor(), keyContentVerticalMargin: 5.0])
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
        segmentView.selectSegmentAtIndex(0)
        
        self.view.addSubview(segmentView)
    }

    // SMSegment Delegate
    func didSelectSegmentAtIndex(segmentIndex: Int) {
        /*
          Implement what you want the app to do after the segment gets tapped
        */
    }
}

