struct Queue<T> {
  var instack = [T]() //enqueue 담당 스택
  var outstack = [T]() //dequeue 담당 스택
  
  var isEmpty : Bool {
      return instack.isEmpty && outstack.isEmpty
  }
  var size: Int {
      return instack.count + outstack.count
  }
  
  mutating func enqueue(_ element: T) {
      instack.append(element)
  }
  
  mutating func dequeue() -> T? {
    if outstack.isEmpty {
        outstack = instack.reversed() //outstack reverse한 배열 넣고 input 비우기
        instack.removeAll()
    }
    return outstack.popLast()
  }

  var first: T? {
    if isEmpty {
      return nil
    }
    return outstack.isEmpty ? instack.first! : outstack.last!
  }
  
  var last: T? {
    if isEmpty {
      return nil
    }
    return instack.isEmpty ? outstack.first! : instack.last!
  }
}