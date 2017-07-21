//: [Previous](@previous)

import Foundation

struct Trie<Element:Hashable> {
    let isElement: Bool
    let children:[Element:Trie<Element>]
}

extension Trie {
    
    init() {
        self.isElement = false
        self.children = [:]
    }
}

extension Array {
    var slice : ArraySlice<Element> {
        return ArraySlice(self)
    }
}

extension ArraySlice {
    
    var decomposed:(Element, ArraySlice<Element>)? {
        return isEmpty ? nil : (self[startIndex], self.dropFirst())
    }
}

extension Trie {
    
    func lookup(key:ArraySlice<Element>) -> Bool {
        guard let (head, tail) = key.decomposed
        else { return isElement }
        
        guard let subtrie = children[head] else { return false }
        return subtrie.lookup(key: tail)
    }
}

extension Trie {
    
    init(_ key:ArraySlice<Element>) {
        if let (head, tail) = key.decomposed {
            let children = [head:Trie(tail)]
            self = Trie(isElement: false, children: children)
        } else {
            self = Trie(isElement: true, children: [:])
        }
    }
}

extension Trie {
    
    func inserting(_ key : ArraySlice<Element>) -> Trie<Element> {
        guard let (head, tail) = key.decomposed
        else { return Trie(isElement:true, children:children) }
        
        var newChildred = children
        if let nextTrie = children[head] {
            newChildred[head] = nextTrie.inserting(tail)
        } else {
            newChildred[head] = Trie(tail)
        }
        return Trie(isElement: isElement, children: newChildred)
    }
}


//: [Next](@next)
