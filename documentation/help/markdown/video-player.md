---
title: How to use the Feathers VideoPlayer component  
author: Josh Tynjala

---
# How to use the Feathers `VideoPlayer` component

The [`VideoPlayer`](../api-reference/feathers/media/VideoPlayer.html) class provides video playback capabilities using a `flash.net.NetStream` object. Video files may be loaded from a URL and displayed as a Starling texture. [Media player controls](media-player-controls.html) may be added as children to display information such as the current time or to control playback by seeking or pausing the audio. `VideoPlayer` is a subclass of [`LayoutGroup`](layout-group.html), so its children may be positioned and sized using layouts.

## The Basics

First, let's create a `VideoPlayer` component, set its dimensions, and add it to the display list:

``` code
var player:VideoPlayer = new VideoPlayer();
player.setSize( 320, 300 );
this.addChild( player );
```

To play a video file, pass the URL to the [`videoSource`](../api-reference/feathers/media/VideoPlayer.html#videoSource) property:

``` code
player.videoSource = "http://example.com/video.m4v";
```

To display the video, we need to add an [`ImageLoader`](image-loader.html) as a child of the `VideoPlayer`:

``` code
var loader:ImageLoader = new ImageLoader();
player.addChild( loader );
```

Notice that we have not set the [`source`](../api-reference/feathers/controls/ImageLoader.html#source) property of the `ImageLoader` yet. A video texture requires a moment to initialize on the GPU before it may be rendered by Starling. The `VideoPlayer` will dispatch [`Event.READY`](../api-reference/feathers/media/VideoPlayer.html#event:ready) once we can pass the texture to the `ImageLoader`:

``` code
function videoPlayer_readyHandler( event:Event ):void
{
	loader.source = player.texture;
}
player.addEventListener( Event.READY, videoPlayer_readyHandler );
```

The video texture may be accessed throught the [`texture`](../api-reference/feathers/media/VideoPlayer.html#texture) property. Until `Event.READY` is dispatched, the `texture` property of the `VideoPlayer` will be `null`.

## Adding Controls

Let's give the `VideoPlayer` some controls. First, let's create a [`LayoutGroup`](layout-group.html) to use as a toolbar for our controls:

``` code
var controls:LayoutGroup = new LayoutGroup();
controls.styleNameList.add( LayoutGroup.ALTERNATE_STYLE_NAME_TOOLBAR );
player.addChild(controls);
```

With the toolbar in place, let's add a [`PlayPauseToggleButton`](../api-reference/feathers/media/PlayPauseToggleButton.html) and a [`SeekSlider`](../api-reference/feathers/media/SeekSlider.html). It's as simple as adding them as children of the tool bar:

``` code
var button:PlayPauseToggleButton = new PlayPauseToggleButton();
controls.addChild( button );

var slider:SeekSlider = new SeekSlider();
controls.addChild( slider );
```

There's no need to add event listeners for these controls. You simply need to add them as children of the `VideoPlayer` (or a container that has been added as a child of the `VideoPlayer`), and everything will be set up automatically.

<aside class="info">The complete list of [media player controls](media-player-controls.html) includes several more pre-built components that you can add to a `VideoPlayer`.</aside>

In the next section, we'll position everything with some layouts.

## Layout

First, let's create a layout for the toolbar with our controls. We'll pass a [`HorizontalLayout`](../api-reference/feathers/layout/HorizontalLayout.html) to the [`layout`](../api-reference/feathers/controls/LayoutGroup.html#layout) property:

``` code
var layout:HorizontalLayout = new HorizontalLayout();
layout.gap = 10;
controls.layout = layout;
```

Here, we've set the [`gap`](../api-reference/feathers/layout/HorizontalLayout.html#gap) property, but `HorizontalLayout` provides many more useful features, including padding and alignment. See [How to use `HorizontalLayout` with Feathers containers](horizontal-layout.html) for complete details.

If we want our `SeekSlider` to stretch to fill as much space as possible within the `VideoPlayer`, we can pass in [`HorizontalLayoutData`](../api-reference/feathers/layout/HorizontalLayoutData.html):

``` code
var sliderLayoutData:HorizontalLayoutData = new HorizontalLayoutData();
sliderLayoutData.percentWidth = 100;
slider.layoutData = sliderLayoutData;
```

Now, because we set the [`percentWidth`](../api-reference/feathers/layout/HorizontalLayoutData.html#percentWidth) property, when the width of the toolbar changes, the width of the `SeekSlider` will change too.

Next, we want to position the toolbar and the `ImageLoader`. Let's use a `VerticalLayout` for that.

``` code
player.layout = new VerticalLayout();
```

We want the `ImageLoader` to fill as much space as possible.

``` code
var loaderLayoutData:VerticalLayoutData = new VerticalLayoutData();
loaderLayoutData.percentWidth = 100;
loaderLayoutData.percentHeight = 100;
loader.layoutData = loaderLayoutData;
```

Then, we want the toolbar to fill the entire width of the `VideoPlayer`:

``` code
var controlsLayoutData:VerticalLayoutData();
controlsLayoutData.percentWidth = 100;
controls.layoutData = controlsLayoutData;
```

## Controlling playback programmatically

By default, the `VideoPlayer` will automatically start playing its `videoSource`. We can use the [`autoPlay`](../api-reference/feathers/media/VideoPlayer.html#autoPlay) property to change this behavior:

``` code
player.autoPlay = false;
```

If `autoPlay` is set to `false`, we can call `play()` to begin playback manually:

``` code
player.play();
```

To pause, we can call `pause()` to pause playback at the current position:

``` code
player.pause();
```

The `togglePlayPause()` method may be called to toggle between the play and pause states:

``` code
player.togglePlayPause();
```

To stop playback and return the video to the beginning, we may call `stop()`:

``` code
player.stop();
```

The `seek()` function may be called to change the current time:

``` code
player.seek( 5.0 );
```

The time is measured in seconds.

To change the volume, we can pass a [`flash.media.SoundTransform`](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/media/SoundTransform.html) object to the [`soundTransform`](../api-reference/feathers/media/VideoPlayer.html#soundTransform) property:

``` code
player.soundTransform = new SoundTransform( 0.5 );
```

The `toggleFullScreen()` function will toggle between normal and full screen modes:

``` code
player.toggleFullScreen();
```

When the `VideoPlayer` is displayed in full screen mode, it will be added as a modal pop-up above all Starling content.

## Skinning a `VideoPlayer`

As mentioned above, `VideoPlayer` is a subclass of `LayoutGroup`. For more detailed information about the skinning options available to `VideoPlayer`, see [How to use the Feathers `LayoutGroup` component](layout-group.html).

### Targeting a `VideoPlayer` in a theme

If you are creating a [theme](themes.html), you can set a function for the default styles like this:

``` code
getStyleProviderForClass( VideoPlayer ).defaultStyleFunction = setVideoPlayerStyles;
```

If you want to customize a specific video player to look different than the default, you may use a custom style name to call a different function:

``` code
player.styleNameList.add( "custom-video-player" );
```

You can set the function for the custom style name like this:

``` code
getStyleProviderForClass( VideoPlayer )
    .setFunctionForStyleName( "custom-video-player", setCustomVideoPlayerStyles );
```

Trying to change the video player's styles and skins outside of the theme may result in the theme overriding the properties, if you set them before the video player was added to the stage and initialized. Learn to [extend an existing theme](extending-themes.html) to add custom skins.

If you aren't using a theme, then you may set any of the video player's properties directly.

## Related Links

-   [`feathers.media.VideoPlayer` API Documentation](../api-reference/feathers/media/VideoPlayer.html)