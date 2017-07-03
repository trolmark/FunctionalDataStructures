//: [Previous](@previous)

import Foundation

enum Color {
    case black
    case red
}

enum RedBlackTree<Element:Comparable> {
    case empty
    indirect case node(Color, RedBlackTree, Element, RedBlackTree)
}


// Debug

extension Color {
    
    var symbol : String {
        switch self {
        case .black: return "■"
        case .red:   return "□"
        }
    }
}

extension RedBlackTree: CustomStringConvertible {
    
    func diagram(_ top: String, _ root: String, _ bottom: String) -> String {
        switch self {
        case .empty:
            return root + "•\n"
        case let .node(color,.empty,value, .empty):
            return root + "\(color.symbol) \(value)\n"
        case let .node(color, left, value, right):
            return right.diagram(top + "    ", top + "┌───", top + "│   ")
                + root + "\(color.symbol) \(value)\n"
                + left.diagram(bottom + "│   ", bottom + "└───", bottom + "    ")
        }
    }
    
    var description: String {
        return self.diagram("", "", "")
    }
}


extension RedBlackTree {
    
    func member(_ elem:Element) -> Bool {
        switch self {
        case .empty: return false
        case .node(_ , _ , elem, _) : return true
        case let .node(_, left, value , _) where elem < value :
            return left.member(elem)
        case let .node(_, _, _ , right) :
            return right.member(elem)
        }
    }
}


let emptyTree : RedBlackTree<Int> = .empty
print(emptyTree)

//: [Next](@next)
