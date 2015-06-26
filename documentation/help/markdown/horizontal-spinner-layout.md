---
title: Using HorizontalSpinnerLayout in the Feathers SpinnerList component  
author: Josh Tynjala

---
# Using `HorizontalSpinnerLayout` in the Feathers `SpinnerList` component

The [`HorizontalSpinnerLayout`](../api-reference/feathers/layout/HorizontalSpinnerLayout.html) class may be used by the [`SpinnerList`](spinner-list.html) component to display items from left to right in a single row, repeating items infinitely if the number of items in the data provider allows for it. It supports a number of useful options for adjusting the spacing and alignment.

## The Basics

First, let's create a `HorizontalSpinnerLayout` and pass it to a [`SpinnerList`](spinner-list.html):

``` code
var layout:HorizontalSpinnerLayout = new HorizontalSpinnerLayout();
 
var list:SpinnerList = new SpinnerList();
list.layout = layout;
this.addChild( list );
```

There are a number of simple properties that may be used to affect the layout. The most common are padding and gap.

The *padding* is the space around the content that the layout positions and sizes. You may set padding on the left and right sides of the container separately. Below, we set the [`paddingLeft`](../api-reference/feathers/layout/HorizontalSpinnerLayout.html#paddingLeft) to `10` pixels and the [`paddingRight`](../api-reference/feathers/layout/HorizontalSpinnerLayout.html#paddingRight) to `15` pixels:

``` code
layout.paddingRight = 15;
layout.paddingLeft = 10;
```

The *gap* is the space between items. Let's set the [`gap`](../api-reference/feathers/layout/HorizontalSpinnerLayout.html#gap) property to `5` pixels:

``` code
layout.gap = 5;
```

We can *align* the items in the layout using the [`verticalAlign`](../api-reference/feathers/layout/HorizontalSpinnerLayout.html#verticalAlign) property. Let's adjust it so that the content will be aligned to the center:

``` code
layout.verticalAlign = HorizontalSpinnerLayout.VERTICAL_ALIGN_CENTER;
```

## Virtual Horizontal Spinner Layout

In a [`SpinnerList`](list.html), the layout may be *virtualized*, meaning that some items in the layout will not actually exist if they are not visible. This helps to improve performance of a scrolling list because only a limited number of item renderers will be created at any given moment. If the list's data provider is very large, a virtual layout is essential, even on desktop computers that have incredible processing power compared to mobile devices.

A virtualized layout will need as estimate about how big a "virtual" item renderer should be. You should set the [`typicalItem`](../api-reference/feathers/controls/List.html#typicalItem) property of the list to have it determine the *typical* width and height of an item renderer to use as this estimated value. If you don't pass in a typical item, the first item in the data provider is used for this estimate.

By default [`useVirtualLayout`](../api-reference/feathers/layout/HorizontalSpinnerLayout.html#useVirtualLayout) is `true` for containers that support it. You may disable virtual layouts by setting it to `false`. When a layout is not virtualized, every single item renderer must be created by the component. If a list has thousands of items, this means that thousands of item renderers need to be created. This can lead to significant performance issues, especially on mobile. In general, you should rarely disable `useVirtualLayout`.

``` code
layout.useVirtualLayout = false;
```

## Related Links

-   [`feathers.layout.HorizontalSpinnerLayout` API Documentation](../api-reference/feathers/layout/HorizontalSpinnerLayout.html)