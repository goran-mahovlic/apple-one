// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//
// Description: Video RAM for system
//
// Author.....: Alan Garfield
//              Niels A. Moseley
// Date.......: 26-1-2018
//

module vram(
    input clk,                  // clock signal
    input [9:0] read_addr,      // read address bus
    input [9:0] write_addr,     // write address bus
    input r_en,                 // active high read enable strobe
    input w_en,                 // active high write enable strobe
    input [5:0] din,            // 6-bit data bus (input)
    output reg [5:0] dout       // 6-bit data bus (output)
    );

    `ifdef SIM
    parameter RAM_FILENAME = "../roms/ram.hex";
    `else
    parameter RAM_FILENAME = "../../roms/vga_vram.bin";
    `endif

    reg [5:0] ram_data[0:1023];

    initial
        $readmemb(RAM_FILENAME, ram_data, 0, 1024);

    always @(posedge clk)
    begin
        if (r_en) dout <= ram_data[read_addr];
        if (w_en) ram_data[write_addr] <= din;
    end

endmodule
     