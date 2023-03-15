struct Queue<T> {
  var input = [T]()
  var output = [T]()
  
  var isEmpty : Bool {
      return input.isEmpty && output.isEmpty
  }
  var size: Int {
      return input.count + output.count
  }
  
  mutating func enqueue(element: T) {
      input.append(element)
  }
  
  mutating func dequeue() -> T {
    if output.isEmpty {
        output = input.reversed() //output에 reverse한 배열 넣고 input 비우기
        input.removeAll()
    }
    return output.removeLast()
  }

  var first: T? {
    if isEmpty {
      return nil
    }
    return output.isEmpty ? input.first : output.last
  }
  
  var last: T? {
    if isEmpty {
      return nil
    }
    return input.isEmpty ? output.first : input.last
  }
}