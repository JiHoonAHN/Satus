import Foundation
import SatusCLICore

let cli = CLI(
    repositoryURL: URL(
        string: "https://github.com/JiHoonAHN/Satus.git"
    )!,
    version: "0.0.1"
)

do {
    try cli.run()
} catch {
    fputs("❌ \(error)\n", stderr)
    exit(1)
}
