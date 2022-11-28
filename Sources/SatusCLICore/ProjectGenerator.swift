import Foundation
import Files

struct ProjectGenerator {
    private let folder: Folder
    private let repositoryURL: URL
    private let version: String
    private let projectName: String
    
    init(
        folder: Folder,
        repositoryURL: URL,
        version: String
    ) {
        self.folder = folder
        self.repositoryURL = repositoryURL
        self.version = version
        self.projectName = folder.name
    }
    
    func generate() throws {
        guard folder.files.first == nil, folder.subfolders.first == nil else {
            throw CLIError.newProjectFolderNotEmpty
        }
        
        try generateGitignore()
        try generatePackage()
        try generateMainFile()
        try generateDetailFile()
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
                .executable(
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
}
