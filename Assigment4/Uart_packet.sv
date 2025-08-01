package uart_packet;
import enum_pkg::*;

class functionsImp;
    rand bit [7:0] data_in;
    rand parity_mode_e parity_mode;
    rand bit rst_n;
    rand bit tx_start;
    rand bit parity_en;
    rand bit even_parity;

    // Constraints
    constraint data_in_c {
        data_in inside {8'h00, 8'hFF, [8'h00:8'hFF]};
    }

    constraint parity_c {
        parity_mode inside {NO_PARITY, ODD_PARITY, EVEN_PARITY};
    }

    constraint rst_n_c {
        rst_n dist {0:/1, 1:/99};
    }

    constraint tx_start_c {
        tx_start dist {0:/50, 1:/50};
    }

    constraint parity_en_c {
        parity_en dist {0:/50, 1:/50};
    }

    constraint even_parity_c {
        even_parity dist {0:/80, 1:/20};
    }

endclass

class covergroup_class;

    bit [7:0] data_in;
    bit rst_n;
    bit tx_start;
    bit parity_en;
    bit even_parity;

    covergroup cg;
        cp1: coverpoint data_in {
            bins all_values[] = {[0:255]};
        }

        cp2: coverpoint data_in {
            bins allones      = {8'hFF};
            bins allzeros     = {8'h00};
            bins up_pattern   = {8'h00, 8'h55, 8'hAA, 8'hFF}; 
            bins down_pattern = {8'hFF, 8'hAA, 8'h55, 8'h00};
        }

        cp3: coverpoint rst_n {
            bins reset     = {0};
            bins not_reset = {1};
        }

        cp4: coverpoint tx_start {
            bins start     = {1};
            bins not_start = {0};
        }

        cp5: coverpoint {parity_en, even_parity} {
            bins parity_disabled     = {2'b0x};  
            bins parity_even_enabled = {2'b10};  
            bins parity_odd_enabled  = {2'b11};  
        }
    endgroup
 function void sample(functionsImp f);
        this.data_in     = f.data_in;
        this.rst_n       = f.rst_n;
        this.tx_start    = f.tx_start;
        this.parity_en   = f.parity_en;
        this.even_parity = f.even_parity;
        cg.sample();  
    endfunction
    function new();
        cg = new();
    endfunction

   

endclass
endpackage
