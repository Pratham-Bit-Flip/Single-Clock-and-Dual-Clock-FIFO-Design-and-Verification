# Single-Clock and Dual-Clock FIFO Design and Verification

This repository contains two FIFO (First In, First Out) implementations in **Verilog HDL**, along with there testbenches for functional verification.

---
## 🧠 What is a FIFO?

A **FIFO (First In, First Out)** is a memory buffer that stores and retrieves data in the same order it was received — the first data written is the first data read.  
It acts like a queue in hardware systems.

### 🔹 Why FIFOs are used
- To **balance data rates** between two hardware blocks (producer–consumer).
- To **avoid data loss** when one side runs faster than the other.
- To **decouple timing** between modules or subsystems.
- To **safely transfer data across clock domains** in complex digital systems.

### 🔹 Common applications
- UART transmit/receive buffers  
- Network packet queues  
- Audio or video streaming pipelines  
- DMA engines  
- Processor-to-FPGA or sensor-to-CPU data bridges  
- Any design where input and output timing differ

---

## ⚙️ Single-Clock FIFO (Synchronous FIFO)

The **Single-Clock FIFO** operates on one common clock for both **read** and **write** operations.  
It’s simple, fully synchronous, and ideal when both interfaces share the same timing domain.

### Features:
- Single clock for both operations  
- Parameterized width and depth  
- Generates `full` and `empty` flags  
- Low latency and easy to synthesize  

### Typical Use:
- Data buffering between two synchronous modules  
- Pipeline staging in DSP or video systems  

---

## ⚙️ Dual-Clock FIFO (Asynchronous FIFO)

The **Dual-Clock FIFO** allows data to be written and read using **independent clocks**.  
It’s essential for **cross-clock-domain data transfer**, where two subsystems operate at different frequencies.

### Features:
- Separate read and write clocks  
- Gray-coded pointers for metastability protection  
- Two-stage pointer synchronization  
- Robust full/empty flag generation  

### Typical Use:
- Clock domain crossing (CDC) between processor and peripheral blocks  
- High-speed communication interfaces  
- FPGA-to-FPGA or FPGA-to-microcontroller data paths  

---

## 📁 Repository Structure
```
fifo-design/
├── src/
│   ├── s_fifo.v       
│   └── d_fifo.v         
│
├── tb/
│   ├── s_fifo_tb.v    
│   └── d_fifo_tb.v       
│
└── README.md                
```
---
## 🔍 Verification

Both FIFOs are verified using self-checking testbenches (`s_fifo_tb.v`, `d_fifo_tb.v`) that:
- Apply random write/read patterns  
- Check data integrity and flag behavior  
- Simulate under reset and boundary conditions  
- Generate VCD waveforms for debugging

You can simulate using:
```bash
iverilog -o fifo_tb tb/s_fifo_tb.v src/s_fifo.v
vvp fifo_tb
gtkwave dump.vcd
```
---
## 🧰 Tools Used

- Icarus Verilog – Simulation
- GTKWave – Waveform viewing  This project demonstrates design and verification of Single-Clock and Dual-Clock FIFOs in Verilog HDL.
- Yosys – Optional synthesis check
---
---
## 📜 Summary
This project demonstrates design and verification of Single-Clock and Dual-Clock FIFOs in Verilog HDL.
It covers both synchronous and asynchronous buffering techniques, flag management, and verification methodology, suitable for FPGA or ASIC workflows.

---
## 👨‍💻 Author
Pratham-Bit-Flip 
VLSI Enthusiast
- 📧 Email: [prathameshbdesai@gmail.com]
- 🔗 LinkedIn: [linkedin.com/in/pratham](https://www.linkedin.com/in/prathameshdesai1526/)
- 💼 GitHub: [github.com/pratham-bit-flip](https://github.com/Pratham-Bit-Flip)

---
