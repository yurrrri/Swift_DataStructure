import Foundation

//최소힙 기준
struct Heap<T: Comparable> { //Comparable : 비교 연산을 위한 프로토콜
  //heap: 실제로 데이터들을 저장할 이진트리로 표현될 배열
  var heap: [T] = []
    
  var isEmpty: Bool {
    return heap.count <= 1
  }
  
  var count: Int {
    return heap.count - 1 //0을 추가했으므로 이걸 제외할 필요 있음
  }

  init() { }
  init(_ element: T) {
      heap.append(element) // 0번 index채우기 용
      heap.append(element) // 실제 Root Node 채우기
  }
  
  func leftChild(of index: Int) -> Int { //자식 인덱스 (부모 왼쪽에 있는 인덱스)
    return index * 2
  }
  
  func rightChild(of index: Int) -> Int { //형제 인덱스 (부모 오른쪽에 있는 인덱스)
    return index * 2 + 1
  }
  
  func parent(of index: Int) -> Int { //부모 인덱스
    return (index) / 2
  }

  mutating func insert(_ node: T) { //데이터 삽입
    if heap.isEmpty { //힙이 원래 비어있었다면 노드 자체가 힙이 됨
        heap.append(node)
        heap.append(node)
        return
    }
    heap.append(node) // 1. 일단 넣음(데이터 비교와는 상관없이)

    func isMoveUp(_ insertIndex: Int) -> Bool { // 2. 자기보다 작은 부모 노드의 인덱스를 찾는 과정
      if insertIndex <= 1 {  // 루트 노드일 때 -> 찾는 부모 노드가 없음
          return false
      }
      let parentIndex = insertIndex / 2
      return heap[insertIndex] < heap[parentIndex] ? true : false
    }
    
    var insertIndex = heap.count - 1
    while isMoveUp(insertIndex) { //2. 자기 자리를 찾아갈때까지 위로 감 (나보다 작은 부모노드를 찾을때까지)
        let parentIndex = insertIndex / 2
        heap.swapAt(insertIndex, parentIndex)
        insertIndex = parentIndex
    }
  }

  enum moveDownStatus { case none, left, right }

  mutating func pop() -> T? { //삭제
    if heap.count <= 1 { return nil }
    
    let poped = heap[1]
    heap.swapAt(1, heap.count - 1) //1. 부모노드랑 자리를 바꾼다음 마지막껄 지워냄
    heap.removeLast()
    
    func moveDown(_ poppedIndex: Int) -> moveDownStatus { // 어떻게 이동할 지에 대한 조건 지정
      let leftChildIndex = (poppedIndex * 2)
      let rightChildIndex = leftChildIndex + 1
      
      // case 1. 모든(왼쪽) 자식 노드가 없는 경우 (완전이진트리는 왼쪽부터 채워지므로, 이게 없으면 다 없는것임)
      if leftChildIndex >= heap.count {
          return .none
      }
      
      // case 2. 왼쪽 자식 노드만 있는 경우
      if rightChildIndex >= heap.count {
          return heap[leftChildIndex] < heap[poppedIndex] ? .left : .none //왼쪽 자식노드와 비교하여 왼쪽 자식노드가 작다면 그와 스와핑 해야함
      }
      
      // case 3. 왼쪽 & 오른쪽 자식 노드 모두 있는 경우
      // case 3-1. 자식들이 자신보다 모두 큰 경우
      if (heap[leftChildIndex] > heap[poppedIndex]) && (heap[rightChildIndex] > heap[poppedIndex]) {
          return .none
      }
      
      // case 3-2. 자식들이 자신보다 모두 작은 경우 (왼쪽과 오른쪽 자식 중 더 작은 자식 선별)
      if (heap[leftChildIndex] < heap[poppedIndex]) && (heap[rightChildIndex] < heap[poppedIndex]) {
          return heap[leftChildIndex] < heap[rightChildIndex] ? .left : .right
      }
      
      // case 3-3. 왼쪽 & 오른쪽 중 한 자식만 자신보다 작은 경우
      if (heap[leftChildIndex] < heap[poppedIndex]) || (heap[rightChildIndex] < heap[poppedIndex]) {
        return heap[leftChildIndex] < heap[poppedIndex] ? .left : .right
      }
        
      return .none
    }
    
    var poppedIndex = 1
    while true { //2. 이동한 루트 노드가 왼쪽, 오른쪽 자식 노드보다 작을 때까지 바꾸는 작업 진행
      switch moveDown(poppedIndex) {
      case .none:
          return poped
      case .left:
          let leftChildIndex = poppedIndex * 2
          heap.swapAt(poppedIndex, leftChildIndex)
          poppedIndex = leftChildIndex
      case .right:
          let rightChildIndex = (poppedIndex * 2) + 1
          heap.swapAt(poppedIndex, rightChildIndex)
          poppedIndex = rightChildIndex
      }
    }
  }
}

struct PriorityQueue<T: Comparable> {
    var heap = Heap<T>()
    
    var count : Int {
        return heap.count
    }
    
    var isEmpty : Bool {
        return heap.isEmpty
    }
    
    mutating func pop() -> T? {
        return heap.pop()
    }
    
    mutating func insert(_ element: T) {
        heap.insert(element)
    }
}