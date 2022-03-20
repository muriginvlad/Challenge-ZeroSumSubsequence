//
//  ViewController.swift
//  ZeroSumSubsequence
//
//  Created by Vladislav on 20.03.2022.
//

import UIKit

class ViewController: UIViewController {
    var arrayOfInt: [[Int]] = []
    var stringArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }

    func start(){
        stringArray.removeAll()
        
        loadData()
        
        for i in arrayOfInt {
            if let data = subarrayZero(i) {
                stringArray.append(data)
            }
        }
        
        saveData()
    }
    
    func subarrayZero (_ nums: [Int]) -> String? {
        if nums.count <= 1 {
           return nil
        }
        
        var total = 0
        var arrayTotal = [Int]()
        for i in nums {
            total += i
            
            if total == 0 {
                print("yes")
                return "yes"
            }
            
            if let _ = arrayTotal.firstIndex(where: { $0 == total }) {
                print("yes")
                return "yes"
            }
            arrayTotal.append(total)
        }
        print("no")
        return "no"
    }
    
    func  saveData(){
        let filename = getDocumentsDirectory().appendingPathComponent("output.txt")
        var text = ""
        for i in stringArray {
            text += i + "\n"
        }
        do {
            try text.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData(){
        do {
            if let path = Bundle.main.path(forResource: "test", ofType: "in"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                for i in data.components(separatedBy: "\n") {
                    let intArray = i.components(separatedBy: " ").map { Int($0) }
                    arrayOfInt.append(intArray.compactMap { $0 })
                }
            }
        } catch let err as NSError {
            print(err)
        }
    }
}

