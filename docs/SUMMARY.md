# Flutter 7days TODO 학습 기록

## 개요
- 목표: Flutter 감각 회복 & 앱 출시 경험 (7일 완주)
- 스택: Provider + SharedPreferences (MVP 완성용)
- 기록: Day별 학습 목표 / 코드 설명 / 배운 점

## 진행 상황
- [x] Day 1 — 프로젝트 세팅 & 라우팅
- [x] Day 2 — Provider 상태관리 (TODO 추가/삭제/체크)
- [ ] Day 3 — UI 개선 & UX 향상
- [ ] Day 4 — 데이터 영구 저장
- [ ] Day 5 — 테마 & 다국어
- [ ] Day 6 — Firebase & 광고
- [ ] Day 7 — 배포 (Play Console/TestFlight)

# 📘 Flutter 7days TODO – 전체 과정 요약 (상세 & 체크리스트)

## Day 1 — 프로젝트 세팅 & 라우팅

* 🎯 목표: Flutter 환경 점검, Cursor IDE 프로젝트 생성, Home↔Detail 라우팅, Hot reload 체험
* 🛠️ 작업:

  * `flutter doctor` → 환경 점검
  * `flutter create flutter-7days-todo` → 프로젝트 생성 & 실행
  * `MaterialApp` + `routes` + `Navigator.pushNamed`
  * Hot reload / Hot restart 차이 확인
* ✅ DoD:

  * [x] 기본 앱 실행 성공
  * [x] Home→Detail 이동 동작 확인 (Detail 페이지 없음 - 홈페이지에서 모든 기능 구현)
  * [x] Hot reload 반영 체험

---

## Day 2 — 상태관리 (Provider)

* 🎯 목표: Provider + ChangeNotifier로 TODO 추가/체크/삭제
* 🛠️ 작업:

  * `provider` 패키지 설치
  * `Todo` 모델 작성
  * `TodoProvider` (add/toggle/remove + notifyListeners)
  * UI와 연결 (`context.watch`, `context.read`)
* ✅ DoD:

  * [x] TODO 항목 추가 가능
  * [x] 체크박스로 완료 처리
  * [x] 삭제 버튼으로 제거
  * [x] UI 자동 갱신 확인

---

## Day 3 — UI 개선 & UX 향상

* 🎯 목표: TODO 리스트 UI 다듬기 + 사용성 개선
* 🛠️ 작업:

  * `ListView.builder` + `Card`
  * 완료 항목 스타일(취소선/회색)
  * 스와이프 삭제(`Dismissible`)
  * 빈 상태 메시지 표시
* ✅ DoD:

  * [ ] 보기 좋은 TODO 목록
  * [ ] 스와이프 삭제 정상 동작
  * [ ] 빈 상태 시 안내 문구 표시

---

## Day 4 — 데이터 영구 저장

* 🎯 목표: SharedPreferences로 TODO 영구 저장
* 🛠️ 작업:

  * `shared_preferences` 패키지 설치
  * 앱 시작 시 `load()`, 상태 변경 시 `save()`
  * JSON 직렬화/역직렬화 처리
* ✅ DoD:

  * [ ] 앱 재실행 후에도 TODO 유지
  * [ ] 저장 실패 시 사용자 안내 처리

---

## Day 5 — 테마 & 다국어

* 🎯 목표: 다크모드 토글 + 다국어 지원(ko/en)
* 🛠️ 작업:

  * `ThemeData` 다크모드 적용
  * `flutter_localizations` + `intl`
  * 설정 화면에서 테마/언어 토글
* ✅ DoD:

  * [ ] 다크모드 토글 동작
  * [ ] 언어 전환 정상
  * [ ] 설정 값 저장/복원

---

## Day 6 — Firebase & 광고

* 🎯 목표: Firebase Analytics 이벤트 + AdMob 광고
* 🛠️ 작업:

  * Firebase 프로젝트 연동
  * 이벤트: `app_open`, `todo_add`, `todo_done`
  * AdMob 테스트 배너 광고 표시
* ✅ DoD:

  * [ ] 이벤트가 Firebase 콘솔에 기록됨
  * [ ] 기기에서 광고 정상 표시
  * [ ] 개인정보 고지 문구 추가

---

## Day 7 — 배포 (Play Console/TestFlight)

* 🎯 목표: 앱 아이콘/스플래시 적용 + 내부 배포
* 🛠️ 작업:

  * `flutter_launcher_icons`, `flutter_native_splash`
  * Android Internal Testing / iOS TestFlight 업로드
  * README + 스크린샷 + CHANGELOG 업데이트
* ✅ DoD:

  * [ ] 내부 테스트 배포 성공
  * [ ] 아이콘/스플래시 적용 확인
  * [ ] README/스크린샷/노트 정리

---

## 🎯 전체 학습 맥락

* 단순 스택 (Provider + SharedPreferences)으로 **완주** → 감각 회복
* 매일 **작은 DoD** 달성 → 성취감 유지
* Day 7까지 완료 후 → 리팩토링 과제로 Riverpod + Freezed + Isar/Drift 업그레이드