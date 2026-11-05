<!--
id:midisongpos
category:Real-time MIDI:System Realtime
-->
# midisongpos
Reports incoming MIDI Song Position Pointer messages at control rate.

Use `midisongpos` to follow where an external sequencer moves its playhead, so that a sequence can go on from the same place at the next Continue. Enable MIDI input with `-M` and enable song position output on the sending device. The opcode takes no arguments.

## Syntax

=== "Modern"
    ``` csound-orc
    kheard, kposition = midisongpos()
    ```

=== "Classic"
    ``` csound-orc
    kheard, kposition midisongpos
    ```

### Performance

`kheard` is 1 when Csound receives a Song Position Pointer for the current control cycle, and 0 otherwise. Song Position Pointer uses status byte `0xF2` and two data bytes, the least significant first. It has no channel number, so the opcode has no channel filter.

`kposition` is the position the last Song Position Pointer gave, in MIDI beats: sixteenth notes, six Timing Clock pulses each, from 0 at the start of the song up to 16383. It is 0 until a Song Position Pointer arrives, and keeps its value until the next one, or until a MIDI Start, which plays from the top and puts it back to 0. Divide it by 4 for quarter notes, or multiply it by 6 for clock pulses.

Each call reads the same values without consuming them, so several instruments can respond to the same message. Several messages received in one control cycle produce a single 1, and `kposition` is the last one's.

A sequencer sends Song Position Pointer while it is stopped, usually just before a Continue: the first Timing Clock after the Continue is the position given. A Start always plays from position 0. `midisongpos` only reports the position. It does not move the score or a sequence for you.

Song Position Pointer is a System Common message, not a System Realtime one. Under port mapping (`-M m`), it carries no port: one from any device is read the same.

## Examples

The example prints each position a sequencer sends, in sixteenths and in quarter notes. Move the sequencer's playhead while it is stopped to send one.

Change `-M0` to select your MIDI input device. The example listens for one minute.

It uses [midisongpos.csd](../examples/midisongpos.csd).

``` csound-csd title="Print the song position a MIDI sequencer sends" linenums="1"
--8<-- "examples/midisongpos.csd"
```

## See also

[midiclockin](midiclockin.md), [midistart](midistart.md), [midicontinue](midicontinue.md), [midistop](midistop.md), [System realtime messages](../midi/realtime.md), [MIDI input](../midi/input.md)

## Credits

Author mesca, 2026.

New in Csound 7.
