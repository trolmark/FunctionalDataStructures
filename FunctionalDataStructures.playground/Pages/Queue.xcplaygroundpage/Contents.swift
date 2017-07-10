//: [Previous](@previous)

import Foundation

protocol Queue {
    associatedtype Element
    
    func isEmpty() -> Bool
    func snoc(elem:Element) -> Self
    func head() -> Element?
    func tail() -> Self
}

struct BatchedQueue<Elem> : Queue {
    typealias Element = Elem
    
    fileprivate var f : [Elem]
    fileprivate var r : [Elem]
    
    func isEmpty() -> Bool {
        return f.isEmpty
    }
    
    func head() -> Elem? {
        return f.first
    }
    
    func tail() -> BatchedQueue<Elem> {
        let newR = Array(r.dropFirst())
        return BatchedQueue(f: f, r: newR)
    }
    
    func snoc(elem: Elem) -> BatchedQueue<Elem> {
        let newR = r + [elem]
        return BatchedQueue(f: f, r: newR)
    }
}


//: [Next](@next)
