//: [Previous](@previous)

import Foundation


enum SplayTree<Elem:Comparable> {
    case empty
    indirect case node(SplayTree, Elem, SplayTree)
}


extension SplayTree: CustomStringConvertible {
    
    func diagram(_ top: String, _ root: String, _ bottom: String) -> String {
        switch self {
        case .empty:
            return root + "\n"
        case let .node(.empty,value, .empty):
            return root + "\(value)\n"
        case let .node(left, value, right):
            return right.diagram(top + "    ", top + "┌───", top + "│   ")
                + root + "\(value)\n"
                + left.diagram(bottom + "│   ", bottom + "└───", bottom + "    ")
        }
    }
    
    var description: String {
        return self.diagram("", "", "")
    }
}

extension SplayTree {
    
    var isEmpty : Bool {
        switch self {
        case .empty : return true
        case .node(_, _, _) : return false
        }
    }
    
    
    func emptyTree() -> SplayTree {
        return .empty
    }
}

private extension SplayTree {
    
    func partition(tree:SplayTree, with pivot:Elem) -> (SplayTree, SplayTree) {
        return (tree, tree)
    }
}

extension SplayTree : Heap {
    
    typealias Element = Elem
    
    func merge(with heap:SplayTree<Elem>) -> SplayTree<Elem> {
        return heap
    }
    
    func insert(x: Elem) -> SplayTree<Elem> {
        return self
    }
    
    func deleteMin() -> SplayTree<Elem>? {
        return self
    }
    
    func findMin() -> Elem? {
        return nil
    }
}

//: [Next](@next)
