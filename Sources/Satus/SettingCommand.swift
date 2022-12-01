import Foundation
import Files
import Dispatch

public struct SettingCommand {
    
    static func bash() -> SettingCommand {
        return .init()
    }
    static func brew() -> SettingCommand {
        return .init()
    }
    static func curl() -> SettingCommand {
        return .init()
    }
    static func sudo() -> SettingCommand {
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
