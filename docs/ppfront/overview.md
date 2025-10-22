# ppfront - Overview

## 프로젝트 소개

**ppfront**(Performance Plus Front)는 엔터프라이즈급 HR/HCM 성과관리 플랫폼의 프론트엔드 애플리케이션입니다.

### 제품군
- Performance Plus
- Talenx
- 커스텀 솔루션 (Coway, Innocean, Maeil 등)

---

## 주요 기능 영역

SSQ(ppfront)는 크게 5개의 주요 영역으로 구성되어 있습니다:

### 1. COMMON (공통)
- **GNB**: 알림 관리 (승인 필요/읽지 않음/전체)
- **검색**: 통합 검색 (목표/업무/파일), 공개 범위 제어
- **대시보드**: 활동 타임라인, 구독 설정
- **마이페이지**: 목표/피드백/업무보드/평가 통합 조회

관련 코드:
- [components/layout/](../../ppfront/src/components/layout): GNB, 레이아웃
- [components/search/](../../ppfront/src/components/search): 검색
- [components/main/](../../ppfront/src/components/main): 대시보드
- [components/user_page/](../../ppfront/src/components/user_page): 마이페이지

---

### 2. 성과관리

#### 2-1. 목표 (Objectives)
- 목표 생성/수정/마감
- 목표 목록 (소속 기준, 관리자/팔로워 기준)
- 목표 맵 (조직도 기반 목표 트리)
- 핵심 성과 (Key Results) 관리
  - 구간 설정 (증가/감소, 이상/미만/초과/이하)
  - 달성률 계산
  - 상위 목표 연계
- 목표 가중치 설정 및 승인
- 체크인 (진행 상황 업데이트)
- 목표 활동 제한 설정

관련 코드:
- [components/objective/](../../ppfront/src/components/objective)
- [containers/objective/](../../ppfront/src/containers/objective)
- [modules/objectives/](../../ppfront/src/modules/objectives)
- [hooks/AI_objective/](../../ppfront/src/hooks/AI_objective): AI 목표 추천
- [lib/mainDashboard/](../../ppfront/src/lib/mainDashboard): 대시보드 로직

#### 2-2. 피드백 (Feedbacks)
- 피드백 보내기/수정
- 배지 피드백
- 감사 선물 (배지와 함께 전송)
- 공개 범위 설정 (전체/지정/당사자만)
- 코멘트로 피드백 보내기 (목표/업무/스크럼 댓글에서)
- 좋아요

관련 코드:
- [components/feedback/](../../ppfront/src/components/feedback)
- [containers/feedback/](../../ppfront/src/containers/feedback)
- [modules/feedbacks.js](../../ppfront/src/modules/feedbacks.js)
- [modules/badgepools.js](../../ppfront/src/modules/badgepools.js): 배지 관리
- [lib/feedback/](../../ppfront/src/lib/feedback)

#### 2-3. 1:1 미팅 (One-on-One)
- 미팅 생성 (대상자-관리자 페어)
- 공개 코멘트 (양방향)
- 비공개 노트 (개인 메모, HR Admin만 열람 가능)
- 미팅 일정 관리
- 코멘트 양식 설정 (어드민 일괄/구성원 직접)

관련 코드:
- [components/one_on_one/](../../ppfront/src/components/one_on_one)
- [pages/one_on_one/](../../ppfront/src/pages/one_on_one)

#### 2-4. 리뷰 (Reviews)
- 리뷰 생성 (주기, 양식, 관리자 선택)
- 리뷰 대화 (Review Conversation)
- 인재 스냅샷 (Talent Snapshot)
- 검토자 설정
- 리뷰 탐색기 (조직별 리뷰 진행 현황)
- 작성 완료 처리

관련 코드:
- [components/review/](../../ppfront/src/components/review)
- [containers/review/](../../ppfront/src/containers/review)
- [pages/review/](../../ppfront/src/pages/review)

---

### 3. 업무관리

#### 3-1. 업무보드 (Task Board)
- 업무보드 생성/수정/삭제
- 업무리스트 관리 (색상, 공개 범위, 순서)
- 업무 생성/수정/완료/삭제
- 드래그 앤 드롭 순서 변경
- 체크리스트
- 파일 첨부
- 댓글
- 태그/상태 관리
- 업무 활동 내역
- 읽지 않음 알림 (N, 1-9+)
- 업무보드 필터
- 공개/비공개 설정

관련 코드:
- [components/task_board/](../../ppfront/src/components/task_board)
- [containers/task_board/](../../ppfront/src/containers/task_board)
- [pages/task_board/](../../ppfront/src/pages/task_board)
- [lib/task_board/](../../ppfront/src/lib/task_board)
- [lib/task_list/](../../ppfront/src/lib/task_list)

#### 3-2. 스크럼보드 (Scrum Board)
- 스크럼보드 생성 (유형, 관리자, 구성원/참조자)
- 공개 스크럼보드 참여
- 스크럼 작성 (날짜 지정)
- 좋아요
- 스크럼보드 보관함 (삭제/활성화)

관련 코드:
- [components/scrum_board/](../../ppfront/src/components/scrum_board)
- [pages/scrum_board/](../../ppfront/src/pages/scrum_board)

---

### 4. 360 진단

#### 4-1. 360 피드백 (Multi-Source Feedbacks)
- 피드백 요청 (대상자, 평가자, 유형 선택)
- 피드백 응답
  - 다중 선택지 (최소/최대 선택 개수)
  - 필수 응답 문항
- 피드백 결과 확인
  - 그룹 360 피드백: 다중 선택지 평균값 표시
- 나의 360 피드백 평가자 설정
  - 평가자 추가/수정/삭제
  - 순서 변경 (드래그 앤 드롭)
- 구성원 360 피드백 평가자 설정 (조직도 기반)
- 응답률 그래프
- 현재까지 응답 확인
- 응답 마감 처리

관련 코드:
- [components/multi_source/](../../ppfront/src/components/multi_source)
- [pages/multi_source/](../../ppfront/src/pages/multi_source)
- [lib/multi_source/](../../ppfront/src/lib/multi_source)
- [assets/cowayMultiSourceFeedback/](../../ppfront/src/assets/cowayMultiSourceFeedback): 커스텀 데이터

---

### 5. 평가관리 (Appraisals)

#### 5-1. 평가 (Appraisals)
- 평가 리스트
  - 평가 작성 탭 (평가자 권한)
  - 평가 검토 탭 (검토자 권한)
  - 결과 확인 탭 (대상자 권한)
- 평가 응답
  - 영역별 평가 문항
  - 점수/등급/의견 입력
  - 임시저장
  - 대상자 네비게이션 (여러 대상자 평가 시)
  - 점수 계산 (자동 합산)
  - 사후 조정 (원 점수/조정 점수)
- 성과 데이터 통합 조회
  - 목표 탭: 핵심성과, 달성률, 히스토리
  - 피드백 탭: 배지 개수, 상대 순위, 받은 배지 목록
  - 360 피드백 탭: 응답 확인
  - 리뷰 탭: 리뷰 내용
  - 1:1 미팅 탭: 미팅 내용
- 등급 조정
  - 영역별 등급 조정 탭
  - 등급 배분 인원 제한
  - 누적 방식
  - 등급 확정
- 중간 경과 공유
  - 평가 대상자에게 결과 공개
  - 다면 평가자 실명 공개
- 이의 신청
  - 이의 신청 제출
  - 검토자 의견 (공개/비공개)
  - 이의 신청 철회
  - 상태 stepper
- 이의 신청 응답 수정 (HR Admin 전용)
  - 영역 점수/등급/의견 수정
  - 종합 영역 자동 계산

관련 코드:
- [components/appraisal/](../../ppfront/src/components/appraisal)
- [components/talenx_appraisal/](../../ppfront/src/components/talenx_appraisal): Talenx 전용
- [containers/appraisal/](../../ppfront/src/containers/appraisal)
- [containers/talenx_appraisal/](../../ppfront/src/containers/talenx_appraisal)
- [pages/appraisal/](../../ppfront/src/pages/appraisal)
- [modules/appraisals.js](../../ppfront/src/modules/appraisals.js)
- [hooks/appraisal/](../../ppfront/src/hooks/appraisal)
- [hooks/AI_appraisal/](../../ppfront/src/hooks/AI_appraisal): AI 평가
- [lib/appraisal/](../../ppfront/src/lib/appraisal)
- [assets/cowayAppraisal/](../../ppfront/src/assets/cowayAppraisal): Coway 커스텀
- [assets/innoceanAppraisal/](../../ppfront/src/assets/innoceanAppraisal): Innocean 커스텀
- [assets/maeilAppraisal/](../../ppfront/src/assets/maeilAppraisal): Maeil 커스텀

#### 5-2. 평가 대시보드
- HR Admin / Sub Admin 뷰
  - 필터 (평가, 그룹, 조직)
  - 평가 제출 현황
  - 등급별 배분 현황 (영역별)
  - 평가 진행 현황 테이블
  - 대상자 상세보기 링크
  - 프로세스 알림 발송
  - 팝오버 (점수/등급/의견)
  - 과거 평가 연동 데이터
  - 대시보드 추가 데이터 설정
- 조직장 뷰
  - 본인이 평가한 조직원만 조회
  - 마지막 평가 차수까지만 노출
  - 상세보기 버튼 미노출

관련 코드:
- [components/data_tab/](../../ppfront/src/components/data_tab): 대시보드
- [containers/appraisal/](../../ppfront/src/containers/appraisal)
- [modules/dash_board.js](../../ppfront/src/modules/dash_board.js)

---

## 추가 기능 영역

### 근태 관리 (Attendance)
- 휴가 신청 및 승인
- 근무 시간 관리
- 휴가 유형별 잔여일 관리

관련 코드:
- [components/attendance/](../../ppfront/src/components/attendance)
- [containers/attendance/](../../ppfront/src/containers/attendance)
- [modules/attendance/](../../ppfront/src/modules/attendance)
- [hooks/attendance/](../../ppfront/src/hooks/attendance)
- [lib/attendance/](../../ppfront/src/lib/attendance)
- [assets/attendance/](../../ppfront/src/assets/attendance)

### 인사 관리 (HRM)
- 조직도 관리
- 인사 발령
- 구성원 정보 관리

관련 코드:
- [components/hrm/](../../ppfront/src/components/hrm)
- [containers/hrm/](../../ppfront/src/containers/hrm)
- [modules/hrm/](../../ppfront/src/modules/hrm)
- [hooks/hrm/](../../ppfront/src/hooks/hrm)
- [lib/hrm/](../../ppfront/src/lib/hrm)

### 워크플로우 (Workflow)
- 승인 프로세스 관리
- 승인 요청/처리

관련 코드:
- [components/workflow/](../../ppfront/src/components/workflow)
- [containers/workflow/](../../ppfront/src/containers/workflow)
- [modules/workflow/](../../ppfront/src/modules/workflow)
- [hooks/workflow/](../../ppfront/src/hooks/workflow)
- [lib/workflow/](../../ppfront/src/lib/workflow)

### 급여 관리 (Pay)
- 급여 정보 조회

관련 코드:
- [components/pay/](../../ppfront/src/components/pay)
- [containers/pay/](../../ppfront/src/containers/pay)
- [modules/pay/](../../ppfront/src/modules/pay)
- [pages/pay/](../../ppfront/src/pages/pay)

---

## 기술 스택

### Core
- **React**: 17.0.2
- **TypeScript**: 5.3+ (strict mode)
- **Vite**: 4.3.2 (빌드 도구)

### State Management
- **Redux**: 3.7.1 (전역 상태)
- **Redux Thunk** + **Redux Pender**: 비동기 처리
- **TanStack React Query v4**: 서버 상태 관리

### UI Framework
- **Material-UI v4**: 레거시 컴포넌트
- **Material-UI v5**: 신규 컴포넌트 (@mui/material 5.13.0)
- **Emotion**: CSS-in-JS
- **TSS React**: Material-UI 스타일링

### Data Grid & Visualization
- **AG Grid Enterprise**: 33.1.1 (메인 데이터 그리드)
- **AG Charts**: 11.1.1
- **Echarts**: 4.2.0-rc.2
- **Recharts**: 2.1.1
- **D3**: 7.8.5

### Forms & Input
- **Formik**: 2.2.5
- **React Select**: 2.1.0
- **React Flatpickr**: 날짜 선택

### Document Processing
- **React PDF Viewer**: 3.12.0
- **JSPDF**: 3.0.1
- **XLSX**: 0.18.5 (Excel 처리)
- **React Froala WYSIWYG**: 4.0.8 (리치 텍스트 에디터)

### 다국어 & 유틸리티
- **i18next**: 21.8.11 (8개 언어 지원)
- **Axios**: 1.7.9
- **Lodash**: 4.17.15
- **Moment**: 2.29.4

### Monitoring & Tools
- **Sentry**: 7.56.0 (에러 트래킹)
- **Rails ActionCable**: 7.0.5 (WebSocket)
- **PWA**: Workbox 기반

---

## 프로젝트 구조

```
ppfront/
├── src/
│   ├── @types/                   # TypeScript 타입 정의
│   ├── assets/                   # 정적 자산 및 설정 데이터
│   ├── components/               # Presentational 컴포넌트
│   ├── containers/               # Smart 컴포넌트 (비즈니스 로직)
│   ├── pages/                    # 페이지 컴포넌트 (라우팅)
│   ├── hooks/                    # 커스텀 React Hooks
│   ├── hoc/                      # Higher-Order Components
│   ├── modules/                  # Redux 상태 관리
│   ├── lib/                      # 유틸리티 함수
│   ├── material/                 # Material-UI 커스텀
│   ├── locales/                  # 다국어 리소스
│   ├── images/                   # 이미지 자산
│   ├── sass/                     # SCSS 스타일시트
│   ├── config/                   # 앱 설정 (Redux Store 등)
│   ├── App.jsx                   # 메인 앱 컴포넌트
│   └── index.ts                  # 진입점
├── public/                       # 정적 파일
├── scripts/                      # 빌드/배포 스크립트
├── vite.config.ts                # Vite 빌드 설정
├── tsconfig.json                 # TypeScript 설정
├── package.json                  # 의존성 관리
└── env-cmd-rc.js                 # 환경별 설정
```

### 아키텍처 패턴

**Container/Presentational Pattern**
- [components/](../../ppfront/src/components): 순수 UI 컴포넌트 (props 기반)
- [containers/](../../ppfront/src/containers): 상태 관리 및 비즈니스 로직
- [pages/](../../ppfront/src/pages): 라우트별 페이지 레벨

**주요 디렉토리 역할**
- [modules/](../../ppfront/src/modules): Redux 액션/리듀서 (상태 관리)
- [hooks/](../../ppfront/src/hooks): 재사용 가능한 React Hooks
- [lib/](../../ppfront/src/lib): 비즈니스 로직 유틸리티
- [material/](../../ppfront/src/material): Material-UI 테마 및 커스텀 컴포넌트

---

## 개발 환경

### 환경 변수 관리
- [env-cmd-rc.js](../../ppfront/env-cmd-rc.js): 환경별 설정
- 10+ 배포 환경 지원:
  - development, staging, production
  - demo, dump, dashboard
  - talenx-staging, talenx-prod, talenx-demo 등

### 실행 명령어

```bash
# 개발 서버 실행 (포트 3000)
yarn start

# 프로덕션 빌드
yarn build-app

# 테스트
yarn test                # Jest
yarn test:playwright     # E2E 테스트

# 배포
yarn deploy:stag         # Staging
yarn deploy:prod         # Production
yarn deploy:talenx-prod  # Talenx Production
```

### 빌드 설정
- **Vite** 기반 고속 빌드
- 자동 코드 스플릿 (node_modules별 청크 분리)
- 청크 크기 경고: 4096KB
- 소스맵 생성 활성화
- PWA 지원 (Workbox)

---

## 코드 스타일 및 규칙

### TypeScript 설정
- **Strict Mode**: 활성화
- **경로 별칭**: 17개 경로 매핑 활성화
  - `components/*`, `containers/*`, `modules/*` 등
- **noUnusedLocals**: true
- **noUnusedParameters**: true

### ESLint 규칙
- TypeScript ESLint 사용
- Prettier 통합
- **상대 경로 import 금지**: `../` 사용 불가, 별칭 경로 사용 필수
- Import 정렬: 그룹별 정렬 (외부 라이브러리 → 내부 모듈)
- React Hooks 규칙 강제

### Git Hooks
- **Husky + Lint-staged**: Pre-commit 시 자동 포맷팅
- **Pre-push**: Remote branch 체크
- **Issue number 자동 추가**: 커밋 메시지에 이슈 번호 추가

---

## 다국어 지원

### 지원 언어
- 한국어 (ko)
- 영어 (en)
- 일본어 (ja-JP)
- 중국어 (zh-CN)
- 인도네시아어 (id-ID)
- 베트남어 (vi-VN)
- 태국어 (th-TH)

### 구조
```
src/locales/
├── en/
├── ko/
├── ja-JP/
├── zh-CN/
├── id-ID/
├── vi-VN/
├── th-TH/
└── i18n.ts
```

사용: [open-locales.js](../../ppfront/open-locales.js) 스크립트로 번역 파일 편집

---

## 핵심 파일 및 유틸리티

### 핵심 파일
- [src/App.jsx](../../ppfront/src/App.jsx): 메인 앱 컴포넌트 (1332줄)
  - 라우팅 설정
  - 전역 레이아웃
  - 인증 처리
- [src/config/store.ts](../../ppfront/src/config/store.ts): Redux Store 설정
- [src/locales/i18n.ts](../../ppfront/src/locales/i18n.ts): i18next 설정

### 유틸리티 라이브러리 ([lib/](../../ppfront/src/lib))
- [lib/appraisal/](../../ppfront/src/lib/appraisal): 평가 관련 로직
- [lib/attendance/](../../ppfront/src/lib/attendance): 근태 로직
- [lib/feedback/](../../ppfront/src/lib/feedback): 피드백 처리
- [lib/multi_source/](../../ppfront/src/lib/multi_source): 360 피드백 로직
- [lib/ibsheet/](../../ppfront/src/lib/ibsheet): IBSheet 설정
- [lib/string/](../../ppfront/src/lib/string): 문자열 유틸
- [lib/time/](../../ppfront/src/lib/time): 날짜/시간 유틸
- [lib/error_message/](../../ppfront/src/lib/error_message): 에러 메시지 처리

---

## 주요 특징 및 주의사항

### 1. Legacy & Modern 혼재
- Material-UI v4와 v5가 동시에 사용됨
- 점진적으로 v5로 마이그레이션 진행 중
- Material Design Lite (MDL) 일부 사용

### 2. 엔터프라이즈 도구
- **AG Grid Pro**: 라이센스 필요
- **IBSheet**: 레거시 스프레드시트 컴포넌트
- **Froala Editor**: 리치 텍스트 에디터 (상용)

### 3. 커스텀 구현
- 각 고객사별 커스텀 로직 (Coway, Innocean, Maeil 등)
- [assets/](../../ppfront/src/assets) 디렉토리에 고객사별 데이터
- 커스텀 라우팅 처리 필요

### 4. 성능 고려사항
- 빌드 시 메모리: `max-old-space-size=8192` 필요
- 큰 번들 크기: 청크 최적화 중요
- CSS 코드 스플릿 비활성화됨

### 5. 보안
- [credentials.json](../../ppfront/credentials.json): 암호화된 설정
- Sentry 에러 트래킹
- ESLint 규칙: no-password-value

---

## 다음 문서

- [tech-stack.md](tech-stack.md): 기술 스택 상세
- [project-structure.md](project-structure.md): 프로젝트 구조 상세
- [code-style.md](code-style.md): 코딩 규칙 및 컨벤션
- [core-files.md](core-files.md): 핵심 파일 및 유틸리티 상세
- [modules/](modules/): 기능별 상세 문서

---

## 참고사항

### 문서화 원칙
- 이 문서는 LLM이 코드베이스를 이해하기 위한 가이드입니다
- 실제 코드는 [ppfront/](../../ppfront) 디렉토리를 참조하세요
- 문서와 코드가 불일치할 경우 코드가 우선이며, 문서를 업데이트해주세요

### 주요 브랜치
- **talenx**: 현재 개발 기준 브랜치
- 다른 환경별 브랜치도 존재할 수 있음

### 용어 정리
- **360 피드백**: Multi-Source Feedbacks (`multi_source_feedbacks`)
- **평가**: Appraisals (`appraisals`)
- **목표**: Objectives (`objectives`)
- **피드백**: Feedbacks (`feedbacks`) - 배지 피드백
- **업무보드**: Task Board (`task_board`)
- **스크럼보드**: Scrum Board (`scrum_board`)
