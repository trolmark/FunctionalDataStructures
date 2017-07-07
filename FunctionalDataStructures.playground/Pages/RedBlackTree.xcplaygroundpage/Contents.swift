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

extension RedBlackTree {
    
    func insert(_ elem : Element) -> RedBlackTree {
        let newTree = ins(elem: elem, in: self)
    
        switch newTree {
        case .empty: return newTree
        case let .node(_ , left, x, right):
            return .node(.black,left, x,right)
        }
    }
    
    func ins(elem:Element, in tree:RedBlackTree) -> RedBlackTree {
        switch tree {
        case .empty: return .node(.red, .empty, elem, .empty)
        case let .node(_, _, value, _) where value == elem:
            return tree
        case let .node(color, left, value , right) where elem < value :
            return balance(color, ins(elem: elem, in: left), value, right)
        case let .node(color, left, value , right) :
           return balance(color, left, value, ins(elem: elem, in: right))
        }
    }
}

extension RedBlackTree {
    
    func balance(_ color:Color,
                 _ left:RedBlackTree,
                 _ value:Element,
                 _ right:RedBlackTree) -> RedBlackTree {
        switch (color, value, left, right) {
        case let (.black, z, .node(.red, .node(.red, a, x, b), y, c), d):
             return .node(.red, .node(.black, a, x, b), y, .node(.black, c, z, d))
        case let (.black, z, .node(.red, a, x , .node(.red, b, y, c)), d):
             return .node(.red, .node(.black, a, x, b), y, .node(.black, c, z, d))
        case let (.black, x, a, .node(.red, .node(.red, b, y, c), z, d)):
             return .node(.red, .node(.black, a, x, b), y, .node(.black, c, z, d))
        case let (.black, x, a, .node(.red, b, y, .node(.red, c, z, d))):
            return .node(.red, .node(.black, a, x, b), y, .node(.black, c, z, d))
        default:
            return .node(color, left, value, right)
        }

    }
}

extension RedBlackTree {
    func min() -> Element? {
        switch self {
        case .empty: return nil
        case let .node(_, left, value, _):
            return left.min() ?? value
        }
    }
}

extension RedBlackTree {
    
    init(from list:[Element]) {
        
        if list.isEmpty {
            self = .empty
        } else {
            self = list.reduce(.empty, { result, item in
                return result.insert(item)
            })
        }
    }
}



let list = Array(1...20)
var newSet = RedBlackTree<Int>.init(from:list)
print(newSet)


//: [Next](@next)
