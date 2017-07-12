//: [Previous](@previous)

import Foundation


enum SplayTree<Elem:Comparable> {
    case empty
    indirect case node(SplayTree<Elem>, Elem, SplayTree<Elem>)
}


extension SplayTree: CustomStringConvertible {
    
    func diagram(_ top: String, _ root: String, _ bottom: String) -> String {
        switch self {
        case .empty:
            return root + "\n"
        case let .node(.empty,value, .empty):
            return root + "\(value)\n"
            
        case let .node(left, value, .empty):
            return root + "\(value)\n"
                + left.diagram(bottom + "│   ", bottom + "└───", bottom + "    ")
        
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
        switch tree {
        case .empty:
            return (.empty, .empty)
            
        case let .node(left, value, right):
            
            if value < pivot {
                switch right {
                case .empty: return (tree, .empty)
                case let .node(left1, value1, right1):
                    if value1 < pivot {
                        let (small, big) = partition(tree: right1, with: pivot)
                        return (.node(.node(left, value, left1), value1, small), big)
                    } else {
                        let (small, big) = partition(tree: left1, with: pivot)
                        return (.node(left, value, small), .node(big, value1, right1))
                    }
                }
                
            } else {
                switch left {
                case .empty: return (.empty, tree)
                case let .node(left1, value1, right1):
                    if value1 < pivot {
                        let (small, big) = partition(tree: right1, with: pivot)
                        return (.node(left1, value1, small), .node(big, value, right))
                    } else {
                        let (small, big) = partition(tree: left1, with: pivot)
                        return (small, .node(big, value1, .node(right1, value, right)))
                    }
                }
            }
        }
    }
}

extension SplayTree : Heap {
    
    typealias Element = Elem
    
    func merge(with heap:SplayTree<Elem>) -> SplayTree<Elem> {
        switch self {
        case .empty:
            return heap
        case let .node(left, value, right) :
            let (ta, tb) = partition(tree: heap, with: value)
            return .node(ta.merge(with: left), value, tb.merge(with: right))
        }
    }
    
    func insert(x: Elem) -> SplayTree<Elem> {
        let (a,b) = partition(tree: self, with: x)
        return .node(a, x, b)
    }
    
    func deleteMin() -> SplayTree<Elem> {
        
        switch self {
        case .empty:
            return .empty
        case let .node(.empty, _, right) :
            return right
        case let .node(.node(a, x, b), value, right):
            return .node(a.deleteMin(), x, .node(b, value, right))
        
        }
    }
    
    func findMin() -> Elem? {
        switch self {
        case .empty:
            return nil
        case let .node(.empty, value, _) :
            return value
        case let .node(left, _, _) :
            return left.findMin()
        }
    }
}

extension SplayTree {
    
    init(from list:[Elem]) {
        
        if list.isEmpty {
            self = .empty
        } else {
            self = list.reduce(.empty, { result, item in
                return result.insert(x: item)
            })
        }
    }
}

let list = [11, 1, 2, 3, 4, 5 ]
var splayHeap = SplayTree<Int>.init(from:list)
print(splayHeap)


//: [Next](@next)
