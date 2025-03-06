# 🚀 UART Transmitter and Receiver - Verilog Implementation

## 📌 Overview
This project implements a **Universal Asynchronous Receiver-Transmitter (UART)** system using **SystemVerilog**. It includes both the transmitter and receiver modules, ensuring reliable serial communication between two devices. The design follows a **state-machine-based approach** and is highly configurable.

## ✨ Features
- 🔹 **Baud Rate Configurable** – Easily modify baud rate for different communication speeds.
- 🔹 **Clock Division** – Generates a precise clock signal (`uclk`) for accurate data transmission.
- 🔹 **Asynchronous Communication** – Fully functional without an external clock signal.
- 🔹 **State Machine-Based Design** – Efficient TX & RX operation using FSM.
- 🔹 **Parameterized Design** – Supports different clock frequencies and baud rates.
- 🔹 **Error Handling & Synchronization** – Ensures robust data reception and transmission.

## 🛠️ Modules
1. **`uartrx.sv` (UART Receiver)** – Captures incoming data bits and reconstructs the original message.
2. **`uarttx.sv` (UART Transmitter)** – Converts parallel data into a serial bitstream for transmission.
3. **`top.sv` (Top Module)** – Integrates TX and RX, creating a fully functional UART communication system.

## 🔧 How It Works
1. The **transmitter** (`uarttx`) takes an 8-bit parallel input, converts it to a serial format, and transmits it over the `tx` line.
2. The **receiver** (`uartrx`) listens on the `rx` line, decodes the serial data, and reconstructs the original 8-bit message.
3. The **top module** connects both TX and RX, ensuring seamless data flow.

## 📊 Simulation & Testing
- ✅ Simulated using **QuestaSim/ModelSim**.
- ✅ Verified using testbenches for **correct data transmission and reception**.
- ✅ Functional and timing verification completed.

## 🚀 Future Enhancements
- ⚡ Support for **higher baud rates** (e.g., 115200).
- ⚡ **FIFO buffer integration** for handling multiple data packets.
- ⚡ Addition of **parity checking & error detection** for improved reliability.

---


