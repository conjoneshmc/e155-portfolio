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
  width: 150mm,
  height: auto,
  margin: 4mm
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

$
  frac(V_"CC" - V_"BE", R_s) &= #quan[5 mA] \
  frac(#quan[3.3 V] - #quan[0.95 V], R_s) &= #quan[5 mA] \
  R_s &= #zi.ohm[470]
$

$
  7 dot frac(V_"CC" - V_"CE" - V_(nhalf F), R_L) &= #quan[50 mA] \
  R_L &= #zi.ohm[126]
$

#pagebreak()

$
  f_"clk" / f_"multiplex" &= "MAXCOUNT" \
  #quan[24 MHz] / #quan[120 Hz] &= 200000
$

#pagebreak()

$
  frac(V_"CC" - V_"BE", R_s) &= #quan[1 mA] \
  frac(#quan[3.3 V] - #quan[0.85 V], R_s) &= #quan[1 mA] \
  R_s &= #zi.kohm[2.45]
$

$
  frac(V_"CC" - V_"CE", R_p) &= #quan[10 mA] \
  R_p &= #zi.ohm[310]
$