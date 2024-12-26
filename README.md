![haze영상1차 (2)](./346271410-d6ddaf9f-3fac-4c26-880e-d32be51aab76.gif)

# 시작하기
1. flutter run --dart-define="env=.env.stag"

## 웹으로 시작하기(디버깅 모드)
flutter run -d chrome --dart-define="env=.env.stag" --dart-define="web=true" --web-renderer html 

# android build
 - flutter build apk --release --target-platform=android-arm64

# 배포 
- 빌드 버전 변경 (추후 자동화 하기)
- flutter build appbundle


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
