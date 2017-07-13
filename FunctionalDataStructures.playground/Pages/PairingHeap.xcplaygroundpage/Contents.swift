//: [Previous](@previous)

import Foundation

enum PairingHeap<Elem:Comparable> {
    case empty
    indirect case node(Elem, [PairingHeap<Elem>])
}


extension PairingHeap : Heap {
    
    typealias Element = Elem
    
    func merge(with heap:PairingHeap<Elem>) -> PairingHeap<Elem> {
        return merge(heap1: self, with: heap)
    }
    
    func merge(heap1:PairingHeap,
               with heap2:PairingHeap) -> PairingHeap<Elem> {
        
        switch (heap1, heap2) {
        case (.empty, _ ):
            return heap2
        case (_, .empty) :
            return heap1
        case let (.node(value1, heaps1), .node(value2, heaps2)) :
            if value1 < value2 {
                return .node(value1, [heap2] + heaps1)
            } else {
                return .node(value2, [heap1] + heaps2)
            }
        default : return heap1
        }
    }
    
    /* first merges the subheaps in pairs (this is the step that gave this datastructure its name)
     from left to right and then merges the resulting list of heaps from right to left */
    
    func mergePairs(_ pairs:[PairingHeap<Elem>]) -> PairingHeap<Elem> {
        if pairs.isEmpty { return .empty }
        if pairs.count == 1 { return pairs.first! }
        
        let (first, second, other) = (pairs[0], pairs[1], Array(pairs.dropFirst(2)))
        return merge(heap1: merge(heap1: first, with: second), with: mergePairs(other))
    }
    
    func insert(x: Elem) -> PairingHeap<Elem> {
        return merge(with: .node(x, [.empty]))
    }
    
    func deleteMin() -> PairingHeap<Elem> {
        switch self {
        case .empty:
            return .empty
        case let .node(_, heaps) :
            return mergePairs(heaps)
        }
    }
    
    func findMin() -> Elem? {
        switch self {
        case .empty:
            return nil
        case let .node(value, _) :
            return value
        }
    }
    
    
}

//: [Next](@next)
