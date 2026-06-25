# Hexview

A command-line hex viewer utility written in Zig. Displays the contents of binary files in hexadecimal format with ASCII representation, similar to the Unix `hexdump` command.

## Building

### Requirements

- Zig 0.17.0-dev.947+36069a2a7 or later

### Compile

```bash
zig build
```

## Usage

### Basic usage

Display the hex contents of a file:

```bash
zig build run -- ./path/to/file.bin
```

Replace `./path/to/file.bin` with the actual path to your file.

## Output Format

```
Address  | 00 01 02 03  04 05 06 07  08 09 0A 0B  0C 0D 0E 0f | ASCII
---------+----------------------------------------------------+-----------------
00000000 | 63 6F 6E 73  74 20 73 74  64 20 3D 20  40 69 6D 70 | const std = @imp
00000010 | 6F 72 74 28  22 73 74 64  22 29 3B 0A  63 6F 6E 73 | ort("std"); cons
```
