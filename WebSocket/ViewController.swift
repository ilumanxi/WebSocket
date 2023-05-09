//
//  ViewController.swift
//  WebSocket
//
//  Created by 风起兮 on 2023/5/9.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = URL(string: "ws://127.0.0.1:8080")!
        
        let socketConnection = URLSession.shared.webSocketTask(with: url)
        let stream = SocketStream(task: socketConnection)
        
        Task {
            try await Task.sleep(for: .seconds(5))
            try await stream.cancel()
        }
        

        Task {
            do {
                for try await message in stream {
                    // handle incoming messages
                    debugPrint(message)
                }
            } catch {
                // handle error
                debugPrint(error)
            }

            print("this will be printed once the stream ends")
        }
        
        Task {
            try await socketConnection.send(.string("{}"))
        }
        
        
    }


}

