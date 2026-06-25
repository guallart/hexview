const std = @import("std");
const Io = std.Io;

const hexview = @import("hexview");

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var stdout_writer = std.Io.File.stdout().writer(io, &.{});
    const stdout = &stdout_writer.interface;

    var stderr_writer = std.Io.File.stderr().writer(io, &.{});
    const stderr = &stderr_writer.interface;

    const args = try init.minimal.args.toSlice(init.arena.allocator());

    if (args.len != 2) {
        try stderr.print("Use: {s} <file>\n", .{args[0]});
        try stderr.print("Example: {s} ./file.bin\n", .{args[0]});
        return;
    }

    const file_path = args[1];

    var file = std.Io.Dir.cwd().openFile(io, file_path, .{}) catch |err| {
        try stderr.print("Error: Could not open the file '{s}'\n", .{file_path});
        try stderr.print("Reason: {}\n", .{err});
        return;
    };
    defer file.close(io);

    var file_reader = file.reader(io, &.{});
    const reader = &file_reader.interface;

    try hexview.print_hex(stdout, reader);
}
