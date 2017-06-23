//: [Previous](@previous)

import Foundation


indirect enum LeftistHeap <Element:Comparable> {
    case leaf
    case node(LeftistHeap<Element>, Element, LeftistHeap<Element>)
}

extension LeftistHeap {
    
    init() {
        self = .leaf
    }
}

extension LeftistHeap {
    
    var isEmpty : Bool {
        switch self {
        case .leaf : return true
        case .node(_, _, _) : return false
        }
    }

    func empty() -> LeftistHeap {
        return .leaf
    }
}


//: [Next](@next)
