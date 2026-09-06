#import "@preview/pigmentpedia:0.3.3": css, ral
#import "@preview/mannot:0.4.0": mark, markhl, markrect, markul
#import "@preview/physica:0.9.8": *
#import "@preview/zero:0.7.0": num, quan, zi
#import "@preview/meander:0.4.4": reflow
#import "@preview/zebraw:0.6.3": zebraw
#import "@preview/tiaoma:0.3.0"
#import "@preview/cetz:0.5.2"
#import "@preview/cetz:0.5.2": canvas
#import "@preview/fletcher:0.5.8": diagram
#import "@preview/zap:0.6.0"
#import "@preview/zap:0.6.0": circuit

#set page(
  width: 210mm,
  height: auto,
  margin: (x: 12mm, y: 14mm)
)

#set text(
  lang: "en",
  font: "EB Garamond",
  weight: 400,
  size: 12pt
)

#set par(spacing: 1em, justify: true)
#set enum(indent: 1em)
#set list(indent: 1em)

#show link: set text(fill: ral.classic.water-blue)
#show link: underline

#show heading.where(level: 1): set text(
  weight: 800,
  size: 20pt,
  fill: ral.classic.signal-black
)
#show heading.where(level: 2): set text(
  weight: 700,
  size: 17pt,
  fill: ral.classic.chestnut-brown
)
#show heading.where(level: 3): set text(
  weight: 640,
  size: 14pt,
  style: "italic",
  fill: ral.classic.ochre-brown
)

#show raw: set text(
  font: "Google Sans Code",
  weight: 300,
  size: 10pt
)
#show: zebraw.with(
  lang: false,
  inset: (left: 10pt),
  radius: 0pt
)

#show math.equation: set text(
  font: "STIX Two Math",
  size: 11pt
)

#set math.vec(
  delim: "[",
  gap: 0.7em
)
#set math.mat(
  delim: "[",
  align: right,
  row-gap: 0.7em,
  column-gap: 0.7em
)

#let dfrac(..sink) = math.display(math.frac(..sink))
#let vbu(symbol) = vb(math.upright(symbol))
#let vuu(symbol) = vu(math.upright(symbol))
#let vau(symbol) = va(math.upright(symbol))

#let nthin = h(-1/6 * 1em)
#let nmed = h(-2/9 * 1em)
#let nthick = h(-5/18 * 1em)
#let nhalf = h(-1/2 * 1em)
#let nquad = h(-1em)
#let nsequi = h(-3/2 * 1em)
#let nwide = h(-2em)
#let half = h(1/2 * 1em)
#let sequi = h(3/2 * 1em)

//

= Current-Limiting Resistor for 7-Segment Display

To determine an appropriate current-limiting resistor for the 7-segment display, we select a target of #quan[8 mA] passing through each segment when it is lit, so that it is within the provided constraints. We note a typical forward voltage is $V_F = #quan[2 V]$ from the datasheet, so the circuit for a single segment LED looks something like:

#{
  set align(center)
  show math.equation: set text(size: 10pt)
  circuit({
    import zap: *
    cetz.draw.set-style(zap: (variant: "ieee"))
    
    node("Vin", (0, 0), label: quan[3.3 V])
    resistor("R", "Vin", (4, 0), label: $R$)
    led("D", (4, 0), (4, -4), label: (content: $V_F = #quan[2 V]$, distance: 20pt))
    earth("Gnd", (4, -4))
  })
}

Using Ohm's law, the resistance must be:

$
  frac(#quan[3.3 V] - #quan[2 V], R) &= #quan[8 mA] \
  R &= #zi.ohm[162.5]
$

This is not a standard resistance value, so we will pick the closest value of #zi.ohm[150] instead. This results in a current draw of #quan[8.667 mA] instead, which is still within spec.

= LED Blink Frequency

_Note: the spec sheet indicates a target frequency of #quan[2 Hz] but the actual lab instructions say to target a frequency of #quan[2.4 Hz] instead. I will be using the latter._

The `HSOSC` module connects to an on-board high-frequency oscillator at #quan[48 MHz]. One period of the clock cycle is therefore #quan[20.833 ns]. We wish to blink the LED at #quan[2.4 Hz], which has a period of #quan[0.417 s].

My `clk_freq_divider` verilog module toggles the LED on/off each time its counter reaches the `MAXCOUNT` value. Thus, we should set `MAXCOUNT` so that the counter takes half of the desired period to overflow back to zero (and thus a single on/off cycle will sum to one whole period):

$
  #quan[20.833 ns] dot "count" &= #quan[0.417 s] / 2 \
  "count" &= 10000000
$

Thus, we will set `MAXCOUNT` to a value of $10000000$ to achieve the desired blinking frequency.