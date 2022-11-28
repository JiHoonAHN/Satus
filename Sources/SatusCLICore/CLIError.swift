enum CLIError: Error {
    case newProjectFolderNotEmpty
    case notHaveSwiftPackage
}

extension CLIError: CustomStringConvertible {
    var description: String {
        switch self {
        case .newProjectFolderNotEmpty:
            return "New projects can only be created in an empty folder."
        case .notHaveSwiftPackage:
            return "The current folder doesn't have swift package."
        }
    }
}
