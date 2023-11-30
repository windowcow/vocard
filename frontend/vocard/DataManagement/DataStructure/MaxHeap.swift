//
//  MaxHeap.swift
//  vocard
//
//  Created by windowcow on 11/27/23.
//

import SwiftData
import Foundation

@Model final class MaxHeap {
    var id: UUID {
        UUID()
    }
    
    var elements: [WordDataModel] = []

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var count: Int {
        return elements.count
    }
    
    init(elements: [WordDataModel]) {
        self.elements = elements
    }

    func insert(_ element: WordDataModel) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }

    func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(of: child)

        while child > 0 && elements[child] > elements[parent] {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(of: child)
        }
    }

    func pop() -> WordDataModel? {
        guard !isEmpty else {
            return nil
        }

        elements.swapAt(0, count - 1)
        let element = elements.removeLast()
        siftDown(from: 0)
        return element
    }

    func siftDown(from index: Int) {
        var parent = index

        while true {
            let leftChild = leftChildIndex(of: parent)
            let rightChild = rightChildIndex(of: parent)
            var candidate = parent

            if leftChild < count && elements[leftChild] > elements[candidate] {
                candidate = leftChild
            }

            if rightChild < count && elements[rightChild] > elements[candidate] {
                candidate = rightChild
            }

            if candidate == parent {
                return
            }

            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }

    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }

    func leftChildIndex(of index: Int) -> Int {
        return index * 2 + 1
    }

    func rightChildIndex(of index: Int) -> Int {
        return index * 2 + 2
    }
}
