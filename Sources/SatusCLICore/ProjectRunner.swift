import Foundation
import Files
import Satus

struct ProjectRunner {
    let folder: Folder
    
    func run() throws {
        try folder.packageAvailable()
        
        try shell(
            command: "swift run",
            at: folder.path,
            outputHandle: FileHandle.standardOutput,
            errorHandle: FileHandle.standardError
        )
    }
}
