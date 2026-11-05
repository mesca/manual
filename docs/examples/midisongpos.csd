<CsoundSynthesizer>
<CsOptions>
-d -n -M0
</CsOptions>
<CsInstruments>
sr = 48000
ksmps = 32
nchnls = 1
0dbfs = 1

; Ignore MIDI notes. The score starts the position listener.
massign 0, 0

instr Listen
  kHeard, kPosition = midisongpos()
  if kHeard == 1 then
    printks("Song Position: sixteenth %d, quarter note %.2f\n", 0, kPosition, kPosition / 4)
  endif
endin
</CsInstruments>
<CsScore>
i "Listen" 0 60
</CsScore>
</CsoundSynthesizer>
