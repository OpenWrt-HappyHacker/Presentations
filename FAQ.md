Frquently Asked Questions
=========================

* Is this ready to use? Can I Hack the Planet with this?

Short answer: not yet.

Currently we have a functional build system, but the firmware images still need a little bit of retouching. Also, as it is now you have to recompile everything each time you generate a new image and that's inefficient.

Our plans for the near future are: fix a few things in OpenWrt that don't quite work the way we want it to, cache precompiled code so we only need to compile once to generate multiple firmware images, and upload our own precompiled images for the lazy to just download and flash.

* Where do I get those gadgets?

Here is a handy link to DealExtreme. This is the cheapest one we found, most other sites sell you the Zsun at a much higher price (sometimes double!).

  http://www.dx.com/p/zsun-wi-fi-usb-2-0-card-reader-for-tablet-pc-ipad-iphone-android-mobile-phone-black-379018

* How do I flash a new firmware image?

We are preparing a complete tutorial to be uploaded here, but in the meantime do check out the instructions from the Warsaw Hackerspace

  https://wiki.hackerspace.pl/projects:zsun-wifi-card-reader:factory-update

* I tried compiling but it says compilation failed. What gives?

Most of the times, when compilation fails it's because OpenWrt downloads a lot of crap off the Internet during the build. Some of that stuff is hosted in Sourceforge and other less-than-ideal sites, so downloads frequently fail. We are working on a fix for that, possibly by pre-downloading everything and creating a local cache.

The second most common reason for builds to fail is if you modified the configuration to give the build system less than 4 Gb of RAM, or if you are creating your own custom image (in which case, if you select too many OpenWrt packages you may run out of space in ROM). The second problem will be fixed in the near future, we want to make OpenWrt boot from the MiccroSD card directly instead of using ROM.

In the event of any other problems compiling the code, let us know! Open a new issue in Github or email us at: crapula@alligatorcon.pl

* Can this thing be used by Bad People?

Probably. But as with any other privacy oriented technology, we believe the potential for good, as for example evading censorship in repressive regimes and aiding whistleblowers, outweighs the risks. Also, the baddies don't generally need help from us - they are well funded and very motivated to come up with their own systems anyway.

* How can this be used legally in my country?

We are not lawyers. Better ask one instead of us! We only take care of the technical aspects of this research project, and we give no guarantees of any kind.

Be smart, don't be reckless, find out what you can and cannot do before having fun! ;)

And remember, no technical solution will ever replace good OPSEC.
