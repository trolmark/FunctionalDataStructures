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
        return self.merge(with: LeftistHeap.makeHeap(x: object))
    }
}

extension LeftistHeap {
    
    func merge(with heap:LeftistHeap) -> LeftistHeap {
        switch (self, heap) {
            
        case (_ , .leaf): return self
        case (.leaf, _) : return heap
            
        case (.node(_, let x, let a1, let b1),
              .node(_, let y, let a2, let b2)) :
            if x < y {
                return LeftistHeap.makeHeap(x: x, a: a1, b: b1.merge(with: b2))
            } else {
                return LeftistHeap.makeHeap(x: y, a: a2, b: b2.merge(with: b1))
            }
            
        default: return self
            
        }
    }
    
    func insert(x:Element) -> LeftistHeap {
        return self.merge(with: .node(1, x, .leaf, .leaf))
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
        case .node(_, _ , let left, let right) :
            return left.merge(with:right)
        }
    }
}

extension LeftistHeap {
    
    init(from list:[Element]) {
        if list.isEmpty { self = .leaf }
        else { self = LeftistHeap.loop(over: list) }
    }
}

extension LeftistHeap {
    
    static func makeHeap(x:Element, a : LeftistHeap = .leaf, b: LeftistHeap = .leaf) -> LeftistHeap {
        if a.getRank() >= b.getRank() {
            return .node(b.getRank() + 1, x, a, b)
        } else {
            return .node(a.getRank() + 1, x, b, a)
        }
    }
    
    static func loop(over list:[Element]) -> LeftistHeap {
        return
            stride(from: 0, to: list.count, by: 2)
            .map { index -> (Element, Element?) in
                (list[index], index < list.count - 1 ? list[index.advanced(by: 1)] : nil)
            }
            .map { pair -> LeftistHeap<Element> in
                guard let item2 = pair.1
                else { return LeftistHeap.makeHeap(x: pair.0)}
                
                return LeftistHeap
                    .makeHeap(x: pair.0)
                    .merge(with: makeHeap(x: item2))
            }
            .reduce(.leaf) { (result:LeftistHeap, item:LeftistHeap) in
                return result.merge(with: item)
            }
    }
}


let heap = LeftistHeap<Int>()

//: [Next](@next)
