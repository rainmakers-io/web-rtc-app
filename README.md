# 시작하기
1. flutter run --dart-define="env=.env.stag"

# 개발 가이드
1. 모바일(ios, ans), 웹을 지원하도록 개발한다.

# 코드 규칙
1. 클래스 명 
[Folder name][Name]
예: PageHome

2. 파일 규칙
```
atoms - 가장 기본 단위가 되는 공통 컴포넌트
molecules - atoms 컴포넌트 혹은 molecules 컴포넌트가 포함된 공통 컴포넌트, 하위에 그룹 폴더를 둘 수 있다(특정 비즈니스 종속 컴포넌트)
template - 틀을 만들어주는 컴포넌트
dialog - modal, alert, bottom sheet 등등 dialog 형태의 컴포넌트
```
