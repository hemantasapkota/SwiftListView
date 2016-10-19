## SwiftListView
Collection of simple &amp; neutral list views for IOS written in Swift.

## Features

* Animated
* Set static items or define a data loader
* Works on both iPhone and iPad
* Supports orientation change

## List Views

### BasicListView

![Screenshot](ss1.png)

### Usage

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
