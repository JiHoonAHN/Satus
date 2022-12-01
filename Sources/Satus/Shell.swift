import Foundation
import Dispatch

@discardableResult
public func shell(
    command: String,
    arguments: [String] = [],
    at path: String = ".",
    process: Process = Process(),
    outputHandle: FileHandle? = nil,
    errorHandle: FileHandle? = nil
) throws -> String {
    let command = "cd \(path.escapingSpaces) && \(command) \(arguments.joined(separator: " "))"
    return try process.executableTerminal(with: command, outputHandle: outputHandle, errorHandle: errorHandle)
}

private extension String {
    var escapingSpaces: String {
        return replacingOccurrences(of: " ", with: "\\ ")
    }
}
