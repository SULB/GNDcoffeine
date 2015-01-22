# GNDcoffeine
GNDcoffeine is a GND search tool for submit forms of open access repositories (here OPUS 3). It is full accessible by using ARIA fields

## OPUS 3.X

Include jQuery, then the translation for GNDcoffeine (de.js or en.js) GNDcoffeine itself and css for it in header of html in OPUS 3.

```html
	<!-- xGND --> 
	<script src="/sulb/GNDcoffeine/src/de.js"></script>
	<script src="/sulb/GNDcoffeine/src/GND.js"></script>
	<link href="/sulb/GNDcoffeine/src/GNDstyle.css" rel="stylesheet" media="screen"/>
	<!-- ENDE xGND -->
```

It works out of the box.

## Other systems

Same procedure like by OPUS with any modifications in source files.

Change value of swdId in translations to an id of input field. 

```js
  swdId = '#subject_swd';
```

It will be not disabled by default. To do it, use css with given id. Here:

```css
  #subject_swd { display: none;}
```

## About

This work is a little bit cryptic ;-) There is no documentation - like in the original XGND (from SWB). 
It is a try to make XGND more usable (usability, accessibility) and a part of the submit form.

You use XGND backend calls and GND data from SWB. Please respect they cpyrights and usage terms.
