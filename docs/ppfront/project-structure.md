# ppfront - 프로젝트 구조

ppfront 프로젝트의 디렉토리 구조와 각 디렉토리의 역할에 대한 상세 정보입니다.

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
│   ├── material/           # Material-UI 커스터마이징
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

**역할**: UI 렌더링만 담당하는 순수 컴포넌트. 비즈니스 로직 없음.

**구조**:
```
components/
├── shared/                 # 공통 컴포넌트
├── layout/                 # 레이아웃 컴포넌트
├── objective/              # 목표 관련 UI
├── appraisal/              # 평가 관련 UI
├── feedback/               # 피드백 관련 UI
├── multi_source/           # 360 피드백 UI
├── one_on_one/             # 1:1 미팅 UI
├── review/                 # 리뷰 UI
├── task/                   # 태스크 UI
├── task_board/             # 태스크보드 UI
├── scrum_board/            # 스크럼보드 UI
├── attendance/             # 근태 UI
├── hrm/                    # 인사 관리 UI
├── workflow/               # 워크플로우 UI
├── notification/           # 알림 UI
├── search/                 # 검색 UI
├── user_page/              # 사용자 페이지 UI
├── data_tab/               # 데이터 탭 UI
├── calendar/               # 캘린더 UI
├── account/                # 계정 관련 UI
├── pay/                    # 급여 UI
├── talent_session/         # 인재 세션 UI
├── workspace/              # 워크스페이스 UI
├── history/                # 이력 UI
├── management_notification/ # 관리 알림 UI
├── styled/                 # Styled Components
├── AI_appraisal/           # AI 평가 UI
├── talenx_appraisal/       # Talenx 평가 UI
├── main/                   # 메인 페이지 UI
└── custom/                 # 커스텀 UI (NHQV, 코웨이 등)
```

**특징**:
- Props를 통해 데이터와 콜백 받음
- Redux store에 직접 접근하지 않음
- 재사용 가능하고 테스트하기 쉬운 구조

---

### 2. src/containers/ - Container 컴포넌트

**역할**: 비즈니스 로직 처리, Redux 연결, API 호출 등을 담당.

**구조**:
```
containers/
├── Route.jsx               # 라우팅 설정
├── main/                   # 메인 기능 (대시보드, GNB 등)
├── objective/              # 목표 관리
├── appraisal/              # 평가 관리
├── feedback/               # 피드백 관리
├── multi_source/           # 360 피드백 관리
├── one_on_one/             # 1:1 미팅 관리
├── review/                 # 리뷰 관리
├── task/                   # 태스크 관리
├── task_board/             # 태스크보드 관리
├── task_list/              # 태스크 리스트 관리
├── scrum_board/            # 스크럼보드 관리
├── attendance/             # 근태 관리
├── hrm/                    # 인사 관리
├── workflow/               # 워크플로우 관리
├── history/                # 이력 관리
├── user_page/              # 사용자 페이지
├── search/                 # 검색 기능
├── account/                # 계정 관리
├── pay/                    # 급여 관리
├── talent_session/         # 인재 세션 관리
├── talenx_appraisal/       # Talenx 평가 관리
├── workspace/              # 워크스페이스 관리
├── whats_new/              # 새로운 기능 안내
├── manual/                 # 매뉴얼
├── menu/                   # 메뉴 관리
├── layout/                 # 레이아웃 관리
└── security/               # 보안 관리
```

**특징**:
- `react-redux`의 `connect` HOC 사용
- Redux 액션 디스패치
- API 호출 및 데이터 처리
- Presentational 컴포넌트에 props 전달

**Container/Presentational 패턴 예시**:
```
containers/objective/ObjectiveListContainer.jsx
  ↓ (로직 처리, Redux 연결)
components/objective/ObjectiveList.jsx
  ↓ (UI 렌더링)
```

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
├── multi_source_feedback_responses.js
├── one_on_ones.js          # 1:1 미팅 모듈
├── reviews.js              # 리뷰 모듈
├── tasks.js                # 태스크 모듈
├── task_lists.js           # 태스크 리스트 모듈
├── task_boards.js          # 태스크보드 모듈
├── scrum_boards.js         # 스크럼보드 모듈
├── scrum_joins.js          # 스크럼 참여 모듈
├── dash_board.js           # 대시보드 모듈
├── menu.js                 # 메뉴 모듈
├── search.js               # 검색 모듈
├── notifications.js        # 알림 모듈 (레거시)
├── notificationsV2.ts      # 알림 모듈 v2
├── userpage.js             # 사용자 페이지 모듈
├── people_engine.js        # 인재 관리 모듈
├── auth.js                 # 인증 모듈
├── workspaces.js           # 워크스페이스 모듈
├── data_tab.ts             # 데이터 탭 모듈
├── talent_sessions.ts      # 인재 세션 모듈
├── account/                # 계정 관련 모듈
├── attendance/             # 근태 관련 모듈
├── hrm/                    # 인사 관리 모듈
├── objectives/             # 목표 관련 서브 모듈
├── organization/           # 조직 관련 모듈
├── pay/                    # 급여 모듈
├── system/                 # 시스템 설정 모듈
├── workflow/               # 워크플로우 모듈
├── main/                   # 메인 모듈
└── holiday_work_is_necessary/ # 휴일 근무 모듈
```

**특징**:
- **Redux Pender**: 비동기 작업 관리 (`redux-pender`)
- **Redux Thunk**: 비동기 액션 생성자
- **Redux Actions**: 액션 생성 헬퍼 (`redux-actions`)
- **Ducks 패턴**: 액션, 리듀서를 하나의 파일에 관리

**주의사항**:
- `appraisals.js`는 117KB로 매우 큼 (추후 분리 필요)
- 일부 모듈은 TypeScript로 마이그레이션 중 (`.ts` 확장자)

---

### 4. src/pages/ - 페이지 컴포넌트

**역할**: 라우트별 페이지 컴포넌트. Container를 조합하여 완성된 페이지 구성.

**구조**:
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
├── attendance/             # 근태 페이지
├── hrm/                    # 인사 관리 페이지
├── workflow/               # 워크플로우 페이지
├── user_page/              # 사용자 페이지
├── search/                 # 검색 페이지
├── account/                # 계정 페이지
├── pay/                    # 급여 페이지
├── talent_session/         # 인재 세션 페이지
├── workspace/              # 워크스페이스 페이지
├── whats_new/              # 새로운 기능 안내
├── manual/                 # 매뉴얼 페이지
├── auth/                   # 인증 페이지
├── user/                   # 사용자 프로필 페이지
└── security/               # 보안 설정 페이지
```

**특징**:
- React Router의 라우트 대상
- 여러 Container를 조합
- 페이지별 레이아웃 및 구성 관리

---

### 5. src/lib/ - 유틸리티 및 헬퍼

**역할**: 공통 유틸리티 함수, 헬퍼, 비즈니스 로직 공통 처리.

**주요 파일** (70개 이상):
```
lib/
├── constants.js            # 상수 정의
├── authenticate.js         # 인증 관련
├── axiauth.js              # Axios 인증 헬퍼 (12KB)
├── cookie.ts               # 쿠키 관리
├── encrypt.ts              # 암호화
├── decrypt.ts              # 복호화
├── download.js             # 파일 다운로드
├── excelDownload.ts        # 엑셀 다운로드
├── datePicker.ts           # 날짜 선택기 헬퍼
├── getWorkspaceInfo.ts     # 워크스페이스 정보
├── getDirectManager.ts     # 직속 상사 조회
├── getOrganizationIdsUntilRoot.js # 조직 계층 조회
├── getUserOrganization.ts  # 사용자 조직 정보
├── checkWorkspacePermission.ts # 권한 체크
├── handleLogout.ts         # 로그아웃 처리
├── handleInitialPasswordChange.ts # 초기 비밀번호 변경
├── handleAttendanceError.ts # 근태 에러 처리
├── getCustomMenuName.ts    # 커스텀 메뉴 이름
├── convertEmployeeLabel.ts # 직원 라벨 변환
├── AutoSignOutTimer.ts     # 자동 로그아웃 타이머
├── SuperAdminAutoSignOutTimer.ts # 슈퍼 어드민 타이머
├── aiFeatureConstant.js    # AI 기능 상수
├── bulk.ts                 # 일괄 처리
├── color.js                # 색상 헬퍼
├── appraisal/              # 평가 관련 헬퍼 (14개 파일)
├── attendance/             # 근태 관련 헬퍼
├── hrm/                    # 인사 관리 헬퍼
├── ibsheet/                # IBSheet 설정 (10개 파일)
├── feedback/               # 피드백 헬퍼
├── error_message/          # 에러 메시지 관리
└── ...                     # 기타 40개 이상 파일
```

**특징**:
- 재사용 가능한 함수 집합
- TypeScript 마이그레이션 진행 중 (`.ts` 파일 증가)
- 비즈니스 로직 공통 부분 추출
- API 호출 헬퍼 (`axiauth.js`)

**주요 카테고리**:
1. **인증/권한**: authenticate, axiauth, checkWorkspacePermission
2. **데이터 처리**: 암호화, 복호화, 변환
3. **파일 처리**: 다운로드, 엑셀 다운로드
4. **조직/사용자**: 조직 계층, 직속 상사, 사용자 조직
5. **기능별 헬퍼**: appraisal, attendance, hrm, feedback

---

### 6. src/hooks/ - Custom React Hooks

**역할**: 재사용 가능한 React 커스텀 훅.

**주요 파일** (30개):
```
hooks/
├── useDebounce.ts          # 디바운스 훅
├── useInput.ts             # 입력 관리
├── useToggleState.ts       # 토글 상태
├── usePrevious.ts          # 이전 값 추적
├── useDidMountEffect.ts    # 마운트 시 effect
├── useDeepCompare.ts       # 깊은 비교
├── useIntersectionObserver.ts # Intersection Observer
├── useAutoScrollWithSortable.ts # 자동 스크롤
├── useDataGridScroll.ts    # 데이터 그리드 스크롤
├── useDataTabHistoryBack.ts # 데이터 탭 뒤로가기
├── useDatatabDetailPageHeight.ts # 높이 계산
├── useLoadPeopleMe.ts      # 사용자 정보 로드
├── useWorkspaceMembersMap.tsx # 워크스페이스 멤버 맵
├── useMemberWorkFilter.ts  # 멤버 작업 필터
├── useOrganizationManagerRole.ts # 조직 관리자 역할
├── useAcceptTerms.ts       # 약관 동의
├── useScoreInputValue.ts   # 점수 입력 값
├── useSubmitBulkApprove.ts # 일괄 승인 제출
├── useSubmitBulkObjectiveApprove.ts # 목표 일괄 승인
├── useAppraisalMultiChoiceValidation.ts # 평가 다중 선택 검증
├── appraisal/              # 평가 관련 훅 (9개)
├── appraisal_list/         # 평가 목록 훅
├── hrm/                    # 인사 관리 훅 (7개)
├── attendance/             # 근태 훅 (5개)
├── workflow/               # 워크플로우 훅 (5개)
├── form/                   # 폼 훅 (4개)
├── AI_appraisal/           # AI 평가 훅 (4개)
├── AI_objective/           # AI 목표 훅 (3개)
└── workspace.js            # 워크스페이스 훅 (레거시)
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

**지원 언어**: 8개 (각 언어별 번역 JSON 파일 존재)

**관리 방법**:
- `open-locales.js` 스크립트를 통해 번역 파일 편집
- i18next 21.8.11 사용
- react-i18next 11.17.4로 React 통합

---

### 8. src/config/ - 설정 파일

**역할**: 앱 전역 설정 관리.

**주요 파일**:
```
config/
├── store.ts                # Redux Store 설정
├── env.ts                  # 환경 변수 관리
└── constants.ts            # 앱 상수 정의
```

**특징**:
- Redux Store 초기화
- Redux Middleware 설정 (thunk, pender)
- 환경별 설정 관리

---

### 9. src/assets/ - 정적 자산

**역할**: JSON, 설정 파일 등 정적 자산 관리.

**특징**:
- 커스텀 설정 JSON
- 암호화된 추가 기능 설정 (`encrypted_additional_features_v2.json`)
- 코웨이 커스텀 데이터 (`cowayAppraisal/`)
- S3 동기화 스크립트 (`encryptAdditionalFeatures.js`)

---

### 10. src/@types/ - 커스텀 타입 정의

**역할**: 전역 TypeScript 타입 정의.

**구조**:
```
@types/
└── customTypes/            # 커스텀 타입 정의
```

**특징**:
- 프로젝트 전역에서 사용하는 타입
- tsconfig.json의 `typeRoots`에 등록됨

---

### 11. src/hoc/ - Higher-Order Components

**역할**: 컴포넌트 래핑 및 공통 기능 주입.

**특징**:
- 인증 체크
- 권한 체크
- 레이아웃 래핑
- 공통 로직 추상화

---

## 경로 별칭 (Path Aliases)

TypeScript와 Vite에서 사용하는 경로 별칭:

```typescript
// tsconfig.json & vite.config.ts
"public/*"      → ./public/*
"types/*"       → ./src/@types/*
"assets/*"      → ./src/assets/*
"components/*"  → ./src/components/*
"config/*"      → ./src/config/*
"containers/*"  → ./src/containers/*
"hoc/*"         → ./src/hoc/*
"hooks/*"       → ./src/hooks/*
"images/*"      → ./src/images/*
"lib/*"         → ./src/lib/*
"locales/*"     → ./src/locales/*
"material/*"    → ./src/material/*
"modules/*"     → ./src/modules/*
"pages/*"       → ./src/pages/*
"sass/*"        → ./src/sass/*
"stylesheets/*" → ./src/stylesheets/*
```

**사용 예시**:
```typescript
// 절대 경로 사용
import { ObjectiveList } from 'components/objective/ObjectiveList';
import { getDirectManager } from 'lib/getDirectManager';
import { fetchObjectives } from 'modules/objectives';

// 상대 경로 사용 불필요
// import { ObjectiveList } from '../../../components/objective/ObjectiveList'; ❌
```

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

## 아키텍처 패턴

### Container/Presentational 패턴

**Container** (로직 담당):
- Redux store 연결
- API 호출
- 상태 관리
- 이벤트 핸들러

**Presentational** (UI 담당):
- Props로 데이터와 콜백 받음
- UI 렌더링만 담당
- 재사용 가능
- 테스트하기 쉬움

**예시**:
```
containers/objective/ObjectiveListContainer.jsx
  ↓ connect(mapStateToProps, mapDispatchToProps)
  ↓ Redux store에서 데이터 가져옴
  ↓ API 호출 및 액션 디스패치
  ↓ Props 전달
components/objective/ObjectiveList.jsx
  ↓ Props로 데이터 받음
  ↓ UI 렌더링
```

---

## 모듈 경계

각 기능 영역별로 명확한 모듈 경계를 유지:

### 1. COMMON 영역
- `containers/main/`, `components/main/`
- `modules/dash_board.js`, `modules/menu.js`

### 2. 성과관리 (Performance Management)
- **목표**: `containers/objective/`, `components/objective/`, `modules/objectives.js`
- **피드백**: `containers/feedback/`, `components/feedback/`, `modules/feedbacks.js`
- **1:1**: `containers/one_on_one/`, `components/one_on_one/`, `modules/one_on_ones.js`
- **리뷰**: `containers/review/`, `components/review/`, `modules/reviews.js`

### 3. 업무관리 (Task Management)
- **태스크보드**: `containers/task_board/`, `components/task_board/`, `modules/task_boards.js`
- **스크럼보드**: `containers/scrum_board/`, `components/scrum_board/`, `modules/scrum_boards.js`

### 4. 360 진단 (Multi-source Feedback)
- `containers/multi_source/`, `components/multi_source/`, `modules/multi_sources.js`

### 5. 평가관리 (Appraisal Management)
- `containers/appraisal/`, `components/appraisal/`, `modules/appraisals.js`
- `containers/talenx_appraisal/`, `components/talenx_appraisal/`

---

## 주의사항

### 1. 레거시 코드
- 일부 파일은 JavaScript (`.js`, `.jsx`)로 남아있음
- TypeScript 마이그레이션 진행 중

### 2. 큰 파일들
- `modules/appraisals.js`: 117KB (추후 분리 필요)
- `modules/migration.json`: 83KB (레거시 마이그레이션 데이터)
- `lib/axiauth.js`: 12KB

### 3. Material-UI 버전 혼재
- v4와 v5가 동시에 사용되고 있어 `components/`와 `material/`에서 스타일 충돌 가능

### 4. 커스텀 라우트
- NHQV, 코웨이 등 특정 고객사용 커스텀 코드가 일부 디렉토리에 존재
- `components/custom/`, `assets/cowayAppraisal/` 등

---

## 다음 문서

- [tech-stack.md](tech-stack.md): 기술 스택 상세
- [code-style.md](code-style.md): 코딩 규칙 및 컨벤션
- [overview.md](overview.md): ppfront 전체 개요
