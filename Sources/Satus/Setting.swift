import Foundation

public protocol Setting {
    var install: [Command] { get }
}

// MARK: - Setting
public extension Setting {
    
    func setting() throws {
        
    }
}


struct A: Setting {
    var install: [Command] = [
        .bash(),
        .brew()
    ]
}


/*
 Goals
 
 //jihoon.swift
 struct Jihoon: Setting {
    var install: [Command] {get}
 }
    
 
 
 
 
 //main.swift
 try jihoon().setting()
 
 
 
  [TODO]
 - main.swift 실행시킬 CLI Function
 - Command part
    - Default install (Xcode, iterm, oh-my-zsh, Homebrew, mas ..등등)
    - HomeBrew
 
 [고민하는 사항]
 - 설치해야하는 어플리케이션과 Tool을 나눌 것인가. ex) Application: Xcode, KakaoTalk - Tool: Homebrew, Tuist...etc
*/
