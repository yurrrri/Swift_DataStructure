struct Queue<T> {
  var elements:[T] = []
  var head = 0 //맨 앞의 인덱스를 가리키는 프로퍼티

  var isEmpty: Bool {
    return elements.isEmpty
  }

  var count: Int {
    return elements.count
  }

  mutating func enqueue(_ element: T){
    elements.append(element)
  }

  // 1. 간단한 dequeue (removeFirst 사용) -> 시간복잡도 O(n)
  // mutating func dequeue() -> T? {
  //   if isEmpty {
  //     return nil
  //   }
  //   return elements.removeFirst() //선입선출
  // }

  // 2. 시간복잡도를 개선한 deque (removeFirst 사용 X) -> 시간복잡도 (O(1))
  mutating func dequeue() -> T? {
      guard head <= queue.count, let element = queue[head] else { return nil }
      queue[head] = nil
      head += 1
      return element
  }
}