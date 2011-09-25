---

layout: post
title: "Let's get FreeNASty up in here"
category: diy
tags: #freenas, #freebsd, entertainment, #hacking, #python
date: 2011-05-22

---

Alright, it's finally time! After a long wait and some hardware hangups, I've finally completed the build of [a media fileserver and seedbox](http://psychedeli.ca/2011/04/09/decisions-decisions) for the residents of my house. I've installed [FreeNAS 8](http://freenas.org) as the operating system on a gifted Dell OptiPlex GX280 small form-factor computer, which operates as both a central place to store music and movies we (as a household) consume, but also as an always-running [BitTorrent seedbox](http://transmissionbt.com), [iTunes media library](http://fireflymediaserver.org), and [backup drive](http://www.apple.com/macosx/what-is-macosx/time-machine.html). This article isn't quite a how-to guide, more like an encouragement to go out and do the same. It wasn't very hard, especially because I had a pre-built box (basically) and had a decent knowledge of UNIX-based operating systems, especially FreeBSD!

## what and why

### the genesis of it all
FreeBSD is one of my favorite operating systems, actually. When I asked a geek I was friends with what Linux distro I should choose in order to "learn UNIX", he said "not Linux". I hadn't yet understood the difference. He explained that, while Linux is a really great kernel and the OS products that have popped up using the kernel are quite robust and superior to most other operating systems, they do have a tendency to depart from the original UNIX operating system in a lot of (possibly less confusing and more communally-driven) ways. Other operating systems exist which are closer to how UNIX works (or used to work), and that is around the time he introduced me to his favorite operating system, FreeBSD. Around the time of high school, I installed it, and immediately became frustrated as I couldn't get it on the network. Weeks passed and I continued toying with it, but I felt a bit limited without internet access. Ended up having to install Windows XP on the machine again, and conceded defeat. I failed in installing my first UNIX-based operating system, my first OS install outside of a Windows environment, actually. However, a few tries later, I got the thing working. Of course, this time I had another Windows box set up so I could ask questions and peruse the docs when I started working with it. I encourage anyone installing a UNIX-based operating system to follow this method, and always have the ability to ask questions using some kind of internet connection.

So I understand that sounds, how can I put this lightly, a little **biased**. But stay with me, FreeBSD is quite a powerful operating system, although it may not be for the faintest of heart...

FreeBSD is based on [4.4BSD](http://en.wikipedia.org/wiki/Berkeley_Software_Distribution#4.4BSD_and_descendants), a [direct descendant of UNIX](http://en.wikipedia.org/wiki/Berkeley_Software_Distribution#PDP-11_beginnings) developed at [UC Berkeley](http://berkeley.edu/) (BSD is an acronym for "Berkeley Software Distribution"). 4.4BSD and FreeBSD's process model and networking stack also helped to influence Apple's [Darwin](http://opensource.apple.com/) OS, which powers Mac OS X. As a Mac user, I felt much more familiar with the operating system when I downloaded FreeNAS, the OS that I'm actually using to power my fileserver.

[FreeNAS](http://freenas.org) is mostly FreeBSD, with some added features (like an integrated web management GUI) and bundled with commonly installed software like [Transmission](http://transmissionbt.com/), [Samba](http://samba.org), [Netatalk](http://netatalk.sourceforge.net), and [FireFly](http://fireflymediaserver.net/). It's also (almost) just as light, and since it's based off FreeBSD 8.2-RELEASE, it too supports the [Zettabyte File System (or ZFS)](http://en.wikipedia.org/wiki/ZFS), perhaps the most powerful filesystem mechanism on the planet.

### the most powerful filesystem on the planet

ZFS was developed at [Sun Microsystems](http://sun.com) to address the typical problems of traditional filesystem technology. I call ZFS the "defensive" filesystem, at it was designed from the ground up to protect file integrity and the user's data from "silent corruption", a very possible scenario in which some (or all) of the data on a hard disk can suddenly and without warning become corrupt, unusable or somehow damaged. The reasonings behind this go all the way from phenomena such as [bit rot](http://en.wikipedia.org/wiki/Bit_rot), random cosmic radiation or just general degradation of the hardware over time. ZFS solves this problem in two ways: by first creating a filesystem strategy that inherently protects against this corruption, and secondly creating a system whereby it can maintain two mirrored hard drives on the software level (a software RAID). By doing so, ZFS not only keeps all of your data redundant on two separate drives, it consistently checks to see if your data has become corrupt, and attempts to correct such errors as they happen, instead of waiting for the user to go ahead and `fsck` it.

But it gets better. ZFS isn't just built with data integrity in mind, it also provides a number of improvements over traditional filesystems in terms of speed and efficiency. ZFS evolved over time as the main filesystem for Sun's [Solaris](http://en.wikipedia.org/wiki/Solaris_10) operating system, another fast and powerful UNIX derivative which is known for its robust architecture, especially in the use case of a heavy-duty data and virtualization server. We actually use an eight-core workhorse with over 4TB of redundant storage (via RAID-Z) running Solaris 10 at [my job](http://aplusldesign.com) for running backups, a fileserver and all of our virtual machines that we test websites on. In the process of building and designing this new VM server, my boss made note of all the wonderful features of ZFS, which is how I learned about it, and which is what ultimately led me back into the world of FreeBSD.

The best part about ZFS, in my opinion, is deduplification. Deduplification (or de-dupeing) is the process by which ZFS periodically checks the entire filesystem for duplicates of files, and replaces such duplicates with hard links to the original files. This in turn saves a ton of hard drive space, and is really helpful for a NAS that is mostly made up of duplicate files.

So the choice has been made. I decided to install FreeNAS 8 on my server, and attempt to get deduplification working.

## how do you do it?

### what you'll need

- A box for your FreeNAS server
- A keyboard for entering in commands. It can be yanked from another machine, you won't be needing it after network setup.
- Patience.
- Possibly marijuana. 

### start with the parts

Somehow, obtain a box. I chose a [Dell OptiPlex GX280](http://dell.com) because, well, it was free. But I encourage you to use a case that is more fit for server storage. Try to get something that can hold a lot of big magnetic disks, and isn't too expensive. Your motherboard should obviously be able to handle SATA, but apart from having a decent processor that's really all you need. We're building a NAS here, which stands for **network-addressed storage**. It's meant to basically be a portal to a bunch of hard drive space, which is then accessed over the LAN in various ways. Since I'm not anticipating much concurrent usage, I don't feel the need to push the limits on processing power or RAM for now, but if you anticipate a lot of people accessing or being on the machine at one time, I suggest you amp up your computing abilities with extra RAM or a better processor/motherboard. 

My server, however, is a Dell from a LONG time ago. How long ago? My **middle school** replaced the old COMPAQs with these things after everyone hated them, and they continued to be the school's main computers until I graduated high school. I do not know what they're using now. This relic of a simpler time dates back to when floppy drives were actually still in use, evidenced by the fact that, well, this computer has one. It also only has one hard drive slot. Bad news, since ZFS mirroring requires 2 of them! The good news is a floppy drive is the same size as the bracket for a 3.5" HD, so I simply fit my other 1TB into that slot and hooked them both up! After installing a RAID card so the motherboard could handle two SATA hard drives, I powered on the machine and it booted into BIOS. So far, so good...

### install the software

Installing FreeNAS to a pen drive is simple, [it can be done on your normal workstation computer](http://doc.freenas.org/index.php/Installing_from_the_Image) or [from a CD-ROM drive](http://doc.freenas.org/index.php/Using_the_ISO). I chose the former since I had to disconnect my CD-ROM on the OptiPlex, needed its power cable to power my second hard drive, and because I feel that it's easier and doesn't waste removable media...

I actually already installed this OS at version 0.7.2 to the pen drive, but since the upgrade to 8 is essentially a big rewrite, I'm going to just reinstall 8 on the pen drive and remove the former installation. This, of course, doesn't at all affect my hard drives (which haven't even been written to, but they still would not affect the data on those disks if they had any data on them). I used [Keka](http://kekaosx.com) for Mac OS X to unpack the *.xz file and place its contents (the image) on my Desktop. Then, I plugged my USB drive into the computer, found its name using `diskutil list`, and used the following command to mount the image to the USB drive (replace the value of `of=` with the name of your USB drive):

`dd if=FreeNAS-8.0-RELEASE-i386.Full_Install of=/dev/disk8 bs=5k`

Then, simply set your BIOS to boot from USB (in the Dell Setup Utility, press F2 when you see the boot logo), FreeNAS will vomit a bunch of text on the screen, and eventually give you a boot menu. You can just hit 1 or wait until the timer goes out for it to boot normally. You will then be presented with another menu. Stop. Do what this menu says. ;)

The menu will help you get your device on the network. Press 1, "Assign Interfaces". You'll be presented with a blue screen, which you can then either auto-detect or manually set the LAN interface you wish to use. Make sure you're plugged in to a port on the router (I would not recommend using a Wi-Fi interface in this particular use case) and hit "Ok". It will say "Initializing interface... please wait...", so go pack a bowl or something. 

If nothing else but that line came up, congratulations, it's been set up properly! Go ahead and hit 2, "Set LAN IP Address". You will be asked a number of configuration questions. When the DHCP question pops up, choose "Yes". When the IPv6 question pops up, choose "No". Give it a minute. Smoke a hit off that bowl, or take a sip of coffee, I don't know, whatever floats your boat.

You should then be presented with something like "Current IP Address: http://192.168.1.10x:80" and a big message about your current networking capabilities. If you get anything different, or this field is blank or the IP address is 0.0.0.0, something went wrong. You might want to ask on [#freenas](irc://irc.freenode.net/freenas) or [#freebsd](irc://irc.freenode.net/freebsd) if they support your LAN card drivers...

Now that it's all set up, go and try it out! Enter that computer's IP address into your browser and if you get a login screen, congratulations...it worked! Your username and password is **"admin" / "freenas"**, by default, so you might want to change that. More information on how to set up FreeNAS for yourself can be found on the [documentation](http://doc.freenas.org/index.php/Main_Page), which includes a full install guide.

## breaking it down 

`garage`, my file server, was designed for media storage and torrenting, primarily. So it has a single ZFS pool called Atlantis with two inner datasets. These are basically directories and split up as "drives" for the purpose of easy sharing on SMB/AFP. Users will be able to mount either one of these datasets (or both) depending on what they are planning to move off or move onto the pool.

I've chosen all of my hard drive names after musicians I respected. My laptop hard drive is named "Coltrane", and my studio machine is named "Miles". 

### Zappa, the media collection
The first drive, Zappa, is 250GB allotted for a centralized music library, movie archive and general media storage. It will be accessible via Samba (for our lone Windows 7 user) and Netatalk (for the rest of the computers running Mac OS X), as well as DAAP via the FireFly Media Server, so we can actually listen to the music on the shared drive on our own respective PCs. When I build it, this drive will also be the main media storage unit for our [Boxee](http://boxee.tv).

### Edgard, the seedbox
Edgard (named after [Edgard Varèse](http://en.wikipedia.org/wiki/Edgard_Var%C3%A8se)), is the drive that stores all of the BitTorrent content on the NAS. It's only 500GB, but that may change if we add more hard drive space. Regardless, this share should always be much larger than the music share.

### Dizzy, a backup of Miles
A 250GB Time Machine backup all of my music work, which is all backed up to a centralized [Git](http://git-scm.com) repository, but also some other stuff like my huge sample library.

### Parker, a future backup of Coltrane
This will be a Time Machine backup of my laptop, including my Ableton Live sets, personal programming work, and personal electronic documents. Once I get more space...

## up and running

So my FreeNAS box is in fact up and running, however I had to temporarily take it down recently to replace the aging thermal paste on my heatsink, which I cleaned today to reduce fan noise. So as soon as I can reapply some thermal paste (tomorrow), it should be good to go. I'll be posting more about how to properly administer a server like this, as well as a guide to building a standard-definition HTPC, because I'm just too cheap to buy an HDTV and I hate cable!
