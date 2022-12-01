import Foundation

public protocol Setting {
    var install: [SettingCommand] { get }
}

// MARK: - Setting
public extension Setting {
    
    func setting() throws -> Self{
        
        
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Self, Error>?
        let completionHandler = { result = $0 }
        
        Task {
            do {
//                completionHandler(.success(setting))
            } catch {
                completionHandler(.failure(error))
            }
            semaphore.signal()
        }
        
        semaphore.wait()
        return try result!.get()
    }
}


struct A: Setting {
    var install: [SettingCommand] = [
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


[고민되는 사항] -> Satus에 너무 많은 것을 넣으면 메모리 감당이 안될 것 같음
 방법 1. Plugin과 Setting을 분리
 
 */
