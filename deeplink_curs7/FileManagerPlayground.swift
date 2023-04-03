//
//  FileManagerPlayground.swift
//  deeplink_curs7
//
//  Created by Orlando Neacsu on 01.04.2023.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    let directory = FileManager.default.urls(for: .developerDirectory, in: .allDomainsMask)[0]
    let fileName = "doc.txt"
    
    override func viewDidLoad() {
        do {
            let urls = try FileManager.default.contentsOfDirectory(
                at: Bundle.main.bundleURL,
                includingPropertiesForKeys: nil
            )
            print(urls)
        } catch {
            print(error)
        }
    }
    
    func presentAlertController() {
        
        let alertController = UIAlertController(
            title: "Succes",
            message: "Mesajul a fost trimis cu succes!",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    func createFile() {
        
        let contentFile = "Acesta este ultimul curs din cadrul bootcamp-ului sustinut de compania BetFair"
        let contentFileData = contentFile.data(using: .utf8)!
        do {
           try contentFileData.write(to: directory.appendingPathExtension(fileName))
        } catch {
            print(error)
        }
    }
    
    func readFile() {
        do {
            let fileContent = try Data(contentsOf: directory.appendingPathExtension(fileName))
            let fileContentString = String(data: fileContent, encoding: .utf8)!
            print(fileContentString)
        } catch {
            print(error)
        }
    }
    
    func removeFile(url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print(error)
        }
    }
    
    func copyFile() {
//        FileManager.default.copyItem(atPath: <#T##String#>, toPath: <#T##String#>)
    }
    
    func moveFile() {
//        FileManager.default.moveItem(at: <#T##URL#>, to: <#T##URL#>)
    }
}


func test(closure1: @escaping () -> ()) {}

func test3(param1:Int, closure1: @escaping () -> ()) {}

func test4(param1:Int, closure1: @escaping (String) -> ()) {}

func test5(
    closure1: @escaping () -> (),
    closure2: @escaping () -> (),
    closure3: @escaping () -> ()
) {}



func testfunction() {
    
    test { // trailing closure
        
    }
    
    test3(param1: 3) {
        
    }
    
    test4(param1: 4) { string in print(string) }
    test4(param1: 0) { print($0) }
    test4(
        param1: 0,
        closure1: { print($0) }
    )
    
    test5 {
        print("closure1")
    } closure2: {
        print("closure2")
    } closure3: {
        print("closure3")
    }
    
    test5(
        closure1: { print("closure1") },
        closure2: { print("closure2") },
        closure3: { print("closure3") }
    )
}

/*
 emag://
 https://
 */
