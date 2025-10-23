# ppfront - 프로젝트 구조

> **이 문서는**: ppfront의 파일/디렉토리 구조를 설명합니다.
> **언제 보나**: "어디에 무엇이 있는지" 찾을 때
> **관련 문서**:
> - 아키텍처 패턴과 데이터 흐름: [architecture.md](architecture.md)
> - 전체 개요: [overview.md](overview.md)
> - 코딩 규칙: [code-style.md](code-style.md)

---

## 전체 디렉토리 구조

```
ppfront/
├── public/                  # 정적 파일
├── src/                     # 소스 코드
│   ├── @types/             # 커스텀 타입 정의
│   ├── assets/             # 정적 자산 (JSON, 설정 파일)
│   ├── components/         # Presentational 컴포넌트
│   ├── config/             # 앱 설정 (Redux store 등)
│   ├── containers/         # Container 컴포넌트 (로직 포함)
│   ├── hoc/                # Higher-Order Components
│   ├── hooks/              # Custom React Hooks
│   ├── images/             # 이미지 파일
│   ├── lib/                # 유틸리티 함수 및 헬퍼
│   ├── locales/            # i18n 번역 파일 (8개 언어)
│   ├── material/           # Material-UI 중앙 집중식 import
│   ├── modules/            # Redux 모듈 (액션, 리듀서)
│   ├── pages/              # 페이지 컴포넌트 (라우트별)
│   ├── sass/               # SCSS 스타일
│   ├── stylesheets/        # CSS 스타일시트
│   ├── types/              # TypeScript 타입 정의
│   ├── App.jsx             # 최상위 App 컴포넌트
│   ├── index.ts            # 진입점
│   └── vite-env.d.ts       # Vite 환경 타입 정의
├── tsconfig.json           # TypeScript 설정
├── vite.config.ts          # Vite 빌드 설정
└── package.json            # 의존성 관리
```

---

## 주요 디렉토리 상세

### 1. src/components/ - Presentational 컴포넌트

**역할**: UI 렌더링만 담당하는 컴포넌트. Redux와 직접 연결 없음.

**특징**:
- Props를 통해 데이터와 콜백 받음
- 재사용 가능하고 테스트하기 쉬운 구조
- Material-UI 컴포넌트 사용

**주요 디렉토리**:
```
components/
├── shared/                 # 공통 컴포넌트
├── layout/                 # 레이아웃 (GNB 등)
├── objective/              # 목표 UI
├── appraisal/              # 평가 UI
├── feedback/               # 피드백 UI
├── multi_source/           # 360 피드백 UI
├── one_on_one/             # 1:1 미팅 UI
├── review/                 # 리뷰 UI
├── task_board/             # 태스크보드 UI
├── scrum_board/            # 스크럼보드 UI
├── search/                 # 검색 UI
├── user_page/              # 사용자 페이지 UI
├── data_tab/               # 데이터 탭 UI
└── styled/                 # Styled Components
```

> **패턴 상세**: Container/Presentational 패턴은 [architecture.md#containerpresentational-패턴](architecture.md#containerpresentational-패턴) 참조

---

### 2. src/containers/ - Container 컴포넌트

**역할**: 비즈니스 로직 처리, Redux 연결, API 호출 등을 담당.

**특징**:
- `react-redux`의 `connect` HOC 사용
- Redux 액션 디스패치 및 상태 관리
- Presentational 컴포넌트에 props 전달

**주요 디렉토리**:
```
containers/
├── Route.jsx               # 라우팅 설정
├── main/                   # 메인 기능 (대시보드, GNB)
├── objective/              # 목표 관리
├── appraisal/              # 평가 관리
├── feedback/               # 피드백 관리
├── multi_source/           # 360 피드백 관리
├── one_on_one/             # 1:1 미팅 관리
├── review/                 # 리뷰 관리
├── task_board/             # 태스크보드 관리
├── scrum_board/            # 스크럼보드 관리
└── user_page/              # 사용자 페이지
```

> **데이터 흐름**: Container가 어떻게 동작하는지는 [architecture.md#데이터-흐름](architecture.md#데이터-흐름-data-flow) 참조

---

### 3. src/modules/ - Redux 모듈

**역할**: Redux 액션, 리듀서, 비동기 작업 관리 (Ducks 패턴 적용).

**주요 파일**:
```
modules/
├── index.js                # 루트 리듀서
├── objectives.js           # 목표 관리 모듈
├── appraisals.js           # 평가 관리 모듈 (117KB)
├── feedbacks.js            # 피드백 모듈
├── multi_sources.js        # 360 피드백 모듈
├── one_on_ones.js          # 1:1 미팅 모듈
├── reviews.js              # 리뷰 모듈
├── task_boards.js          # 태스크보드 모듈
├── scrum_boards.js         # 스크럼보드 모듈
├── dash_board.js           # 대시보드 모듈
├── notifications.js        # 알림 모듈 (레거시)
├── notificationsV2.ts      # 알림 모듈 v2
└── objectives/             # 목표 관련 서브 모듈
```

**특징**:
- **Redux Pender**: 비동기 작업 관리
- **Ducks 패턴**: 액션, 리듀서를 하나의 파일에 관리
- 일부 모듈은 TypeScript로 마이그레이션 중

> **Redux Pender 사용법**: [architecture.md#redux-pender](architecture.md#redux-pender) 참조
> **Ducks 패턴 상세**: [architecture-patterns.md#redux-ducks-패턴](architecture-patterns.md#2-redux-ducks-패턴)

**주의사항**:
- `appraisals.js`는 117KB로 매우 큼 (추후 분리 필요)

---

### 4. src/pages/ - 페이지 컴포넌트

**역할**: 라우트별 페이지 컴포넌트. Container를 조합하여 완성된 페이지 구성.

**주요 디렉토리**:
```
pages/
├── ErrorPage.jsx           # 에러 페이지
├── main/                   # 메인 페이지
├── objective/              # 목표 페이지
├── appraisal/              # 평가 페이지
├── feedback/               # 피드백 페이지
├── multi_source/           # 360 피드백 페이지
├── one_on_one/             # 1:1 미팅 페이지
├── review/                 # 리뷰 페이지
├── task_board/             # 태스크보드 페이지
├── scrum_board/            # 스크럼보드 페이지
└── user_page/              # 사용자 페이지
```

**특징**:
- React Router의 라우트 대상
- 여러 Container를 조합
- 페이지별 레이아웃 및 구성 관리

> **라우팅 구조**: [architecture.md#라우팅-구조](architecture.md#라우팅-구조) 참조

---

### 5. src/lib/ - 유틸리티 및 헬퍼

**역할**: 공통 유틸리티 함수, 헬퍼, 비즈니스 로직 공통 처리.

**주요 카테고리**:

**인증/권한**:
- `authenticate.js`: 인증 관련
- `axiauth.js`: Axios 인증 헬퍼 (12KB)
- `checkWorkspacePermission.ts`: 권한 체크

**데이터 처리**:
- `encrypt.ts`, `decrypt.ts`: 암호화/복호화
- `cookie.ts`: 쿠키 관리
- `download.js`, `excelDownload.ts`: 파일 다운로드

**조직/사용자**:
- `getDirectManager.ts`: 직속 상사 조회
- `getOrganizationIdsUntilRoot.js`: 조직 계층 조회
- `getUserOrganization.ts`: 사용자 조직 정보
- `getWorkspaceInfo.ts`: 워크스페이스 정보

**기능별 헬퍼**:
```
lib/
├── appraisal/              # 평가 관련 헬퍼 (14개 파일)
├── attendance/             # 근태 관련 헬퍼
├── feedback/               # 피드백 헬퍼
├── ibsheet/                # IBSheet 설정 (10개 파일)
├── error_message/          # 에러 메시지 관리
├── string/                 # 문자열 처리
└── time/                   # 날짜/시간 처리
```

> **API 호출 패턴**: [architecture.md#api-호출-패턴](architecture.md#api-호출-패턴) 참조

---

### 6. src/hooks/ - Custom React Hooks

**역할**: 재사용 가능한 React 커스텀 훅.

**주요 훅**:
```
hooks/
├── useDebounce.ts          # 디바운스 훅
├── useInput.ts             # 입력 관리
├── useToggleState.ts       # 토글 상태
├── usePrevious.ts          # 이전 값 추적
├── useIntersectionObserver.ts # Intersection Observer
├── appraisal/              # 평가 관련 훅 (9개)
├── AI_appraisal/           # AI 평가 훅 (4개)
├── AI_objective/           # AI 목표 훅 (3개)
└── workflow/               # 워크플로우 훅 (5개)
```

**특징**:
- 로직 재사용성 향상
- 기능별 디렉토리로 그룹화
- TypeScript 기반 대부분

---

### 7. src/locales/ - 다국어 지원

**역할**: i18n 번역 파일 관리.

**구조**:
```
locales/
├── i18n.ts                 # i18next 설정
├── ko/                     # 한국어
├── en/                     # 영어
├── ja-JP/                  # 일본어
├── zh-CN/                  # 중국어
├── id-ID/                  # 인도네시아어
├── vi-VN/                  # 베트남어
└── th-TH/                  # 태국어
```

**지원 언어**: 8개

**관리 방법**:
- `open-locales.js` 스크립트를 통해 번역 파일 편집
- i18next 21.8.11 사용

> **다국어 처리**: [architecture.md#다국어-처리](architecture.md#다국어-처리) 참조

---

### 8. src/material/ - Material-UI 중앙 집중식 import

**역할**: Material-UI 컴포넌트/아이콘을 중앙에서 관리.

**구조**:
```
material/
├── components/
│   └── index.js           # MUI 컴포넌트 (MUI 접두사)
├── icons/
│   └── index.js           # MUI 아이콘 (Icon 접미사)
└── styles/
    └── index.js           # 스타일 유틸리티
```

**네이밍 규칙**:
- 컴포넌트: `MUI` 접두사 (예: `MUIButton`, `MUITextField`)
- 아이콘: `Icon` 접미사 (예: `AddIcon`, `CheckIcon`)

> **Material-UI import 규칙**: [code-style.md#material-ui](code-style.md#2-material-ui) 참조

**이유**:
- Material-UI v4 → v5 마이그레이션 중
- 중앙 집중식 import로 버전 관리 및 일관성 유지

---

### 9. src/config/ - 설정 파일

**역할**: 앱 전역 설정 관리.

**주요 파일**:
```
config/
├── store.ts                # Redux Store 설정
├── env.ts                  # 환경 변수 관리
└── constants.ts            # 앱 상수 정의
```

> **Redux Store 설정**: [architecture.md#상태-관리](architecture.md#상태-관리-state-management) 참조

---

### 10. src/assets/ - 정적 자산

**역할**: JSON, 설정 파일 등 정적 자산 관리.

**특징**:
- 커스텀 설정 JSON
- 암호화된 추가 기능 설정 (`encrypted_additional_features_v2.json`)
- 고객사별 커스텀 데이터 (`cowayAppraisal/`, `innoceanAppraisal/`, `maeilAppraisal/`)
- S3 동기화 스크립트 (`encryptAdditionalFeatures.js`)

> **Workspace Hardcoding**: [architecture-patterns.md#workspace-hardcoding](architecture-patterns.md#3-workspace-specific-hardcoding-management) 참조

---

## 경로 별칭 (Path Aliases)

TypeScript와 Vite에서 사용하는 경로 별칭:

```typescript
"components/*"  → ./src/components/*
"containers/*"  → ./src/containers/*
"modules/*"     → ./src/modules/*
"pages/*"       → ./src/pages/*
"hooks/*"       → ./src/hooks/*
"lib/*"         → ./src/lib/*
"material/*"    → ./src/material/*
"locales/*"     → ./src/locales/*
"assets/*"      → ./src/assets/*
"config/*"      → ./src/config/*
```

**사용 예시**:
```typescript
// ✅ Good - 경로 별칭 사용
import { ObjectiveList } from 'components/objective/ObjectiveList';
import { getDirectManager } from 'lib/getDirectManager';
import { fetchObjectives } from 'modules/objectives';

// ❌ Bad - 상대 경로 사용 (ESLint 에러)
import { ObjectiveList } from '../../../components/objective/ObjectiveList';
```

> **코딩 규칙**: [code-style.md](code-style.md) 참조

---

## 파일 명명 규칙

### 컴포넌트 파일
- **React 컴포넌트**: PascalCase
  - `ObjectiveList.jsx`, `AppraisalCard.tsx`
- **Container 컴포넌트**: PascalCase + Container 접미사
  - `ObjectiveListContainer.jsx`

### 모듈 파일
- **Redux 모듈**: camelCase 또는 snake_case
  - `objectives.js`, `multi_sources.js`, `task_boards.js`

### 유틸리티 파일
- **헬퍼 함수**: camelCase
  - `getDirectManager.ts`, `handleLogout.ts`

### 페이지 파일
- **페이지 컴포넌트**: PascalCase
  - `ObjectivePage.jsx`, `ErrorPage.jsx`

---

## 모듈 경계

각 기능 영역별로 명확한 모듈 경계를 유지:

### 성과관리 (Performance Management)
- **목표**: `components/objective/`, `containers/objective/`, `modules/objectives.js`
- **피드백**: `components/feedback/`, `containers/feedback/`, `modules/feedbacks.js`
- **1:1**: `components/one_on_one/`, `pages/one_on_one/`, `modules/one_on_ones.js`
- **리뷰**: `components/review/`, `containers/review/`, `modules/reviews.js`

### 업무관리 (Task Management)
- **태스크보드**: `components/task_board/`, `containers/task_board/`, `modules/task_boards.js`
- **스크럼보드**: `components/scrum_board/`, `pages/scrum_board/`, `modules/scrum_boards.js`

### 360 진단 (Multi-source Feedback)
- `components/multi_source/`, `pages/multi_source/`, `modules/multi_sources.js`

### 평가관리 (Appraisal Management)
- `components/appraisal/`, `containers/appraisal/`, `modules/appraisals.js`
- `components/talenx_appraisal/`, `containers/talenx_appraisal/`

---

## 주의사항

### 1. 레거시 코드
- 일부 파일은 JavaScript (`.js`, `.jsx`)로 남아있음
- TypeScript 마이그레이션 진행 중

### 2. 큰 파일들
- `modules/appraisals.js`: 117KB (추후 분리 필요)
- `lib/axiauth.js`: 12KB

### 3. Material-UI 버전 혼재
- v4와 v5가 동시에 사용되고 있어 스타일 충돌 가능
- `material/` 폴더를 통한 중앙 집중식 import 필수

### 4. 커스텀 코드
- NHQV, 코웨이, 이노션, 매일 등 특정 고객사용 커스텀 코드 존재
- `components/custom/`, `assets/cowayAppraisal/` 등

---

## 관련 문서

- [architecture.md](architecture.md): 아키텍처 패턴, 데이터 흐름, 구현 플로우
- [overview.md](overview.md): ppfront 전체 개요 및 기능 영역
- [tech-stack.md](tech-stack.md): 기술 스택 상세
- [code-style.md](code-style.md): 코딩 규칙 및 컨벤션
- [core-files.md](core-files.md): 핵심 파일 상세
- [architecture-patterns.md](architecture-patterns.md): Container/Presentational, Redux Ducks, 평가 시스템
