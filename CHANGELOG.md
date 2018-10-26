# Changelog

### 2.0.1 (26 October 2018)
- Fix bug where `translatesAutoresizingMaskIntoConstraints` is set to false in views that didn't have it enabled before. 

From now, if you have this expresion:

```
aView.mkt.left = otherView.mkt.left
```

Autolayout will be only activated in `aView`, but `otherView` will remain as it was.

### 2.0.0 (25 September 2018)
- Swift 4.2 

### 1.1.1 (19 August 2018)
- Change the precedence of `=>` operator to decrease parenthesis when using it.

### 1.1.0 (18 August 2018)
- `=>` can't be used with `[NSLayoutConstraint]` anymore; now it must be used with `CenterConstraints`, `SizeConstraints` or `EdgesConstraints`.
- Added `centerWithinMargins` property.

### 1.0.0 (17 August 2018)
- Initial version.
