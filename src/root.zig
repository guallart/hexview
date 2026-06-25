const std = @import("std");
const io = std.Io;

// Address  | 00 01 02 03  04 05 06 07  08 09 0A 0B  0C 0D 0E 0f | ASCII
// ---------+----------------------------------------------------+-----------------
// 00000010 | AA AA AA BB  00 11 22 33  00 11 22 33  00 11 22 33 |

pub const bytes_per_line = 16;
pub const chars_per_line = 80;
pub const ascii_offset = 64;

pub fn print_hex(writer: *io.Writer, reader: *io.Reader) !void {
    var address: usize = 0;
    var content: [bytes_per_line]u8 = undefined;

    try writer.print("\nAddress  | 00 01 02 03  04 05 06 07  08 09 0A 0B  0C 0D 0E 0f | ASCII\n", .{});
    try writer.print("---------+----------------------------------------------------+-----------------\n", .{});

    var bytes_read: usize = 1;
    while (bytes_per_line > 0) {
        bytes_read = try reader.readSliceShort(&content);
        if (bytes_read == 0) break;

        try writer.print("{x:0>8} | ", .{address});

        for (0..bytes_per_line) |i| {
            if (i < bytes_read) {
                try writer.print("{X:0>2} ", .{content[i]});
            } else {
                try writer.writeAll("   ");
            }
            if (i % 4 == 3 and i != bytes_per_line - 1) {
                try writer.writeAll(" ");
            }
        }

        try writer.writeAll("| ");

        for (0..bytes_read) |i| {
            const c = content[i];
            if (c >= 32 and c <= 126) {
                try writer.writeByte(c);
            } else {
                try writer.writeByte('.');
            }
        }

        if (bytes_read < bytes_per_line) {
            for (0..bytes_per_line - bytes_read) |_| {
                try writer.writeByte(' ');
            }
        }

        try writer.writeByte('\n');
        address += bytes_per_line;
    }

    try writer.writeByte('\n');
}
