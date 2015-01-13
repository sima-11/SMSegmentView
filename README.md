<p align="center"><img src ="/Screenshots/example_1.png"/></p>

# SMSegmentView Description
- Custom segmented control for iOS 7 and above.
- Written in Swift.
- Support both images and text.
- Support vertically organise segments
- More customisible than UISegmentedControl and easier to expand with new style.


# How To Use
#### Step 1
Drag `SMSegmentView.swift` and `SMSegment.swift` into your Xcode project.

#### Step 2
Initialise SMSegmentView:
You can simply use `SMSegmentView(frame:)` to initialise your segment view by using the default properties. 
But mostly, you may want to use `SMSegmentView(frame: seperatorColour: seperatorWidth: segmentProperties:)` to make it look more customised.
The parameter `segmentProperties:` reads a `Dictionary<String, AnyObject>` value. You can find what key it supports on the top of `SMSegmentView` file.

E.g.:
```
var segmentView = SMSegmentView(frame: CGRect(x: 10.0, y: 50.0, width: 300.0, height: 40.0), seperatorColour: UIColor.blueColor(), seperatorWidth: 1.0, segmentProperties: [keySegmentTitleFont: UIFont.systemFontOfSize(12.0), keySegmentOnSelectionColour: UIColor.blackColor(), keySegmentOffSelectionColour: UIColor.greenColor(), keyContentVerticalMargin: 5.0])
```

#### Step 3
Assign delegate for the instance of SMSegmentView.

E.g. `segmentView.delegate = self`

#### Step 4
Add segments to your segment view.

E.g.:
```
segmentView.addSegmentWithTitle("Segment 1", onSelectionImage: UIImage(named: "target_light"), offSelectionImage: UIImage(named: "target"))
segmentView.addSegmentWithTitle("Segment 2", onSelectionImage: UIImage(named: "handbag_light"), offSelectionImage: UIImage(named: "handbag"))
segmentView.addSegmentWithTitle("Segment 3", onSelectionImage: UIImage(named: "globe_light"), offSelectionImage: UIImage(named: "globe"))
```

#### Optional Step
You can programmatically select/deselect a segment by calling `selectSegmentAtIndex(index: Int)`.

# Support Vertical Mode
You can organise all segments vertically by setting the `segmentMode` as `.SegmentOrganiseVertical`. It is set to `.SegmentOrganiseHorizontal` by default.

E.g. `segmentView.segmentMode = .SegmentOrganiseVertical`

<p align="center"><img src ="/Screenshots/example_vertical.png"/></p>

# More Info
The framework comes with a sample project for you.
Besides, this <a href='http://keeptheseinmind.blogspot.co.uk/2015/01/custom-segmentedcontrol-in-swift.html'>tutorial</a> may give you some idea how to expand this framework a little bit.

# Screenshots
<p align="center"><img src ="/Screenshots/example_2.png"/></p>
<p align="center"><img src ="/Screenshots/example_3.png"/></p>
