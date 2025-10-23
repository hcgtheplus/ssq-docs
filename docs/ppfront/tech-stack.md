# ppfront - 기술 스택

ppfront 프로젝트에서 사용하는 모든 기술 스택에 대한 상세 정보입니다.

---

## Core Technologies

### React 17.0.2

- **역할**: UI 라이브러리
- **선택 이유**: 컴포넌트 기반 아키텍처, 풍부한 생태계
- **주의사항**: React 18이 아닌 17 버전 사용 중 (추후 업그레이드 필요)
- **주요 패턴**:
  - Container/Presentational 패턴 (Dan Abramov의 패턴)
  - Presentational: UI 렌더링만 담당, props로 데이터와 콜백 받음
  - Container: 비즈니스 로직, Redux 연결, API 호출 담당
- **참고**: [ppfront wiki - Container and Presentational Component](https://github.com/hcgtheplus/ppfront.wiki/blob/master/08.-Container-and-Presentational-Component.md)

### TypeScript 4.5.4

- **역할**: 타입 안전성 제공
- **설정**: Strict Mode 활성화
- **경로 별칭**: 17개 경로 매핑 (`components/*`, `containers/*` 등)
- **주의사항**: noUnusedLocals, noUnusedParameters 활성화

### Vite 4.3.2

- **역할**: 빌드 도구 및 개발 서버
- **포트**: 3000
- **특징**:
  - 빠른 HMR (Hot Module Replacement)
  - 자동 코드 스플릿
  - 청크 크기 경고: 4096KB
- **플러그인**:
  - @vitejs/plugin-react
  - vite-plugin-node-polyfills
  - vite-tsconfig-paths
  - vite-plugin-checker (ESLint)
  - vite-plugin-pwa
  - @sentry/vite-plugin

---

## State Management

### Redux 3.7.1

- **역할**: 전역 상태 관리
- **관련 라이브러리**:
  - redux-thunk 2.2.0: 비동기 액션
  - redux-pender 2.0.12: 비동기 작업 관리
  - redux-actions 2.0.3: 액션 생성 헬퍼
  - react-redux 7.2.4: React 바인딩
- **위치**: [src/modules/](../../ppfront/src/modules)
- **Store 설정**: [src/config/store.ts](../../ppfront/src/config/store.ts)

### TanStack React Query v4

- **역할**: 서버 상태 관리
- **사용처**: API 데이터 페칭 및 캐싱
- **선택 이유**: Redux와 분리하여 서버 상태 관리

---

## UI Framework

### Material-UI (MUI)

#### v4 (레거시)

- @material-ui/core 4.12.2
- @material-ui/icons 4.11.2
- @material-ui/lab 4.0.0-alpha.60
- @material-ui/styles 4.11.4
- **상태**: 점진적으로 v5로 마이그레이션 중

#### v5 (현재)

- @mui/material 5.13.0
- @mui/icons-material 5.11.16
- @mui/lab 5.0.0-alpha.150
- @mui/styles 5.12.3
- @mui/system 6.1.6
- @mui/x-data-grid-pro 7.22.1 (라이센스 필요)
- @mui/x-date-pickers 7.22.3
- @mui/x-date-pickers-pro 7.22.3
- @mui/x-tree-view 6.17.0
- @mui/x-license 7.21.0

**주의사항**: v4와 v5가 동시에 사용되고 있어 스타일 충돌 가능성 있음

### CSS-in-JS

#### Emotion

- @emotion/react 11.11.0
- @emotion/styled 11.11.0
- **역할**: MUI v5의 기본 스타일링 엔진

#### TSS React 4.9.16

- **역할**: Material-UI와 TypeScript를 위한 스타일링
- **사용처**: MUI 컴포넌트 커스터마이징

### 기타 UI

- **Material Design Lite**: 레거시 컴포넌트 일부 사용
- **material-design-icons-iconfont**: 아이콘 폰트
- **clsx**: 조건부 클래스명 결합

---

## Data Grid & Tables

### AG Grid Enterprise 33.1.1

- **라이센스**: 상용 라이센스 필요
- **역할**: 메인 데이터 그리드
- **관련 패키지**:
  - ag-grid-react 33.1.1
  - ag-grid-enterprise 33.1.1
  - ag-charts-enterprise 11.1.1
  - ag-charts-react 11.1.1
- **사용처**: 대용량 데이터 테이블, 차트

### React Table 6.8.6

- **역할**: 경량 테이블 라이브러리
- **사용처**: 간단한 데이터 테이블

### IBSheet 1.1.25

- **역할**: 레거시 스프레드시트 컴포넌트
- **상태**: 유지보수 모드
- **설정**: [src/lib/ibsheet/](../../ppfront/src/lib/ibsheet)

---

## Charts & Visualization

### Echarts 4.2.0-rc.2

- **역할**: 고급 차트 라이브러리
- **관련**: echarts-for-react 2.0.15-beta.0
- **사용처**: 대시보드, 통계 차트

### Recharts 2.1.1

- **역할**: React 네이티브 차트
- **사용처**: 간단한 차트 시각화

### D3 7.8.5

- **역할**: 데이터 시각화 라이브러리
- **관련**: d3-cloud 1.2.7 (워드클라우드)
- **사용처**: 커스텀 시각화

---

## Forms & Input

### Formik 2.2.5

- **역할**: 폼 상태 관리
- **사용처**: 복잡한 폼 validation

### React Select 2.1.0

- **역할**: 고급 드롭다운
- **특징**: 검색, 다중 선택 지원

### React Widgets 4.4.11

- **역할**: UI 위젯 모음
- **관련**: react-widgets-moment 4.0.27

### Date & Time

- **flatpickr 4.6.2**: 날짜 선택기
- **react-flatpickr 3.9.0**: React 래퍼
- **moment 2.29.4**: 날짜 처리

### Others

- **react-number-format 4.7.3**: 숫자 포맷팅
- **react-phone-number-input 3.3.9**: 전화번호 입력
- **react-color 2.17.3**: 색상 선택기
- **react-daum-postcode 3.1.3**: 주소 검색

---

## Document Processing

### PDF

- **react-pdf-viewer** 3.12.0: PDF 뷰어
  - @react-pdf-viewer/core
  - @react-pdf-viewer/default-layout
  - @react-pdf-viewer/get-file
  - @react-pdf-viewer/page-navigation
  - @react-pdf-viewer/print
  - @react-pdf-viewer/zoom
- **pdfjs-dist** 3.4.120: PDF.js
- **react-pdf** 7.7.3: PDF 렌더링
- **jspdf** 3.0.1: PDF 생성
- **html2pdf.js** 0.10.3: HTML to PDF

### Excel

- **xlsx** 0.18.5: Excel 파일 읽기/쓰기
- **xlsx-populate** 1.21.0: Excel 파일 조작

### Rich Text Editor

- **react-froala-wysiwyg** 4.0.8: WYSIWYG 에디터
- **라이센스**: 상용 라이센스 필요

### Others

- **html2canvas** 1.4.1: 캔버스 렌더링
- **react-markdown** 8.0.7: 마크다운 렌더링
- **html-react-parser** 1.4.8: HTML 파싱

---

## Internationalization (i18n)

### i18next 21.8.11

- **역할**: 다국어 지원
- **관련**: react-i18next 11.17.4
- **지원 언어**: 8개
  - 한국어 (ko)
  - 영어 (en)
  - 일본어 (ja-JP)
  - 중국어 (zh-CN)
  - 인도네시아어 (id-ID)
  - 베트남어 (vi-VN)
  - 태국어 (th-TH)
- **설정**: [src/locales/i18n.ts](../../ppfront/src/locales/i18n.ts)
- **관리**: open-locales.js 스크립트

### josa 3.0.1

- **역할**: 한국어 조사 처리
- **사용처**: 한국어 문장 생성

---

## Networking & API

### Axios 1.7.9

- **역할**: HTTP 클라이언트
- **특징**: Interceptors, 자동 변환

### Rails ActionCable 7.0.5

- **역할**: WebSocket 통신
- **사용처**: 실시간 알림, 업데이트

---

## Utilities

### Data Manipulation

- **lodash** 4.17.15: 유틸리티 함수
- **immutable** 3.8.1: 불변 데이터 구조
- **react-immutable-proptypes** 2.1.0: PropTypes

### String & Case

- **camelcase** 6.2.1: camelCase 변환
- **camelcase-keys** 9.1.3: 객체 키 변환
- **snakecase-keys** 8.0.1: snake_case 변환
- **change-case-object** 2.0.0: 케이스 변환
- **escape-string-regexp** 5.0.0: 정규식 이스케이프

### Crypto & Security

- **crypto-js** 4.2.0: 암호화
- **node-rsa** 1.1.1: RSA 암호화
- **base64url** 3.0.1: Base64 인코딩

### Number & Math

- **big.js** 6.2.0: 정밀한 숫자 계산
- **bfj** 7.0.2: Big Friendly JSON

### Others

- **uuid** 9.0.1: UUID 생성
- **query-string** 6.13.8: URL 쿼리스트링
- **browser-cookies** 1.2.0: 쿠키 관리

---

## UI Interactions

### Drag & Drop

- **sortablejs** 1.6.1: 드래그 정렬
- **react-sortablejs** 1.5.1: React 래퍼

### Modals & Notifications

- **notistack** 3.0.1: 스낵바 알림
- **sweetalert2** 10.0.0: 모달 다이얼로그
- **sweetalert2-react-content** 3.2.2: React 래퍼
- **react-modal** 3.12.1: 모달

### Others

- **react-dropzone** 8.0.3: 파일 업로드
- **react-copy-to-clipboard** 5.0.4: 클립보드 복사
- **react-swipeable** 7.0.1: 스와이프 제스처
- **react-swipeable-views** 0.14.0: 스와이프 뷰
- **react-archer** 4.4.0: 다이어그램 연결선
- **qrcode.react** 3.1.0: QR 코드 생성
- **tributejs** 5.1.3: 멘션 기능

---

## Special Libraries

### Notion Integration

- **notion-types** 6.16.0: Notion 타입
- **react-notion-x** 6.15.8: Notion 렌더링

### Microsoft Teams

- **@microsoft/teams-js** 1.11.0: Teams 통합

### Google Maps

- **@react-google-maps/api** 2.19.2: 구글 맵

---

## Monitoring & Performance

### Sentry 7.56.0

- **역할**: 에러 트래킹
- **플러그인**: @sentry/vite-plugin 2.16.1
- **사용처**: 프로덕션 에러 모니터링

### PWA

- **vite-plugin-pwa** 0.19.5: PWA 지원
- **workbox-precaching** 6.4.2: 캐싱 전략

### Web Vitals 2.1.2

- **역할**: 성능 지표 측정
- **사용처**: Core Web Vitals 추적

---

## Development Tools

### TypeScript

- **typescript** 4.5.4
- **@types/\***: 다양한 타입 정의 패키지

### Linting & Formatting

- **eslint** 8.6.0
- **eslint-config-prettier** 8.3.0
- **eslint-plugin-import** 2.28.1
- **eslint-plugin-react** 7.33.2
- **eslint-plugin-react-hooks** 4.6.2
- **eslint-plugin-jsx-a11y** 6.9.0
- **@typescript-eslint/eslint-plugin** 5.48.0
- **@typescript-eslint/parser** 5.48.0
- **prettier-eslint-cli** 4.7.1

### Testing

- **jest** 29.7.0
- **jest-environment-jsdom** 29.7.0
- **@testing-library/jest-dom** 6.6.3
- **@playwright/test** 1.29.2: E2E 테스트
- **babel-jest** 29.7.0

### Git Hooks

- **husky** 2.4.1: Git hooks
- **lint-staged** 15.2.7: Staged 파일 lint

### Build Tools

- **babel** 관련 패키지:
  - @babel/core 7.26.10
  - @babel/preset-env 7.26.9
  - @babel/preset-react 7.26.3
  - @babel/preset-typescript 7.27.0
- **sass** 1.57.1: SCSS 컴파일
- **@svgr/rollup** 8.1.0: SVG to React

### Environment & Config

- **env-cmd** 10.1.0: 환경변수 관리
- **node-credentials** 1.6.0: 암호화된 설정

### Others

- **patch-package** 8.0.0: 의존성 패치
- **html-to-text** 9.0.5: HTML to 텍스트
- **diff-match-patch** 1.0.5: 텍스트 diff

---

## 버전 관리 정책

### Major Version Updates

- React 17 → 18 업그레이드 계획 중
- Material-UI v4 → v5 마이그레이션 진행 중

### Security Updates

- 정기적인 보안 패치 적용
- Dependabot 활용

### Breaking Changes

- 주요 버전 업그레이드 시 충분한 테스트 기간 확보
- 점진적 마이그레이션 전략

---

## 라이센스 관리

### 상용 라이센스 필요

- **AG Grid Enterprise**: 데이터 그리드
- **react-froala-wysiwyg**: 리치 텍스트 에디터
- **@mui/x-\***: MUI X 컴포넌트

### 주의사항

- 라이센스 만료 주기 관리
- 프로덕션 배포 전 라이센스 확인

---

## 성능 고려사항

### 번들 크기

- **청크 크기 경고**: 4096KB
- **자동 코드 스플릿**: node_modules별 분리
- **CSS 코드 스플릿**: 비활성화 (성능 이슈)

### 빌드 메모리

- **필수 설정**: `--max-old-space-size=8192`
- **이유**: 대용량 번들 빌드

### 최적화

- Tree Shaking 활성화
- Dynamic Import 활용
- 이미지 최적화

---

## 다음 문서

- [project-structure.md](project-structure.md): 프로젝트 구조 상세
- [code-style.md](code-style.md): 코딩 규칙 및 컨벤션
- [overview.md](overview.md): ppfront 전체 개요
