import Foundation

public struct CLI {
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        guard arguments.count > 1 else {
            return outputHelpText()
        }
        
        switch arguments[1] {
        case "-h", "--help":
            print("help")
        case "-v", "--version":
            break
        case "new":
            break
        case "run":
            break
        default:
            outputHelpText()
        }
    }
}

// MARK: - Private System
private extension CLI {
    func outputHelpText() {
        print("""
        ┌─────────────────────────────────────────────────────────┐
        │ A new version of Satus is available!                    │
        │                                                         │
        │ To update to the latest version, run "satus upgrade".   │
        └─────────────────────────────────────────────────────────┘
        Setting your macOS!
                    
        OPTIONS:
        
            -h, --help              Show help information.
            -v, --version           Noisy logging, including all shell commands executed.
            
        Available commands:
            
            - new: Set up a new Setting in current holder
            - run: Execute the user-created settings.
            
          See 'satus help <subcommand>' for detailed help.
        """)
    }
}
