tex := "presentation2.tex"
pdf := "presentation2.pdf"

default:
    @just --list

compile:
    pdflatex -interaction=nonstopmode -halt-on-error {{tex}}
    pdflatex -interaction=nonstopmode -halt-on-error {{tex}}

pympress: compile
    pympress --notes=right {{pdf}}
