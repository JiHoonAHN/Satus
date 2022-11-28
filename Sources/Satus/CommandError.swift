import Foundation

public struct CommandError: Swift.Error {
    public let status: Int32
    public var errorMessage: String { return errorData.terminalOutput() }
    public var outputMessage: String { return outputData.terminalOutput() }
    public let errorData: Data
    public let outputData: Data
}
