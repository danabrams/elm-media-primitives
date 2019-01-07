# elm-media-primitives
A set of media API primitives that require kernel code.

This is a currently private repository for laying out an API for an Elm Exploration between me and Evan (and anyone else who might be relevant) for the beginnings of coverage of the HTML5 Media API.

## Justification 
The HTML5 Media API is one of the most important APIs on the web. It was one of the headline features when HTML5 was first released a decade ago, and it's success has meant the death of Adobe Flash as a web standard (Indeed, this API was extolled extensively in Steve Jobs's famous letter).

Currently, the basics of the Media API are usable in elm with ports, but many of the most basic functions would be much better realized as tasks, since they return error information and are mostly synchronous.

Additionally, handful of basical playback functionalities are difficult or impossible to achieve in a nice way in Elm through ports.

## Challenges

The hardest problem is state management. In Html5, media players manage their own state. Mozilla briefly experimented with letting developers manage the most challenging parts of this state by providing their own time code, but this never materialized beyond an experiment.

The approach I've followed, in consultation with Evan, is to have the user query the current state of the media element as frequently as they need to, be it every frame (for frame accuracy) or merely every second in more reasonable circumstances.

## Current Status

This is just a layout of the API. I hope to make it easy and painless for Evan to review and to fill it out myself autonomously.

## Other Media APIs

To a certain extent, this is a drop in the bucket, only providing an interface to playback and state management. Hopefully, once this is sorted, Evan will indulge me in expaning this exploration to cover other aspects of the Media API, including Media Source Extensions (the API most relevant to my work), Web Audio (The one that would probably have the biggest impact on the larger Elm community, especially game developers), and Media Stream Capture (Just awesome).

But all of those APIs rely on this basic work, and offer different challenges.
