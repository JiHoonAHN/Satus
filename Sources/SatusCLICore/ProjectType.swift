import Foundation

enum ProjectType: String {
    case setting
    case plugin
}

extension ProjectType {
    var product: String {
        switch self {
        case .setting:
            return "executable"
        case .plugin:
            return "library"
        }
    }
}
