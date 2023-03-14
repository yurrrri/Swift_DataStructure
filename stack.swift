struct Stack<T> {
  var elements:[T] = []
  var top = -1

  var isEmpty: Bool {
    return elements.isEmpty
  }

  var count: Int {
    return elements.count
  }

  mutating func push(_ element: T){
    elements.append(element)
    self.top += 1
  }

  mutating func pop() -> T? {
    if isEmpty {
      return nil
    }
    self.top -= 1
    return elements.popLast()
  }

  func peek() -> T? {
    if isEmpty {
      return nil
    }
    return elements.last
  }
}