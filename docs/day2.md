# 📘 docs/day2.md — Provider 상태관리

## 🎯 학습 목표

* Provider + ChangeNotifier로 TODO 상태 관리
* TODO 항목 추가/체크/삭제 구현
* 상태 변경 시 UI가 자동 갱신되는 흐름 이해

---

## 🛠️ 단계별 진행

### 1. 패키지 설치

```bash
flutter pub add provider
```

👉 pubspec.yaml에 `provider`가 추가되고, 자동으로 `flutter pub get` 실행됨

---

### 2. 모델 작성 (`lib/models/todo.dart`)

```dart
class Todo {
  String title;
  bool isDone;

  Todo({
    required this.title,
    this.isDone = false,
  });
}
```

* `title`: 할 일 내용
* `isDone`: 완료 여부 (기본 false)

---

### 3. 상태 관리 Provider (`lib/providers/todo_provider.dart`)

```dart
import 'package:flutter/foundation.dart';
import '../models/todo.dart';

class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void add(String title) {
    _todos.add(Todo(title: title));
    notifyListeners();
  }

  void toggle(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    notifyListeners();
  }

  void remove(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
```

* `ChangeNotifier` : Flutter 내장 상태 관리 클래스
* `notifyListeners()` 호출 시 → UI 자동 갱신

---

### 4. Provider 앱에 등록 (`lib/main.dart`)

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/todo_provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '7days TODO',
      home: const HomePage(),
    );
  }
}
```

* `ChangeNotifierProvider` : TodoProvider를 전역 주입

---

### 5. HomePage UI (`lib/pages/home_page.dart`)

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('TODO App')),
      body: ListView.builder(
        itemCount: provider.todos.length,
        itemBuilder: (context, index) {
          final todo = provider.todos[index];
          return ListTile(
            title: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            leading: Checkbox(
              value: todo.isDone,
              onChanged: (_) => provider.toggle(index),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => provider.remove(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final controller = TextEditingController();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Add TODO'),
              content: TextField(controller: controller),
              actions: [
                TextButton(
                  onPressed: () {
                    provider.add(controller.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                )
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

* `context.watch<TodoProvider>()` → 상태를 구독, 값이 바뀌면 UI 리빌드
* TODO 추가 = 다이얼로그 → Provider에 add()

---

## 📝 코드 설명 요약

* **모델**: `Todo(title, isDone)` 단순 데이터
* **Provider**: 상태 + `notifyListeners()`로 UI 갱신
* **UI**: Provider의 상태를 구독(context.watch), 변화 시 자동 반영
* **추가**: FloatingActionButton → 다이얼로그 → add() 호출
* **삭제/토글**: 버튼/체크박스로 provider 메서드 호출

---

## 🔥 오늘 배운 점

* `Provider`는 앱 전체에서 상태를 공유하는 가장 간단한 방법
* `notifyListeners()` → `context.watch` 위젯 자동 리빌드
* 상태 관리와 UI 연결을 **명시적으로 분리**하는 게 유지보수에 유리

---

## ✅ DoD (완료 정의)

* [x] TODO 추가 동작
* [x] 체크박스로 완료 표시
* [x] 삭제 버튼 정상 동작
* [x] UI 자동 갱신 확인


좋습니다 👍
카야님이 원하시는 건 **Provider 흐름 요약**이군요.
즉, "main에 선언 → UI에서 watch/read로 사용 → notifyListeners()로 갱신" 같은 단순 플로우 정리.

---

# 📊 Provider 흐름 간단 정리

## 1. Provider 등록 (main.dart)

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoProvider(), // 인스턴스 생성 & 등록
      child: const MyApp(),
    ),
  );
}
```

* `create:` → **인스턴스 생성 & Provider 트리에 등록**
* 이 아래 모든 위젯은 `TodoProvider`에 접근 가능

---

## 2. Provider 사용 (UI 위젯 내부)

```dart
final provider = context.watch<TodoProvider>();
```

* **watch** → 인스턴스를 가져오고 구독 (상태 바뀌면 build 다시 실행)
* **read** → 인스턴스를 가져오기만 (구독 X, 주로 버튼 이벤트)

예시:

```dart
onPressed: () {
  context.read<TodoProvider>().add("New TODO");
}
```

---

## 3. 상태 변경 (Provider 내부)

```dart
void add(String title) {
  _todos.add(Todo(title: title));
  notifyListeners(); // 구독 중인 위젯들에게 "갱신됐어!" 알림
}
```

* `notifyListeners()` → watch 중인 위젯들이 다시 build

---

## 4. UI 자동 갱신

```dart
ListView.builder(
  itemCount: provider.todos.length,
  itemBuilder: (context, index) {
    final todo = provider.todos[index];
    return Text(todo.title);
  },
)
```

* Provider의 상태(`todos`)를 UI에 바인딩
* 값이 바뀌면 자동으로 새 상태로 다시 그려짐

---

# 📌 전체 플로우 한눈에

```
main.dart
  ↓ (create) TodoProvider 인스턴스 등록
HomePage (context.watch)
  ↓
사용자 이벤트 (FAB, Checkbox, Delete 버튼)
  ↓ (context.read)
TodoProvider.add / toggle / remove
  ↓
notifyListeners()
  ↓
watch 중인 UI 위젯 자동 build
  ↓
새 상태가 반영된 UI 출력
```

---

✅ 정리:

* **등록은 main에서 create**
* **읽기는 watch/read**
* **변경은 notifyListeners()**
* **UI는 자동 갱신**

---
