import Foundation
import Files
import Dispatch

public struct Command {
    
    static func bash() -> Command {
        return .init()
    }
    static func brew() -> Command {
        return .init()
    }
    static func curl() -> Command {
        return .init()
    }
    static func sudo() -> Command {
        return .init()
    }
}

// MARK: - Bash

// MARK: - Curl

// MARK: - HomeBrew

// MARK: - Sudo


/*
 [Comand]지원 부분
 
 #bash/sh
.bash()
 
 #HomeBrew
 .brew(option: .install, name: "Tuist")
 
 #Curl
 .curl(option: String... , url: URL, )
 //curl [options...] <url>
 
 #Sudo
 .sudo()
 
 */
