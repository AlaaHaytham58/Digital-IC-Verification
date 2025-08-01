package uart_packet;
  import enum_pkg::*;

  // Stimulus class
  class functionsImp;
    rand bit [7:0] data_in;
    rand parity_mode_e parity_mode;
    rand bit parity_en;
    rand bit even_parity;

    // Constraints
    constraint data_in_c {
      data_in inside {[8'h00:8'hFF]};   
    }

    constraint parity_c {
      parity_mode inside {NO_PARITY, ODD_PARITY, EVEN_PARITY};
    }

    constraint parity_en_c {
      parity_en dist {0 := 50, 1 := 50};
    }

    constraint even_parity_c {
      even_parity dist {0 := 50, 1 := 50}; 
    }
  endclass

  // Coverage class
  class covergroup_class;
    bit [7:0] data_in;
    bit parity_en;
    bit even_parity;

    covergroup cg;
      cp1: coverpoint data_in {
        bins all_values[] = {[0:255]};
      }

      cp2: coverpoint data_in {
        bins allzeros  = {8'h00};
        bins allones   = {8'hFF};
        bins up_seq    = {8'h00, 8'h55, 8'hAA, 8'hFF};
        bins down_seq  = {8'hFF, 8'hAA, 8'h55, 8'h00};
      }

      cp3: coverpoint parity_en {
        bins en = {1};
        bins dis = {0};
      }

      cp4: coverpoint even_parity {
        bins even = {1};
        bins odd = {0};
      }

      cp5: cross parity_en, even_parity {
        bins parity_disabled     = binsof(parity_en) intersect {0};
        bins parity_even_enabled = binsof(parity_en) intersect {1} &&
                                   binsof(even_parity) intersect {1};
        bins parity_odd_enabled  = binsof(parity_en) intersect {1} &&
                                   binsof(even_parity) intersect {0};
      }
    endgroup

    function void sample(functionsImp f);
      this.data_in       = f.data_in;
      this.parity_en     = f.parity_en;
      this.even_parity   = f.even_parity;
      cg.sample();
    endfunction

    function new();
      cg = new();
    endfunction
  endclass
endpackage
