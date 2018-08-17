# Maketa

An operational API to manage *AutoLayout*.

# Quick Start

*Maketa* provides an operational, easy to read, easy to write, API to manage AutoLayout. 

Some examples:

```swift
// Match attribute of a view to another attributes
view.mkt.left = otherView.mkt.right + 10

// Set sizing attributes directly or relative to other view size
view.mkt.height = 100
view.mkt.width = otherView.mkt.width
view.size = otherView.mkt.size * 0.5

// Center views in another view
view.center = view.mkt.super.center

// Make edges to match other edges or margins
view.mkt.edges = view.mkt.super.edges - UIContentInset(top: 16, left: 16, bottom: 16, right: 16)
view.mkt.edges = otherView.mkt.margins - .top
```

### `greaterOrEqual`  and `lessOrEqual`

To make the constraints have a  `.greaterOrEqual`  or `.lessOrEqual` relation, just replace `=` by `>` or `<`:

```swift
view.mkt.height < 100
view.mkt.left > otherView.mkt.right
```

### Set constraints priority

You can change the priority of a constraint using the `&`  operator:

```swift
view.mkt.left = (otherView.mkt.right + 10) & .defaultLow
view.mkt.edges = otherView.mkt.margins & .defaultHigh
```

### Saving the constraints
In case you need to keep a reference of the constraints added by `Maketa`, you can use the `=>` operator:

```swift
var constraint = NSLayoutConstraint.empty
view.mkt.height = 10 => constraint

var constraint: NSLayoutConstraint?
view.mkt.top = (view.mkt.super.top + 50) => constraint

var constraints: [NSLayoutConstraint] = []
view.mkt.center = view.mkt.super.center => constraints

var constraints: [NSLayoutConstraint]?
view.mkt.edges = otherView.mkt.margins => constraints
```

# Advanced usage
## Layout Attributes
Maketa mirrors all the built-in `NSLayoutAttribute` cases so that you can set any of them.

You can set the attribute to:

- Another attribute (of the same or another view).
- A constant
- An operation between attributes and constants

```swift
view.mkt.leading = otherView.mkt.leading
view.mkt.height = 10
view.mkt.centerY = otherView.mkt.centerY * 2 + 5
```

Using the `=>` operator will return a single `NSLayoutConstraint`.

```swift
var constraint: NSLayoutConstraint?
view.mkt.height = 10 => constraint
```

## Center

You can match the center of a view to the center of another view with a single instruction:

```swift
view.mkt.center = otherView.mkt.center
```

Using the `=>` operator will return an array of `NSLayoutConstraint` with 2 elements, the first one for the `centerX` attribute and the second one for the `centerY`.
 
```swift
var constraints: [NSLayoutConstraint]?
view.mkt.center = view.mkt.super.center => constraints
```

#### Adding an offset
You can also add an offset into the center. You can do it with the `-` and `+` operators and with a constant or a `UIOffset`:

```swift
// will add an offset of 20 pixels for centerX and centerY
view.mkt.center = otherView.mkt.center + 20

// using a UIOffset
view.mkt.center = otherView.mkt.center - UIOffset(horizontal: 10, vertical)
```

## Size

You can add constraints for the size of a view with one single instruction. You can do it in several ways:

```swift
// a constant: Set both width and height to the same value
view.mkt.size = 100

// a CGSize
view.mkt.size = CGSize(width: 100, height: 200)

// Another view size
view.mkt.size = otherView.mkt.size
```

Using the `=>` operator will return an array of `NSLayoutConstraint` with 2 elements, the first one for the `width` attribute and the second one for the `height`.
 
```swift
var constraints: [NSLayoutConstraint]?
view.mkt.size = CGSize(width: 100, height: 200) => constraints
```
#### Add offset
Each one of the three methods can be added a padding using the operators `+` and `-`:

```swift
// with a constant: adds an offset of 30 px in vertical and 30 px in horizontal
view.mkt.size = otherView.mkt.size + 30

// using UIOffset
view.mkt.size = anotherView.mkt.size + UIOffset(horizontal: 10, vertical: 20)
```

#### Multiply (or divide) by constant
Also, each one of the three methods can be multiplied or divided using the operators `*` and `/`:

```swift
// the size will be half width and height of the other view size
view.mkt.size = anotherView.mkt.size / 2

// the size will be the double of width and height of the other view size
view.mkt.size = anotherView.mkt.size * 2
```

## Edges

You can bind all the edges of a view to the edges of another view with a single instruction:

```swift
view.mkt.edges = otherView.mkt.edges
```

You can use four different types of edges:

```swift
// edges (left, right, top, bottom)
view.mkt.edges = otherView.mkt.edges

// edges relative to the view margins (left, right, top, bottom)
view.mkt.edges = otherView.mkt.margins

// edges using the interface layout direction (leading, trailing, top, bottom)
view.mkt.edges = otherView.mkt.layoutDirectionEdges

// margins using the interface layout direction (leading, trailing, top, bottom)
view.mkt.edges = otherView.mkt.layoutDirectionMargins
```

Note that on the left side of the expression you **always** use `edges`. The right side of the expression is which determines the type of edge used. 

Using the `=>` operator will return a array of `NSLayoutConstraint` with at most 4 elements, one per each edge used. 

```swift
var constraints: [NSLayoutConstraint]?
view.mkt.edges = view.mkt.super.edges => constraints
```

#### Excluding edges

You can exclude one (or more) edges. To do it, you must use the `-` operator with one or more cases of the `Edge` enumeration:

```swift
view.mkt.edges = otherView.mkt.edges - .top
view.mkt.edges = otherView.mkt.layoutDirectionMargins - .leading - .trailing
```

The possible values are:  `.left`, `.right`, `.leading`, `.trailing`,  `.top`,  `.bottom`.

#### Adding a padding
You can also add padding into the edges. You can do it with the `-` and `+` operators and with a constant or a `UIEdgeInset`:

```swift
// will add padding of 20 pixels on each edge
view.mkt.edges = otherView.mkt.edges - 20

// when using a layout direction edge, left would be treated as leading and right to trailing  
view.mkt.edges = otherView.mkt.layoutDirectionMargins - UIEdgeInsets(top: 10, left: 15, bottom: 20, right: 25)
```

## `super`
When you want to match some properties of a view to its superview, you can use the `super` property of `mkt`:

```
view.mkt.leading = view.mkt.super.leading

view.mkt.edges = view.mkt.super.margins - 16

view.mkt.size = view.mkt.super.size

view.mkt.center = view.mkt.super.center
```

`mkt.super` returns a non-optional object so, if at the moment of calling it the view has not been added to a super-view, it will throw a fatal error.

# Installation

Add the following to your `Podfile`:

````ruby
pod 'Maketa'
````

Then run `$ pod install`.

And finally, in the classes where you need **Maketa**: 

````swift
import Maketa
````

If you don’t have CocoaPods installed or integrated into your project, you can learn how to do so [here](http://cocoapods.org).

## License
Maketa is available under the [MIT license](LICENSE.md).

## Author
[Manuel García-Estañ Martínez](http://github.com/ManueGE)  
[@manueGE](https://twitter.com/ManueGE)
