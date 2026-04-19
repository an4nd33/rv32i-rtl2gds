`default_nettype wire
`timescale 1ns/1ps

module tb_soc;

    reg clk, rst;
    always #5 clk = ~clk;

    // ================================
    // DUT Signals
    // ================================
    wire [31:0] pc, instr_w;
    wire [31:0] x1,x2,x3,x4,x5,x6;
    wire [31:0] mem0,mem1,mem2,mem3,mem4,mem5,mem6,mem7;
    wire [31:0] mem8,mem9,mem10,mem11;
    wire        ram_sel, i2c_sel, ack_w, stall_w;
    wire [7:0]  smem0,smem1,smem2,smem3,smem4,smem5,smem6,smem7;

    // ================================
    // DUT (Gate-Level Netlist)
    // ================================
    top_system dut (
        .clk(clk), .reset(rst),
        .pc_curr(pc), .instr(instr_w),
        .x1(x1),.x2(x2),.x3(x3),.x4(x4),.x5(x5),.x6(x6),
        .mem0(mem0),.mem1(mem1),.mem2(mem2),.mem3(mem3),
        .mem4(mem4),.mem5(mem5),.mem6(mem6),.mem7(mem7),
        .mem8(mem8),.mem9(mem9),.mem10(mem10),.mem11(mem11),
        .ram_sel(ram_sel),.i2c_sel(i2c_sel),.ack(ack_w),.stall(stall_w),
        .slave_mem0(smem0),.slave_mem1(smem1),
        .slave_mem2(smem2),.slave_mem3(smem3),
        .slave_mem4(smem4),.slave_mem5(smem5),
        .slave_mem6(smem6),.slave_mem7(smem7)
    );

    // ================================
    // SDF Annotation (UPDATED NAME)
    // ================================
    initial begin
        $sdf_annotate("top_system_10ns.sdf", dut);
    end

    // ================================
    // Hierarchical access (may break if optimized)
    // ================================
    wire [31:0] r_x30 = dut.cpu.rf.REG[30];
    wire [31:0] r_x31 = dut.cpu.rf.REG[31];
    wire [31:0] r_x28 = dut.cpu.rf.REG[28];

    // ================================
    // Halt Detection (GLS safe)
    // ================================
    reg [31:0] prev_pc;
    integer same_cnt;
    reg halted;

    always @(posedge clk) begin
        if (rst) begin
            prev_pc  <= 32'hDEAD;
            same_cnt <= 0;
            halted   <= 0;
        end else if (!halted && (stall_w !== 1'b1)) begin
            if (pc == prev_pc) same_cnt <= same_cnt + 1;
            else               same_cnt <= 0;
            if (same_cnt >= 4) halted <= 1;
            prev_pc <= pc;
        end
    end

    // ================================
    // Logging
    // ================================
    integer pass_cnt, fail_cnt;
    integer log_fd;

    task check;
        input [255:0] name;
        input [31:0]  got, exp;
        begin
            if (got === exp) begin
                $display("  [PASS] %-30s = 0x%08h", name, got);
                $fdisplay(log_fd, "  [PASS] %-30s = 0x%08h", name, got);
                pass_cnt = pass_cnt + 1;
            end else begin
                $display("  [FAIL] %-30s = 0x%08h (exp 0x%08h)", name, got, exp);
                $fdisplay(log_fd, "  [FAIL] %-30s = 0x%08h (exp 0x%08h)", name, got, exp);
                fail_cnt = fail_cnt + 1;
            end
        end
    endtask

    // ================================
    // MAIN TEST
    // ================================
    initial begin

        // File logging
        log_fd = $fopen("gls_results.txt", "w");

        // Waveform
        $dumpfile("tb_soc.vcd");
        $dumpvars(0, tb_soc);

        clk = 0;
        rst = 1;
        pass_cnt = 0;
        fail_cnt = 0;

        // Reset (important for GLS)
        #100 rst = 0;

        $display("\n==== GLS START ====\n");
        $fdisplay(log_fd, "\n==== GLS START ====\n");

        // =============================
        // Wait for completion
        // =============================
        fork
            begin wait(halted); end
            begin 
                #5_000_000;
                $display("[TIMEOUT] PC=0x%08h", pc);
                $fdisplay(log_fd, "[TIMEOUT] PC=0x%08h", pc);
            end
        join_any
        disable fork;

        repeat(5) @(posedge clk);
        #50;  // Allow delay settling (IMPORTANT)

        $display("[INFO] Halted at PC=0x%08h time=%0t", pc, $time);
        $fdisplay(log_fd, "[INFO] Halted at PC=0x%08h time=%0t", pc, $time);

        // =============================
        // RAM Check
        // =============================
        $display("\n--- RAM CHECK ---");
        $fdisplay(log_fd, "\n--- RAM CHECK ---");

        check("RAM[0] test count", mem0, 32'd39);
        check("RAM[1] pass flag",  mem1, 32'd1);
        check("RAM[2] fail idx",   mem2, 32'd0);

        // =============================
        // I2C Check
        // =============================
        $display("\n--- I2C CHECK ---");
        $fdisplay(log_fd, "\n--- I2C CHECK ---");

        check("I2C MSB", {24'd0,smem0}, 32'h12);
        check("I2C B1",  {24'd0,smem1}, 32'h34);
        check("I2C B2",  {24'd0,smem2}, 32'h56);
        check("I2C LSB", {24'd0,smem3}, 32'h78);

        // =============================
        // FINAL SUMMARY
        // =============================
        $display("\n=======================================");
        $display("           GLS SUMMARY");
        $display("=======================================");
        $display("Total Tests : %0d", r_x30);
        $display("Passed      : %0d", pass_cnt);
        $display("Failed      : %0d", fail_cnt);

        $fdisplay(log_fd, "\n=======================================");
        $fdisplay(log_fd, "           GLS SUMMARY");
        $fdisplay(log_fd, "=======================================");
        $fdisplay(log_fd, "Total Tests : %0d", r_x30);
        $fdisplay(log_fd, "Passed      : %0d", pass_cnt);
        $fdisplay(log_fd, "Failed      : %0d", fail_cnt);

        if (fail_cnt == 0 && r_x31 == 1) begin
            $display("STATUS      : PASS");
            $fdisplay(log_fd, "STATUS      : PASS");
        end else begin
            $display("STATUS      : FAIL");
            $fdisplay(log_fd, "STATUS      : FAIL");
        end

        $display("=======================================\n");
        $fdisplay(log_fd, "=======================================\n");

        $fclose(log_fd);
        $finish;
    end

endmodule