# dsPIC33 Auto Flash Linux

⚡ Automatisation complète de la programmation d'un dsPIC33FJ128MC802 avec MPLAB IPE sous Linux.

## Description

Ce projet permet de programmer un microcontrôleur dsPIC33FJ128MC802 via MPLAB IPE sur Linux (Kali, Ubuntu...) de manière entièrement automatisée, sans interaction utilisateur. L'automatisation repose sur :

- `xdotool` pour piloter l'interface graphique de MPLAB IPE
- Un `Makefile` personnalisable
- Un script documenté en LaTeX pour tout reproduire

## Fichiers inclus

- `Makefile` : automation complète (Connect + Browse + Program + Quit)
- `flash_automatique_mplab.tex` : document LaTeX explicatif étape par étape
- `.gitignore` : ignore les fichiers temporaires LaTeX
- `README.md` : ce fichier

## Prérequis

- Linux
- `xdotool` : `sudo apt install xdotool`
- MPLAB X IDE v6.20 installé
- Microchip Starter Kit On Board (PKOB)

## Compilation du PDF

```bash
pdflatex flash_automatique_mplab.tex

