//: [Previous](@previous)

import Foundation

struct BatchedQueue<Elem> : Queue {
    typealias Element = Elem
    
    fileprivate var f : [Elem] = []
    fileprivate var r : [Elem] = []
    
    func isEmpty() -> Bool {
        return f.isEmpty
    }
    
    func head() -> Elem? {
        return f.first
    }
    
    func tail() -> BatchedQueue<Elem> {
        let newF = Array(f.dropFirst())
        return checkF(f: newF, r: r)
    }
    
    func snoc(elem: Elem) -> BatchedQueue<Elem> {
        let newR =  [elem] + r
        return checkF(f: f, r: newR)
    }
    
    func checkF(f:[Elem], r:[Elem]) -> BatchedQueue<Elem> {
        if f.isEmpty {
            return BatchedQueue(f: r.reversed(), r: [])
        } else {
            return BatchedQueue(f: f, r: r)
        }
    }
}



indirect enum CatenableList<Element:Comparable> {
    case empty
    case node(Element, BatchedQueue<CatenableList>)
}


extension CatenableList {
    
    func head() -> Element? {
        switch self {
        case .empty: return nil
        case let .node(x, _): return x
        }
    }
    
    func tail() -> CatenableList {
        switch self {
        case .empty: return .empty
        case let .node(_, q) where q.isEmpty():
            return .empty
        case let .node(_, q):
            return linkAll(in:q)
        }
    }
    
    
    func snoc(elem: Element) -> CatenableList {
        return self
    }
        
        
    func link(elem: CatenableList) -> CatenableList {
        switch self {
        case .empty:
            return .empty
        case let .node(x, q):
            return .node(x, q.snoc(elem: elem))
        }
    }
    
    func linkAll(in queue:BatchedQueue<CatenableList>) -> CatenableList {
        return self
    }
    
    func isEmpty() -> Bool {
        switch self {
        case .empty:
            return true
        case .node:
            return false
        }
    }
}

//: [Next](@next)
