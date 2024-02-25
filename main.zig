const std = @import("std");
const print = std.debug.print;

const WIDTH: usize = 15;
const HEIGHT: usize = 20;

const World: type = [WIDTH][HEIGHT]bool;

pub fn main() void {
    var worldEven: World = undefined;
    var worldOdd: World = undefined;
    initWorld(&worldEven);
    initWorld(&worldOdd);

    displayWorld(&worldEven);

    var iter: usize = 0;

    while (iter < 12) : (iter += 1) {
        print("iter = {}\n", .{iter});
        if (iter % 2 == 0) {
            calculateNext(&worldEven, &worldOdd);
            displayWorld(&worldOdd);
        } else {
            calculateNext(&worldOdd, &worldEven);
            displayWorld(&worldEven);
        }
    }
}

fn calculateNext(from: *World, to: *World) void {
    var x: usize = 1;
    var y: usize = 1;
    while (x < WIDTH - 1) : (x += 1) {
        while (y < HEIGHT - 1) : (y += 1) {
            var sum: u8 = 0;
            sum += if (from.*[x - 1][y - 1]) 1 else 0;
            sum += if (from.*[x][y - 1]) 1 else 0;
            sum += if (from.*[x + 1][y - 1]) 1 else 0;
            sum += if (from.*[x - 1][y]) 1 else 0;
            sum += if (from.*[x + 1][y]) 1 else 0;
            sum += if (from.*[x - 1][y + 1]) 1 else 0;
            sum += if (from.*[x][y + 1]) 1 else 0;
            sum += if (from.*[x + 1][y + 1]) 1 else 0;
            if (from.*[x][y]) {
                switch (sum) {
                    2...3 => to.*[x][y] = true,
                    else => to.*[x][y] = false,
                }
            } else {
                if (sum == 3) {
                    to.*[x][y] = true;
                } else {
                    to.*[x][y] = false;
                }
            }
        }
        y = 1;
    }
}

fn displayWorld(arr: *World) void {
    var x: usize = 0;
    var y: usize = 0;

    while (x < WIDTH) : (x += 1) {
        while (y < HEIGHT) : (y += 1) {
            if (arr.*[x][y]) {
                print("[]", .{});
            } else {
                print("..", .{});
            }
        }
        y = 0;
        print("\n", .{});
    }
}

fn initWorld(arr: *World) void {
    arr.* = [WIDTH][HEIGHT]bool{
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
        [_]bool{false} ** HEIGHT,
    };
    arr.*[5][10] = true;
    arr.*[6][10] = true;
    arr.*[7][10] = true;
    arr.*[8][10] = true;
    arr.*[9][10] = true;
}
