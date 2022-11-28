import Files

extension Folder {
    func packageAvailable() throws {
        guard containsFile(named: "Package.swift") else {
            throw CLIError.notHaveSwiftPackage
        }
    }
}
