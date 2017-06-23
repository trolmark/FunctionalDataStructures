//: [Previous](@previous)

import Foundation


indirect enum LeftistHeap <Element:Comparable> {
    case leaf
    case node(Int, Element, LeftistHeap<Element>, LeftistHeap<Element>)
}

extension LeftistHeap {
    
    init() {
        self = .leaf
    }
}

extension LeftistHeap {
    
    func getRank() -> Int {
        switch self {
        case .leaf: return 0
        case .node(let rank,_ , _ , _) :  return rank
        }
    }
}

extension LeftistHeap {
    
    var isEmpty : Bool {
        switch self {
        case .leaf : return true
        case .node(_,_, _, _) : return false
        }
    }

    func empty() -> LeftistHeap {
        return .leaf
    }
}

extension LeftistHeap {
    
    func insert(object:Element) -> LeftistHeap {
        return self
    }
}

extension LeftistHeap {
    
    func merge(with heap:LeftistHeap) -> LeftistHeap {
        return heap
    }
    
    func makeT() -> LeftistHeap {
        return self
    }
}

extension LeftistHeap {
    
    func findMin() -> Element? {
        switch self {
        case .leaf: return nil
        case .node(_, let min, _, _ ) : return min
        }
    }
    
    func deleteMin() -> LeftistHeap? {
        switch self {
        case .leaf: return nil
        case .node(_, _ , _, _ ) : return self
        }
    }
}


let heap = LeftistHeap<Int>()

//: [Next](@next)
