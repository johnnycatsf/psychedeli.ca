---

title: "all up in yo boxee"
category: hardware
tags: "boxee, windows, freenas, netflix, TV"
date: 2011-06-19 

---


Now that FreeNAS has been updated to version 8 and everything is back to normal (well, I actually had to create a "jail" to run some 3rd-party apps...more on that junk later...), and my S-Video Out video card has been acquired, I'm now ready for the task of converting my Cable TV-based living room into a fully connected media center, complete with a BitTorrent-based automatic PVR and seedbox, DAAP/iTunes Library exposition on the local network, Netflix connect-ability, and a system that manages all of it through a standard definition television screen and a dead-simple remote control.

There is no alternative. Boxee for Windows 7 is the only choice.

# why all the trouble, can't you just get a boxee box?

To be honest with you, I don't like TV very much. It allows me to be complacent and not get as much work done as I should be. Therefore, I don't believe it's quite the best thing for me to be sitting in front of, and I certainly don't enjoy paying for it. Unfortunately, the Boxee Box doesn't allow standard inputs, forcing anyone who wants the "easy solution" to purchase one. I own a standard definition TV with S-Video in. I'm not going to go out and pay at least $350 for something I don't even want to use. Instead, I'm going to spend an eighth of that money (on a video card) to build a computer that allows me to use a TV to take the focus off TV in the living room.

# ok. so. what does it do?

I set out to build a system that everyone in the house could enjoy, because it would be built to their specifications. We came to an agreement and laid out a number of features the HTPC setup had to match:

1. **DAAP:** It had to be able to read iTunes libraries. This not only enables the Boxee to play music from our NAS using the big speakers in the living room, but also enables it to play music from anyone else that comes over (who has iTunes/DAAP, of course).

2. **Video On Demand:** It had to be connectable to Netflix, as that is the streaming service Mary already pays for. Netflix also has the largest selection of on-demand video and DVD rentals, of course. Because Netflix runs on Silverlight, and Silverlight isn't available for Linux, this is basically the reason why I have to run Boxee on a Windows 7 PC.

3. **Set-And-Forget PVR:** The only hacker in this house is me. That is, I'm the only guy who likes tinkering around with shit as well as experiencing the media that I can obtain through these methods. So basically, 

# the tools

- FreeNAS 8 (as explained in the last post)
- A PC running Windows 7 with an S-Video Out card
- Boxee for Windows 7
- Sick Beard, a PVR that watches BitTorrent sites for new episodes of the shows you want to watch