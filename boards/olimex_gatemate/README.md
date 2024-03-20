# Ulx4m with HDMI

This adds support for building the Apple One design for [Olimex](https://www.olimex.com/Products/FPGA/GateMate/GateMateA1-EVB/open-source-hardware) with VGA output and a PS/2 keyboard

## Peripheral support

VGA output onboard connector

PS/2 keyboard onboard connector 

## Building
Install a recent gatemate toolchain, and do:

```
$ cd yosys
$ make
```

## Use

To load BASIC type "E000R" (with CAPS LOCK on if you are using the UART rather than the PS/2 keyboard).
