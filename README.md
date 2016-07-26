<p align="center"><img src ="/Screenshots/example_1.png"/></p>

# SMSegmentView Description
- Custom segmented control for iOS 7 and above.
- Written in Swift.
- Support both images and text.
- Support vertically organise segments
- More customisible than UISegmentedControl and easier to expand with new style.

#### For CocoaPods User
Add `pod 'SMSegmentView', '~> 1.1'` to Podfile.

<b>Notice:</b> It seems when using Swift, CocoaPods won't accept frameworks target below iOS 8. So if you would like to support iOS 7, you might have to add this framework manually. 


# How To Use
#### Step 1
Drag `SMSegmentView.swift` and `SMSegment.swift` into your Xcode project.

#### Step 2
Initialise SMSegmentView:
You can simply use `SMSegmentView(frame:)` to initialise your segment view by using the default properties. 
But mostly, you may want to use `SMSegmentView(frame:, dividerColour:, dividerWidth:, segmentAppearance:)` to make it look more customised.
The parameter `segmentAppearance:` reads a `SMSegmentAppearance` instance. You can find what attributes it supports in `SMSegmentAppearance` class.

E.g.:
```swift
let appearance = SMSegmentAppearance()
appearance.segmentOnSelectionColour = UIColor(red: 245.0/255.0, green: 174.0/255.0, blue: 63.0/255.0, alpha: 1.0)
appearance.segmentOffSelectionColour = UIColor.whiteColor()
appearance.titleOnSelectionFont = UIFont.systemFontOfSize(12.0)
appearance.titleOffSelectionFont = UIFont.systemFontOfSize(12.0)
appearance.contentVerticalMargin = 10.0

let segmentView = SMSegmentView(frame: SomeFrame, dividerColour: UIColor(white: 0.95, alpha: 0.3), dividerWidth: 1.0, segmentAppearance: appearance)
```

#### Step 3
Add action for UIControlEvents.ValueChanged, and implement the action method.

E.g. `segmentView.addTarget(self, action: #selector(YourViewController.selectSegmentInSegmentView(_:)), forControlEvents: .ValueChanged)`

#### Step 4
Add segments to your segment view.

E.g.:
```
segmentView.addSegmentWithTitle("Segment 1", onSelectionImage: UIImage(named: "target_light"), offSelectionImage: UIImage(named: "target"))
segmentView.addSegmentWithTitle("Segment 2", onSelectionImage: UIImage(named: "handbag_light"), offSelectionImage: UIImage(named: "handbag"))
segmentView.addSegmentWithTitle("Segment 3", onSelectionImage: UIImage(named: "globe_light"), offSelectionImage: UIImage(named: "globe"))
```

#### Optional Step
You can programmatically select/deselect a segment by assign an integer to `selectedSegmentIndex`.

# Support Vertical Mode
You can organise all segments vertically by setting the `organiseMode` as `.Vertical`. It is set to `.Horizontal` by default.

E.g. `segmentView.organiseMode = .Vertical`

<p align="center"><img src ="/Screenshots/example_vertical.png"/></p>

# More Info
The framework comes with a sample project for you.
Besides, this <a href='http://keeptheseinmind.blogspot.co.uk/2015/01/custom-segmentedcontrol-in-swift.html'>tutorial</a> may give you some idea how to expand this framework a little bit.

# Screenshots
<p align="center"><img src ="/Screenshots/example_2.png"/></p>
<p align="center"><img src ="/Screenshots/example_3.png"/></p>
