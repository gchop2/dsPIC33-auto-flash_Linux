# =======================================
# Makefile pour dsPIC33FJ128MC802 (XC16)
# Flash automatique via MPLAB IPE + xdotool
# =======================================

PROJECT   := test
DEVICE    := dsPIC33FJ128MC802
CPU       := 33FJ128MC802
HEXFILE   := $(PROJECT).hex
HEXPATH   := $(abspath $(HEXFILE))

XC16_ROOT := /opt/microchip/xc16/v2.10
CC        := $(XC16_ROOT)/bin/xc16-gcc
HEX2BIN   := $(XC16_ROOT)/bin/xc16-bin2hex

INCDIR    := $(XC16_ROOT)/support/dsPIC33F/inc
LDSCRIPT  := $(XC16_ROOT)/support/dsPIC33F/gld/p33FJ128MC802.gld

CFLAGS    := -x assembler-with-cpp -mcpu=$(CPU) -I$(INCDIR)
LDFLAGS   := -T $(LDSCRIPT)

.PHONY: all flash clean

all: $(HEXFILE)

$(HEXFILE): $(PROJECT).s
	@echo "🔧 Compilation de $<"
	$(CC) $(CFLAGS) $(LDFLAGS) -o $(PROJECT).elf $<
	$(HEX2BIN) $(PROJECT).elf

flash: all
	@echo "⚡ Flash automatique complet : Connect + Browse + Program + Quit"
	(mplab_ipe &) && \
	sleep 2 && \
	while [ -z "$$(xdotool search --onlyvisible --name 'MPLAB IPE')" ]; do sleep 0.5; done && \
	WID=$$(xdotool search --onlyvisible --name "MPLAB IPE" | head -n 1) && \
	xdotool windowactivate $$WID && \
	sleep 1 && \
	echo "🖱️  Clic sur Connect…" && \
	xdotool mousemove 462 275 click 1 && \
	echo "🔄 Connexion en cours (6 secondes)..." && \
	sleep 8 && \
	echo "🖱️  Clic sur Browse…" && \
	xdotool mousemove 666 438 click 1 && \
	sleep 0.5 && \
	xdotool type "$(abspath $(HEXFILE))" && \
	sleep 0.3 && \
	xdotool key Return && \
	echo "✅ Fichier HEX sélectionné" && \
	sleep 0.5 && \
	echo "🖱️  Clic sur Program…" && \
	xdotool mousemove 95 389 click 1 && \
	sleep 8 && \
	echo "🧼 Fermeture de MPLAB IPE (Alt+F4)..." && \
	xdotool windowactivate $$WID && \
	xdotool key Alt+F4 && \
	echo "✅ Flash terminé, fenêtre MPLAB IPE fermée 🎉"




clean:
	@rm -f $(PROJECT).elf $(HEXFILE)
