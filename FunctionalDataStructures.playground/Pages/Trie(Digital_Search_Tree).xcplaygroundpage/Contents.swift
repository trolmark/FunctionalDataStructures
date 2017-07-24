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

extension Trie : CustomStringConvertible {
    
    var description : String {
        return ""
    }
}

extension Trie {
    
    func lookup(key:ArraySlice<Element>) -> Trie<Element>? {
        guard let (head, tail) = key.decomposed
        else { return self }
    
        guard let subtrie = children[head]
        else { return nil }
        
        return subtrie.lookup(key: tail)
    }
    
    func complete(key:ArraySlice<Element>) -> [Element] {
        return lookup(key: key)?.elements ?? []
    }
}

extension Trie {
    
    var elements : [Element] {
        var result : [Element] = []
        for (key, value) in children {
            result += [key] + value.elements
        }
        return result
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

extension Trie {
    
    static func build(words:[String]) -> Trie<Character> {
        let emptyTrie = Trie<Character>()
        let wordTrie:Trie<Character> = words.reduce(emptyTrie) { trie, word in
            trie.inserting(Array(word.characters).slice)
        }
        return wordTrie
    }
}

extension String {
    
    func complete(words:Trie<Character>) -> [String] {
        let charsOwn = Array(characters).slice
        let completed = words.complete(key: charsOwn)
        return completed.map { chars in
            self + String(chars)
        }
    }
}

let contents = ["cat", "car", "cart", "dog"]
let trieOfWords = Trie<Character>.build(words: contents)
print("ca".complete(words:trieOfWords))


//: [Next](@next)
