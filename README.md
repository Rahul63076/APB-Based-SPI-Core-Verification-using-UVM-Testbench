# APB-Based-SPI-Core-Verification-using-UVM-Testbench
📖 Project Description
----------------------------------------------------------------------------------------------------------------------------------------------------------------
This project focuses on the functional verification of an APB-based SPI (Serial Peripheral Interface) core using a SystemVerilog UVM testbench architecture. The verification environment is designed to ensure protocol compliance, configurability, and robustness of the SPI core under various operating conditions.
The testbench validates key SPI features such as clock polarity (CPOL), clock phase (CPHA), bit ordering (LSB/MSB first), baud rate configuration, and low power operation modes.

🎯 Objectives
----------------------------------------------------------------------------------------------------------------------------------------------------------------
1. Verify APB protocol compliance of SPI core
2. Validate SPI data transfer under multiple modes
3. Ensure configurability of control registers
4. Achieve high functional coverage using UVM methodology

🛠️ Tools & Technologies
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
1. Languages:- SystemVerilog, Verilog
2. Methodology:- UVM (Universal Verification Methodology)
3. Simulation Tools:- Synopsys VCS / QuestaSim
4. Debug Tools:- Verdi / ModelSim

🧩 Testbench Architecture
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
The UVM testbench includes:-
1. UVM Environment
2. Agent (Driver, Monitor, Sequencer)
3. Scoreboard
4. Functional Coverage Model
5. Virtual Interface
6. Test Library

🔍 Verification Features
----------------------------------------------------------------------------------------------------------------------------------------------------------------
✔️ SPI Mode Verification
----------------------------------------------------------------------------------------------------------------------------------------------------------------
1. CPOL = 0 / 1
2. CPHA = 0 / 1
3. All 4 SPI modes verified
   
✔️ Data Transfer Modes
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
1. LSB First
2. MSB First
3. Serial shifting validation
   
✔️ Baud Rate Verification
---------------------------------------------------------------------------------------------------------------------------------------------------------------
Different baud rate register configurations tested
Ensured correct clock division and timing behavior

✔️ Low Power Mode Verification
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
Verified SPI behavior in low power conditions
Checked proper enable/disable functionality
Ensured no data corruption during transitions

✔️ APB Register Verification
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
1. Read/Write operations
2. Register reset values
3. Address decoding checks
   
🧪 Testcases Covered
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. SPI Mode 0, 1, 2, 3 validation
2. LSB/MSB switching test
3. Baud rate variation test
4. Continuous data transfer test
5. Low power mode enable/disable test
6. Reset and initialization test
7. Invalid transaction handling
   
📊 Functional Coverage
------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. CPOL & CPHA cross coverage
2. LSB/MSB coverage
3. Baud rate register value coverage
4. APB transaction coverage
5. Power mode transition coverage
   
✅ Results
------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. Achieved high functional coverage
2. All major SPI configurations verified successfully
3. No protocol violations observed
