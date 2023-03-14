import Foundation
 
struct Heap<T: Comparable> {
  //elements: 실제로 데이터들을 저장할 이진트리로 표현될 배열
  var elements: [T] = []
    
  var isEmpty: Bool {
    return self.elements.count == 1
  }
  
  var count: Int {
    return self.elements.count - 1
  }
    
  init(_ data: T) {
      heap.append(0)  // 0번 index 채우기용 (인덱스로 바로 편리하게 접근하기 위함)
      heap.append(data)  // 실제 Root Node 채우기
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

  mutating func insert(node: T) { //mutating: 해당 메소드가 구조체 내부의 값을 변경한다는 것을 명시        
    if heap.isEmpty { //힙이 원래 비어있었다면 노드 자체가 힙이 됨
        heap.append(0)
        heap.append(node)
        return
    }
    heap.append(node)
    
    var insertIndex: Int = heap.count - 1
    while moveUp(insertIndex) {
        let parentIndex: Int = insertIndex / 2
        heap.swapAt(insertIndex, parentIndex)
        insertIndex = parentIndex
    }
  }

  mutating func moveUp(from index: Int) { //
    if insertIndex <= 1 {               // 루트 노드일 때
        return false
    }
    let parentIndex: Int = insertIndex / 2
    return heap[insertIndex] < heap[parentIndex] ? true : false
  }

  mutating func diveDown(from index: Int) { //삭제
    var higherPriority = index
    let leftIndex = self.leftChild(of: index)
    let rightIndex = self.rightChild(of: index)
    
    // 왼쪽 자식 노드가 더 우선순위가 높을 때
    if leftIndex < self.elements.endIndex && self.sortFunction(self.elements[leftIndex], self.elements[higherPriority]) {
        higherPriority = leftIndex
    }
    // 오른쪽 자식 노드가 더 우선순위가 높을 때
    if rightIndex < self.elements.endIndex && self.sortFunction(self.elements[rightIndex], self.elements[higherPriority]) {
        higherPriority = rightIndex
    }
    // 교환이 필요한 경우는 교환 후 서브트리로 이동
    if higherPriority != index {
        self.elements.swapAt(higherPriority, index)
        self.diveDown(from: higherPriority)
    }
  }
}