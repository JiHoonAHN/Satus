import Foundation
import Files

struct ProjectGenerator {
    private let folder: Folder
    private let repositoryURL: URL
    private let version: String
    private let projectName: String
    private let projectType: ProjectType
    
    init(
        folder: Folder,
        repositoryURL: URL,
        version: String,
        type: ProjectType
    ) {
        self.folder = folder
        self.repositoryURL = repositoryURL
        self.version = version
        self.projectName = folder.name
        self.projectType = type
    }
    
    func generate() throws {
        guard folder.files.first == nil, folder.subfolders.first == nil else {
            throw CLIError.newProjectFolderNotEmpty
        }
        
        try generateGitignore()
        try generatePackage()
        
        switch projectType {
        case .plugin:
            try generateMainFile()
            try generateDetailFile()
        case .setting:
            try generatePluginBoilerplate()
        }
        
        print(
            """
            🚀 Generated \(projectType.rawValue) project!
            ---------------------------------------------
            projectName: \(projectName)
            """
        )
    }
}
// MARK: - Private
private extension ProjectGenerator {
    func generateGitignore() throws {
        try folder.createFile(named: ".gitignore").write("""
        .DS_Store
        /build
        /.build
        /.swiftpm
        /*.xcodeproj
        .satus
        """)
    }
    func generatePackage() throws {
        try folder.createFile(named: "Package.swift").write("""
        // swift-tools-version: 5.7
        
        import PackageDescription
        
        let package = Package(
            name: "\(projectName)",
            platforms: [.macOS(.v12)],
            products: [
                .\(projectType.product)(
                    name: "\(projectName)",
                    targets: ["\(projectName)"]
                )
            ],
            dependencies: [
                .package(url: "\(repositoryURL)", from: "\(version)")
            ],
            targets: [
                .executableTarget(
                    name: "\(projectName)",
                    dependencies: ["Satus"]
                )
            ]
        )
        
        """)
    }
    func generateMainFile() throws {
        let path = "Source/\(projectName)/main.swift"
        
        try folder.createFileIfNeeded(at: path).write("""
        import Foundation
        import Satus
                
        try \(projectName)()
        """)
    }
    func generateDetailFile() throws {
        let path = "Source/\(projectName)/\(projectName).swift"
        
        try folder.createFileIfNeeded(at: path).write("""
        import Foundation
        import Satus
        
        struct \(projectName): Setting {
            
        }
        """)
    }
    
    func generatePluginBoilerplate() throws {
        let path = "Sources/\(projectName)/\(projectName).swift"
        let methodName = projectName[projectName.startIndex].lowercased() + projectName.dropFirst()
        
        try folder.createFileIfNeeded(at: path).write("""
        import Satus
        
        public extension Plugin {
            static func \(methodName)() -> Self {
                Plugin(name: "\(projectName)") {
                    //Add Custom Plugin Feature
                }
            }
        }
        """)
    }
}
