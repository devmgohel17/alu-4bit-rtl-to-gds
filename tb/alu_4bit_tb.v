`timescale 1ns/1ps

module alu_4bit_tb;

    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] OP;

    wire [3:0] Y;
    wire       Zero;
    wire       Carry;

    integer errors;

    // ALU instance
    alu_4bit dut (
        .A(A),
        .B(B),
        .OP(OP),
        .Y(Y),
        .Zero(Zero),
        .Carry(Carry)
    );

    // Waveform generation
    initial begin
        $dumpfile("sim/alu_4bit.vcd");
        $dumpvars(0, alu_4bit_tb);
    end

    // Test task
    task check;
        input [3:0] expected_y;
        input        expected_zero;
        input        expected_carry;
        begin
            #1;

            if ((Y !== expected_y) ||
                (Zero !== expected_zero) ||
                (Carry !== expected_carry)) begin

                $display("FAIL | A=%b B=%b OP=%b | Y=%b Z=%b C=%b | Expected Y=%b Z=%b C=%b",
                         A, B, OP, Y, Zero, Carry,
                         expected_y, expected_zero, expected_carry);

                errors = errors + 1;

            end
            else begin

                $display("PASS | A=%b B=%b OP=%b | Y=%b Z=%b C=%b",
                         A, B, OP, Y, Zero, Carry);

            end
        end
    endtask

    initial begin

        errors = 0;

        // --------------------------------
        // Test 1: ADD
        // 1010 + 0011 = 1101
        // --------------------------------
        A = 4'b1010;
        B = 4'b0011;
        OP = 3'b000;
        check(4'b1101, 1'b0, 1'b0);

        // --------------------------------
        // Test 2: SUB
        // 1010 - 0011 = 0111
        // --------------------------------
        OP = 3'b001;
        check(4'b0111, 1'b0, 1'b0);

        // --------------------------------
        // Test 3: AND
        // --------------------------------
        OP = 3'b010;
        check(4'b0010, 1'b0, 1'b0);

        // --------------------------------
        // Test 4: OR
        // --------------------------------
        OP = 3'b011;
        check(4'b1011, 1'b0, 1'b0);

        // --------------------------------
        // Test 5: XOR
        // --------------------------------
        OP = 3'b100;
        check(4'b1001, 1'b0, 1'b0);

        // --------------------------------
        // Test 6: NOT A
        // --------------------------------
        OP = 3'b101;
        check(4'b0101, 1'b0, 1'b0);

        // --------------------------------
        // Test 7: A < B
        // 10 < 3 = false
        // --------------------------------
        OP = 3'b110;
        check(4'b0000, 1'b1, 1'b0);

        // --------------------------------
        // Test 8: A == B
        // 10 == 3 = false
        // --------------------------------
        OP = 3'b111;
        check(4'b0000, 1'b1, 1'b0);


        // =================================
        // EDGE CASE TESTS
        // =================================

        // --------------------------------
        // Test 9: Maximum addition
        // 15 + 1 = 16
        // Y = 0, Carry = 1
        // --------------------------------
        A = 4'b1111;
        B = 4'b0001;
        OP = 3'b000;
        check(4'b0000, 1'b1, 1'b1);

        // --------------------------------
        // Test 10: Addition zero
        // 0 + 0 = 0
        // --------------------------------
        A = 4'b0000;
        B = 4'b0000;
        OP = 3'b000;
        check(4'b0000, 1'b1, 1'b0);

        // --------------------------------
        // Test 11: Subtraction equal
        // 5 - 5 = 0
        // --------------------------------
        A = 4'b0101;
        B = 4'b0101;
        OP = 3'b001;
        check(4'b0000, 1'b1, 1'b0);

        // --------------------------------
        // Test 12: A < B
        // 3 < 10 = true
        // --------------------------------
        A = 4'b0011;
        B = 4'b1010;
        OP = 3'b110;
        check(4'b0001, 1'b0, 1'b0);

        // --------------------------------
        // Test 13: A > B
        // 10 < 3 = false
        // --------------------------------
        A = 4'b1010;
        B = 4'b0011;
        OP = 3'b110;
        check(4'b0000, 1'b1, 1'b0);

        // --------------------------------
        // Test 14: Equal
        // 7 == 7 = true
        // --------------------------------
        A = 4'b0111;
        B = 4'b0111;
        OP = 3'b111;
        check(4'b0001, 1'b0, 1'b0);

        // --------------------------------
        // Test 15: Not equal
        // 7 == 8 = false
        // --------------------------------
        A = 4'b0111;
        B = 4'b1000;
        OP = 3'b111;
        check(4'b0000, 1'b1, 1'b0);

        // FINAL RESULT
        // ==============================

        if (errors == 0) begin
            $display("\n==============================");
            $display("ALL TESTS PASSED");
            $display("==============================\n");
        end
        else begin
            $display("\n==============================");
            $display("%0d TESTS FAILED", errors);
            $display("==============================\n");
        end

        $finish;

    end

endmodule