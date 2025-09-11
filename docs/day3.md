좋습니다 👍
그럼 \*\*Day 3 문서 (docs/day3.md)\*\*를 준비해드릴게요.
👉 목표는 **UI 개선 & UX 향상** → 리스트 보기 좋게, 완료 스타일, 스와이프 삭제, 빈 상태 표시.

---

# 📘 docs/day3.md — UI 개선 & UX 향상

## 🎯 학습 목표

* TODO 리스트 UI를 더 보기 좋게 다듬기
* 완료 항목 스타일링 (취소선, 회색 처리)
* 스와이프 삭제 기능 (`Dismissible`)
* TODO가 없을 때 빈 상태 메시지 표시

---

## 🛠️ 단계별 진행

### 1. TODO 리스트 카드 형태

```dart
ListView.builder(
  itemCount: provider.todos.length,
  itemBuilder: (context, index) {
    final todo = provider.todos[index];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (_) => provider.toggle(index),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
            color: todo.isDone ? Colors.grey : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => provider.remove(index),
        ),
      ),
    );
  },
)
```

* `Card`: 리스트 아이템을 카드 형태로 표시 → 가독성↑
* 완료 항목: 취소선 + 회색 처리

---

### 2. 스와이프 삭제 (`Dismissible`)

```dart
return Dismissible(
  key: ValueKey(todo.title + index.toString()),
  background: Container(color: Colors.red),
  onDismissed: (_) => provider.remove(index),
  child: Card(
    child: ListTile(
      title: Text(todo.title),
    ),
  ),
);
```

* 왼/오른쪽 스와이프 → 자동으로 삭제
* UX 자연스러움 추가

---

### 3. 빈 상태 표시

```dart
body: provider.todos.isEmpty
  ? const Center(
      child: Text(
        "할 일이 없습니다",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    )
  : ListView.builder(
      itemCount: provider.todos.length,
      itemBuilder: ...
    )
```

* 할 일이 없을 때 “할 일이 없습니다” 표시

---

### 4. 긴 제목 처리

```dart
title: Text(
  todo.title,
  overflow: TextOverflow.ellipsis,
),
```

* 너무 긴 제목은 말줄임(...) 처리

---

## 📊 동작 흐름

```
사용자 입력 → TodoProvider.add()
    ↓
ListView.builder에서 새로운 Todo 아이템 생성
    ↓
완료 체크박스 → toggle()
스와이프(Dismissible) → remove()
    ↓
notifyListeners()
    ↓
UI 자동 리빌드
```

---

## 📝 개념 보강

* **ListView\.builder**: 대량 데이터에 최적화된 리스트 빌더
* **Card/ListTile**: 머티리얼 디자인 기본 요소 → 일관된 UI 제공
* **Dismissible**: 스와이프 제스처로 리스트 항목 제어
* **Empty State**: UX에서 빈 화면도 친절히 안내해야 사용자 경험이 좋아짐

---

## 🔥 오늘 배운 점

* Flutter UI 구성은 위젯 조합(Row/Column/Card)으로 직관적이다
* Dismissible 같은 머티리얼 컴포넌트로 **UX 강화**가 쉽다
* 단순 기능 구현뿐 아니라 **사용성/가독성까지 고려하는 것**이 중요

---

## ✅ DoD (완료 정의)

* [x] 카드 스타일 TODO 리스트
* [x] 완료 항목 취소선/회색 처리
* [x] 스와이프 삭제 동작
* [x] 빈 상태 안내 표시
* [x] 긴 제목 말줄임 처리