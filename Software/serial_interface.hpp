#ifndef SERIAL_INTERFACE_H
#define SERIAL_INTERFACE_H

/*****************************************************************************************
* Class: SerialPort
*
* Constructor: (name of port, baud rate)
* Member functions: 
*	sendBytes (array of bytes, number of bytes to send) returns success
*	readBytes (array of bytes to write in to, number of bytes to receive) returns success
*****************************************************************************************/

#ifdef _WIN32
// Windows version of port

#include <windows.h>
#include <iostream>

class SerialPort {
	public:
		SerialPort(const char* portName, uint32_t baud);
		
		bool sendBytes(uint8_t *bytes, uint16_t numBytes) {
			DWORD bytesWritten;
			return WriteFile(serialHandle, bytes, static_cast<DWORD>(numBytes), &bytesWritten, NULL);
		}
			
		bool readBytes(uint8_t *bytes, uint16_t numBytes) {
			DWORD bytesRead;
			return ReadFile(serialHandle, bytes, static_cast<DWORD>(numBytes), &bytesRead, NULL);
		}
		
		~SerialPort() {
			CloseHandle(serialHandle); // Close port before it goes out of scope
		} 
	
	private:
		HANDLE serialHandle;
};

SerialPort::SerialPort(const char* portName, uint32_t baud)
{
	serialHandle = CreateFile(portName, GENERIC_WRITE | GENERIC_READ, 0, 0, OPEN_EXISTING, 0, 0);
	if (serialHandle == INVALID_HANDLE_VALUE) 
	{
		std::cerr << "Error: Could not open serial port." << std::endl;
		return;
	}

	// Get parameter list (baud rate, byte size, etc.)
	DCB serialParams = { 0 };
	serialParams.DCBlength = sizeof(serialParams);
	if (!GetCommState(serialHandle, &serialParams)) 
	{
		std::cerr << "Error: Could not get the serial port state." << std::endl;
		CloseHandle(serialHandle);
		return;
	}

	// Set custom baud rate
	serialParams.BaudRate = static_cast<DWORD>(baud);
	serialParams.ByteSize = 8;      // 8 data bits
	serialParams.StopBits = ONESTOPBIT;
	serialParams.Parity = NOPARITY;

	// Apply new serial settings
	if (!SetCommState(serialHandle, &serialParams)) 
	{
		std::cerr << "Error: Could not set the serial port state." << std::endl;
		CloseHandle(serialHandle);
		return;
	}
}

#elif __linux__
// Linux version of port

class SerialPort {
	public:
		SerialPort(const char* portName);
		
		bool sendBytes(uint8_t *bytes, uint16_t numBytes);
			
		bool readBytes(uint8_t *bytes, uint16_t numBytes);
		
		~SerialPort();
	
	private:
};

#endif

#endif
