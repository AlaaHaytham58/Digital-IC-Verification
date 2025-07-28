package uart_packet;
import enum_pkg::*;

class functionsImp;
    bit clk;
    rand bit [7:0] data_in;
    rand parity_mode_e parity_mode;
    rand bit rst_n;
    rand bit tx_start;
    rand bit parity_en;
    rand bit even_parity;
    rand bit tx;

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
endpackage
