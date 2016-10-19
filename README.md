## SwiftListView
Collection of simple &amp; neutral list views for IOS written in Swift.

## Features

* Animated
* Set static items or define a data loader
* Works on both iPhone and iPad
* Supports orientation change

## Installation

* Add ```github "hemantasapkota/SwiftListView"``` to your ```cartfile```
* Execute ```carthage update```

**Note**: SwiftListView includes other libraries as dependencies. Carthage will pull and build them as well. You must include all the dependencies to your project. 

## List Views

### BasicListView

![Screenshot](ss1.png)

### Usage - Static List

```swift
var highlighted = "Himalayan Cat"

let listView = BasicListView(viewTitle: "Cat Breeds", highlighted: highlighted)
listView.Items = ["American Bobtail", "American Curl", "American Shorthair", "Himalayan Cat"]

listView.onSelection = { selected in  

  // Do something with the selected item. Ex: Update UI
  self.basicListViewBtn.titleLabel?.text = selected

  self.highlighted = selected
}

listView.show()

```

### Usage - Dynamic List

```swift
let listView = BasicListView(viewTitle: "", highlighted: "")

listView.ShowProgress = true

listView.ItemsLoader = { (completion) in
    // Load the data asynchronously and call the completion block with the returned array
    // Mock example
    GCDTimer.delay(0.8, block: {
        listView.ShowProgress = false
        completion!(["Dog Breed", "Labrador Retriever", "German Shepherd"))
    })
}

listView.show()
```

### Author ###
* [Hemanta Sapkota](https://twitter.com/ozhemanta) / [Blog](http://hemantasapkota.github.io/) / [Linked In](https://au.linkedin.com/in/hemantasapkota)
