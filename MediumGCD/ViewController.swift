//
//  ViewController.swift
//  MediumGCD
//
//  Created by Will Chiu on 10/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    let dateFormatter = DateFormatter()
    let concurrentQueue1 = DispatchQueue(label: "concurrentQueue1", attributes: .concurrent)
    let serialQueue1 = DispatchQueue(label: "serialQueue1")
    let concurrentQueue2 = DispatchQueue(label: "concurrentQueue2", attributes: .concurrent)
    let serialQueue2 = DispatchQueue(label: "serialQueue2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let tapLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 24))
        tapLabel.center = self.view.center
        tapLabel.text = "Tap To Run Tasks"
        tapLabel.textAlignment = .center
        self.view.addSubview(tapLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedStart))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func tappedStart(_ sender: UIButton) {
        
        // Example 0
        print("Current Thread: \(Thread.current.description)")
        
        // Example 1
//        heavyDutyAsync("serialQueue1 🔴", queue: serialQueue1)
//        heavyDutyAsync("serialQueue2 🟠", queue: serialQueue2)
//        heavyDutyAsync("serialQueue1 🟢", queue: serialQueue1)
//        heavyDutyAsync("serialQueue2 🔵", queue: serialQueue2)
        
        // Example 2
//        heavyDutyAsync("concurrentQueue1 🔴", queue: concurrentQueue1)
//        heavyDutyAsync("concurrentQueue2 🟠", queue: concurrentQueue2)
//        heavyDutyAsync("concurrentQueue1 🟢", queue: concurrentQueue1)
//        heavyDutyAsync("concurrentQueue2 🔵", queue: concurrentQueue2)
        
        // Example 3
//        heavyDutySync("serialQueue1 🔴", queue: serialQueue1)
//        heavyDutySync("serialQueue2 🟠", queue: serialQueue2)
//        heavyDutySync("concurrentQueue1 🟢", queue: concurrentQueue1)
//        heavyDutySync("concurrentQueue2 🔵", queue: concurrentQueue2)

        // Example 4
//        heavyDutyAsync("concurrentQueue1 🔴", queue: concurrentQueue1)
//        heavyDutySync("concurrentQueue2 🟠", queue: concurrentQueue2)
//        heavyDutySync("serialQueue1 🟢", queue: serialQueue1)
//        heavyDutyAsync("serialQueue2 🔵", queue: serialQueue2)
        
    }
    
    // Async method
    func heavyDutyAsync(_ by: String, queue: DispatchQueue) {
        queue.async {
            let startTime = Date()
            print("\(Thread.current.description), Async by \(by), START: \(self.dateFormatter.string(from: startTime))")
            for i in 1...100 {
                if i^3 < 1000000 {
                    for _ in 1...300000 {}
                }
                if i == 100 {
                    let endTime = Date()
                    print("\(Thread.current.description), Async by \(by), END: \(self.dateFormatter.string(from: endTime))")
                }
            }
        }
    }
    
    // Sync method
    private func heavyDutySync(_ by: String, queue: DispatchQueue) {
        queue.sync {
            print("\(Thread.current.description), Sync by \(by), START: \(self.dateFormatter.string(from: Date()))")
            for i in 1...100 {
                if i^3 < 1000000 {
                    for _ in 1...300000 {}
                }
                if i == 100 {
                    print("\(Thread.current.description), Sync by \(by), END: \(self.dateFormatter.string(from: Date()))")
                }
            }
        }
    }
    
}

