import Foundation
import Files

struct ProjectRunner {
    let folder: Folder
    
    func run() throws {
        try folder.packageAvailable()
        
        
        
    }
}
