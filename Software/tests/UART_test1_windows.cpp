#include <windows.h>
#include <cstdint>
#include <chrono>
#include <thread>
#include <iostream>

void sendByteToSerialPort(const char* portName, uint8_t byteToSend) {
    // Open the serial port
    HANDLE serialHandle = CreateFile(portName, GENERIC_WRITE, 0, 0, OPEN_EXISTING, 0, 0);
    
    if (serialHandle == INVALID_HANDLE_VALUE) 
	{
        std::cerr << "Error: Could not open serial port." << std::endl;
        return;
    }

    // Set parameters (baud rate, byte size, etc.)
    DCB serialParams = { 0 };
    serialParams.DCBlength = sizeof(serialParams);
    if (!GetCommState(serialHandle, &serialParams)) 
	{
        std::cerr << "Error: Could not get the serial port state." << std::endl;
        CloseHandle(serialHandle);
        return;
    }

    // Set custom baud rate
    serialParams.BaudRate = 10000;  // Custom baud rate of 10000
    serialParams.ByteSize = 8;      // 8 data bits
    serialParams.StopBits = ONESTOPBIT;
    serialParams.Parity = NOPARITY;

    // Apply the settings
    if (!SetCommState(serialHandle, &serialParams)) 
	{
        std::cerr << "Error: Could not set the serial port state." << std::endl;
        CloseHandle(serialHandle);
        return;
    }

    // Send the byte
    DWORD bytesWritten;
    if (!WriteFile(serialHandle, &byteToSend, 1, &bytesWritten, NULL)) 
        std::cerr << "Error: Failed to send byte." << std::endl;
		
	else if (bytesWritten == 1) 
        std::cout << "Byte sent successfully!" << std::endl;

    // Close the serial port
    CloseHandle(serialHandle);
}

void readBytesFromSerialPort(const char* portName, int bytesToRead) {
    // Open the serial port
    HANDLE serialHandle = CreateFile(portName, GENERIC_READ, 0, 0, OPEN_EXISTING, 0, 0);

    if (serialHandle == INVALID_HANDLE_VALUE) {
        std::cerr << "Error: Could not open serial port." << std::endl;
        return;
    }

    // Set parameters (baud rate, byte size, etc.)
    DCB serialParams = { 0 };
    serialParams.DCBlength = sizeof(serialParams);
    if (!GetCommState(serialHandle, &serialParams)) {
        std::cerr << "Error: Could not get the serial port state." << std::endl;
        CloseHandle(serialHandle);
        return;
    }

    serialParams.BaudRate = 10000;  // Custom baud rate of 10000
    serialParams.ByteSize = 8;
    serialParams.StopBits = ONESTOPBIT;
    serialParams.Parity = NOPARITY;
    
    if (!SetCommState(serialHandle, &serialParams)) {
        std::cerr << "Error: Could not set the serial port state." << std::endl;
        CloseHandle(serialHandle);
        return;
    }

    // Buffer to store the read bytes
    char charBuffer[256];  // Can handle up to 256 bytes
    if (bytesToRead > 256)
        bytesToRead = 256;  // Limit to the buffer size

    DWORD bytesRead;
    bool success = ReadFile(serialHandle, charBuffer, bytesToRead, &bytesRead, NULL);

    if (success && bytesRead > 0) {
		std::cout << "test" << std::endl;
        // Cast to uint8_t and display the read values
        uint8_t* uint8Buffer = reinterpret_cast<uint8_t*>(charBuffer);

        std::cout << "Bytes read from serial port: ";
        for (DWORD i = 0; i < bytesRead; ++i) {
            std::cout << static_cast<int>(uint8Buffer[i]) << " ";
        }
        std::cout << std::endl;
    } else {
        std::cerr << "Error: Failed to read from serial port or no data available." << std::endl;
    }

    // Close the serial port
    CloseHandle(serialHandle);
}

int main(int arct, char **argv) {
    const char* portName = "COM4"; 
    uint8_t byteToSend = 0xf0;
	int bytesToRead = 1;
	
	char c;

    sendByteToSerialPort(portName, byteToSend);
	
	std::this_thread::sleep_for(std::chrono::seconds(1));
	
	readBytesFromSerialPort(portName, bytesToRead);
	
	

    return 0;
}
