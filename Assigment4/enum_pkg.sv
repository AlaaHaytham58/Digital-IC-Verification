package enum_pkg;
// enum parity_mode
typedef enum{
    NO_PARITY,
    ODD_PARITY,
    EVEN_PARITY
}parity_mode_e;
//---------------------------------
//enum state_mode
typedef enum{
    IDLE,
    START,
    DATA,  
    PARITY,
    STOP
}state_mode_e;
//---------------------------------
//struct INPUT PORTS
// typedef struct{
//     bit clk;
//     bit rst_n;
//     bit tx_start;
//     bit [7:0] data_in;
//     bit parity_en;
//     bit even_parity;
// }stimulus;
endpackage