import UIKit
import Foundation
import Combine

PlaygroundPage.current.needsIndefiniteExecution = tru

let publisher = Just("Hello")

let subscription = publisher.map { value in
    return value.uppercased()
}.sink { result in
    print("Giá trị nhận được từ subscriber là: \(result)")
}

