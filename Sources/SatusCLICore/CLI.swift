import Foundation
import Files

public struct CLI {
    // MARK: - Properties
    private let arguments: [String]
    private let repositoryURL: URL
    private let version: String
    // MARK: - Initalizer
    public init(
        arguments: [String] = CommandLine.arguments,
        repositoryURL: URL,
        version: String
    ) {
        self.arguments = arguments
        self.repositoryURL = repositoryURL
        self.version = version
    }
    // MARK: - Run
    public func run(in folder: Folder = .current) throws {
        guard arguments.count > 1 else {
            return outputHelpText()
        }
        
        switch arguments[1] {
        case "-v", "--version":
            print(version)
        case "new":
            let newProject = ProjectGenerator(
                folder: folder,
                repositoryURL: repositoryURL,
                version: version,
                type: projectType(from: arguments)
            )
            try newProject.generate()
        case "run":
            let project = ProjectRunner(folder: folder)
            
            try project.run()
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
            
            -v, --version           Commands that tell you the version of the current Satus.
            
        Available commands:
            
            - new:                  Set up a new Setting in current holder
            - run:                  Execute the user-created settings.
            
          See 'satus help <subcommand>' for detailed help.
        """)
    }
    
    private func projectType(from arguments: [String]) -> ProjectType {
        guard arguments.count > 2 else {
            return .setting
        }
        return ProjectType(rawValue: arguments[2]) ?? .setting
    }
}
