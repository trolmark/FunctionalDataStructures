//: [Previous](@previous)

import Foundation

struct BatchedQueue<Elem:CustomStringConvertible> : Queue {
    
    typealias Element = Elem
    
    fileprivate var f : [Elem] = []
    fileprivate var r : [Elem] = []
    
    static func empty() -> BatchedQueue {
        return BatchedQueue(f: [], r: [])
    }
    
    func isEmpty() -> Bool {
        return f.isEmpty
    }
    
    func head() -> Elem? {
        return f.first
    }
    
    func tail() -> BatchedQueue<Elem> {
        if f.isEmpty {
            return checkF(f: [], r: r)
        } else {
            let newF = Array(f.dropFirst())
            return checkF(f: newF, r: r)
        }
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

extension BatchedQueue: CustomStringConvertible {
    
    var description: String {
        let all = f + r
        return all.reduce("", { result, elem in
            return result + "   " + elem.description
        })
    }
}


indirect enum CatenableList<Element:Comparable> {
    case empty
    case node(Element, BatchedQueue<CatenableList>)
}

extension CatenableList {
    
    init() {
        self = .empty
    }
}

extension CatenableList: CustomStringConvertible {
    
    func diagram(_ root: String, _ bottom: String) -> String {
        switch self {
        case .empty:
            return root + "\n"
        case let .node(value, queue):
            return root + "\(value)\n"
                + queue.description
        }
    }
    
    var description: String {
        return self.diagram("", "")
    }
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
        return link(elem: .node(elem, BatchedQueue.empty()))
    }
        
        
    func link(elem: CatenableList) -> CatenableList {
        switch self {
        case .empty:
            return elem
        case let .node(x, q):
            return .node(x, q.snoc(elem: elem))
        }
    }
    
    func linkAll(in queue:BatchedQueue<CatenableList>) -> CatenableList {
        
        guard let qHead = queue.head()
        else { return .empty }
            
        let qTail = queue.tail()
        
        if qTail.isEmpty() {
            return qHead
        }
        return qHead.linkAll(in: qTail)
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

let list = CatenableList<Int>()
print(list.snoc(elem: 6)
    .snoc(elem: 4)
    .snoc(elem: 3)
    .head())



//: [Next](@next)
