OFL   = openFPGALoader
RM    = rm -rf

CC_TOOL_DIR=$(CC_TOOL)
YOSYS = $(CC_TOOL)/bin/yosys/yosys
P_R   = $(CC_TOOL)/bin/p_r/p_r

PRFLAGS = --verbose -cCP
#YS_OPTS = -D DISP_640x480_60Hz=1

SOURCEDIR = ../../../rtl
TOP    = apple1
CONSTR = olimex.ccf

#all: apple1 prog

apple1.bin: apple1.asc
apple1.asc: apple1.blif
apple1.blif: apple1.v
OBJS += $(SOURCEDIR)/apple1.v
OBJS += $(SOURCEDIR)/clock.v
OBJS += $(SOURCEDIR)/pwr_reset.v
OBJS += $(SOURCEDIR)/ram.v
OBJS += $(SOURCEDIR)/rom_wozmon.v
OBJS += $(SOURCEDIR)/rom_basic.v
OBJS += $(SOURCEDIR)/cpu/arlet_6502.v
OBJS += $(SOURCEDIR)/cpu/arlet/ALU.v
OBJS += $(SOURCEDIR)/cpu/arlet/cpu.v
OBJS += $(SOURCEDIR)/uart/uart.v
OBJS += $(SOURCEDIR)/uart/async_tx_rx.v
OBJS += $(SOURCEDIR)/vga/vga.v
OBJS += $(SOURCEDIR)/vga/vram.v
OBJS += $(SOURCEDIR)/vga/font_rom.v
OBJS += $(SOURCEDIR)/ps2keyboard/debounce.v
OBJS += $(SOURCEDIR)/ps2keyboard/ps2keyboard.v
OBJS += $(SOURCEDIR)/boards/olimex_gatemate/apple1_vga.v
OBJS += $(SOURCEDIR)/boards/olimex_gatemate/gatemate_10MHz_25MHz_pll.v


info:
	@echo "       To build: make all"
	@echo "    To clean up: make clean"

all:impl
synth: $(TOP)_synth.v
$(TOP)_synth.v: $(OBJS)
	$(YOSYS) -ql synth.log -p 'read -sv $^; synth_gatemate -top $(TOP)_top -nomx8 -vlog $(TOP)_synth.v'

$(TOP)_00.cfg: $(TOP)_synth.v $(CONSTR)
	$(P_R) -v -i $(TOP)_synth.v -ccf $(CONSTR) -o $(TOP) $(PRFLAGS)
impl:$(TOP)_00.cfg

# ------ APPLE 1 ------
apple1: dir apple1.bit

apple1.bin: apple1.asc
apple1.asc: apple1.json
apple1.json: $(SOURCEDIR)/apple1.v \

jtag: $(TOP)_00.cfg
	$(OFL) $(OFLFLAGS) -b $(BOARD) $^

jtag-flash: $(TOP)_00.cfg
	$(OFL) $(OFLFLAGS) -b $(BOARD) -f --verify $^

# ------ HELPERS ------
clean:
	$(RM) *.log *_synth.v *.history *.txt *.refwire *.refparam
	$(RM) *.refcomp *.pos *.pathes *.path_struc *.net *.id *.prn
	$(RM) *_00.v *.used *.sdf *.place *.pin *.cfg* *.cdf

.SECONDARY:
.PHONY: all jtag jtag-flash clean
