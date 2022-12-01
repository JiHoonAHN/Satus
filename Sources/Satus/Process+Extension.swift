import Foundation
import Dispatch

extension Process {
    public func executableTerminal(with command: String,
                        outputHandle: FileHandle? = nil,
                        errorHandle: FileHandle? = nil) throws -> String {
        executableURL = URL(string: "/bin/bash")
        arguments = ["-c", command]
        let outputQueue = DispatchQueue(label: "bash-output-queue")
        var outputData = Data()
        var errorData = Data()
        
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        standardOutput = outputPipe
        standardError = errorPipe
        
        #if os(Linux)
        outputPipe.fileHandleForReading.readabilityHandler = { handler in
            let data = handler.availableData
            outputQueue.async {
                outputData.append(data)
                outputHandle?.write(contentsOf: data)
            }
        }
        
        errorPipe.fileHandleForReading.readabilityHandler = { handler in
            let data = handler.availableData
            outputQueue.async {
                errorData.append(data)
                errorHandle?.write(contentsOf: data)
            }
        }
        #endif
        
        try run()
        
        #if os(Linux)
        outputQueue.sync {
            outputData = outputPipe.fileHandleForReading.readToEnd()
            errorData = errorPipe.fileHandleForReading.readToEnd()
        }
        #endif
        
        waitUntilExit()
        
        if let handle = outputHandle, !handle.isStandard {
            try handle.close()
        }
        
        if let handler = errorHandle, !handler.isStandard {
            try handler.close()
        }
        
        #if !os(Linux)
        outputPipe.fileHandleForReading.readabilityHandler = nil
        errorPipe.fileHandleForReading.readabilityHandler = nil
        #endif
        
        return try outputQueue.sync {
            if terminationStatus != 0 {
                throw SettingCommandError(status: terminationStatus, errorData: errorData, outputData: outputData)
            }
            return outputData.terminalOutput()
        }
    }
}

private extension FileHandle {
    var isStandard: Bool {
        return self === FileHandle.standardOutput ||
            self === FileHandle.standardError ||
            self === FileHandle.standardInput
    }
}
