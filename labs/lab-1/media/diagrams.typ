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
  margin: 8mm
)

#set text(
  lang: "en",
  font: "EB Garamond",
  weight: 400,
  size: 10pt
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
  size: 9pt
)
#show: zebraw.with(
  lang: false,
  inset: (left: 10pt),
  radius: 0pt
)

#show math.equation: set text(
  font: "STIX Two Math",
  size: 10pt
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

#{
  set align(center)
  circuit({
    import zap: *
    cetz.draw.set-style(zap: (variant: "ieee"))

    mcu("upduino", (0, 0), pins: (
      (content: [P13 / `seven_segment_leds[6]`], side: "west"),
      (content: [P12 / `seven_segment_leds[5]`], side: "west"),
      (content: [P3 / `seven_segment_leds[4]`], side: "west"),
      (content: [P44 / `seven_segment_leds[3]`], side: "west"),
      (content: [P9 / `seven_segment_leds[2]`], side: "west"),
      (content: [P18 / `seven_segment_leds[1]`], side: "west"),
      (content: [P20 / `seven_segment_leds[0]`], side: "west")
    ), fill: none, stroke: 1pt, width: 7, spacing: 1.5, label: "Upduino v3.1")

    for n in range(7) {
      cetz.draw.move-to((project: "upduino.pin" + str(n + 1), onto: ((-12, 4), (-12, 0))))
      resistor("R" + str(6 - n), (), (rel: (5, 0)),
        n: if (n != 6) {"*-"} else {none}, label: zi.ohm[150])
      diode("D" + str(6 - n), (), "upduino.pin" + str(n + 1), position: 30%,
        label: ("A", "B", "C", "D", "E", "F", "G").at(n))
    }

    vcc("Vcc", (-12, 6), label: quan[3.3 V])
    wire("Vcc", "R0.in")
  })
}