---
title: byting music
---

You may not know it from reading this blog, but I actually spend a lot more time on music
than I do on code. Although I [play electronic music on a computer][wb] and most of my musical
endeavors are centered around computers, I've always felt like my two great loves, programming
and music, were disconnected. These days, I don't feel that way anymore.

I'm working on a project right now that involves the live mixing of two audio sources, down to
their bytes, and then this mix is streamed to an Icecast server. These two audio sources are both
MP3 files, but they are chosen in a programmatic way, and the music must never stop. So there must
be a constant stream of audio data being pumped to the Icecast server, and this data must have the
ability to be changed programatically, using user-generated content.

## the whole kit and kaboodle

So we're looking at a pretty complicated class hierarchy for such a simple task. We'll need the
following components:

- A `Track`, which simply adds some metadata to a filename pointer on the system. This class
  points to a filename and reads its contents, much like a regular `File`, but 

## sockets are just like files

In order to do this effectively, I will need to use [UNIX Sockets][sock] to make an asychronous
connection between the two classes. One class, the `Deck`, will write file data to the socket. The
other class, a `Source`, will read whatever data is on the socket out to the Icecast stream. The
`Deck` is of course performing the actual file reading and writing of this whole operation, it
uses several `Crates` to store track data. `Crate` is another class, responsible for obtaining 
and storing (in memory) the tracks that need to be played through the `Deck`.

## the loudness war

Another problem that comes up is how to deal with different levels of volume.
