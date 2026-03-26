# UNADE Latex Template
![
](Figures/UNADELogo.jpg)

This document tries to emulate the UNADE doc file into latex.

there is some areas of improvement, feel free to clone and improve the current repo

main document is main.tex

For the most faithful output relative to the original Word template, prefer `xelatex`.
When `Times New Roman` is available, the class will use it directly; otherwise it
falls back automatically to a Times-compatible font included in standard TeX
distributions. The class now sets letter paper, 1 inch margins, and double spacing
to better match the `.docx`.

The template is configured for APA author-year citations with `biblatex` + `biber`.
Use `\textcite{...}` for narrative citations and `\parencite{...}` for parenthetical citations.
