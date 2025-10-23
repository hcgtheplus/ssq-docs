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

**관련 코드**:

- `components/layout/`: GNB, 레이아웃
- `components/search/`: 검색
- `components/main/`: 대시보드
- `components/user_page/`: 마이페이지

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

## SSQ 범위

**SSQ는 성과/평가 영역만 관장합니다:**

- ✅ 목표, 피드백, 1:1 미팅, 리뷰
- ✅ 업무보드, 스크럼보드
- ✅ 360 진단, 평가관리

**SSQ 범위 외 (ppfront에 포함되지만 SSQ 아님):**

- ❌ 근태 관리, 인사 관리, 워크플로우, 급여 관리

---

## 기술 스택

**상세 문서**: [tech-stack.md](tech-stack.md)

### Core

- React 17.0.2, TypeScript 5.3+, Vite 4.3.2

### State Management

- Redux 3.7.1, Redux Thunk + Redux Pender
- TanStack React Query v4

### UI Framework

- Material-UI v4/v5 (마이그레이션 중)
- Emotion (CSS-in-JS)

### 주요 라이브러리

- AG Grid Enterprise 33.1.1
- i18next 21.8.11 (8개 언어)
- Formik 2.2.5, Axios 1.7.9
- Sentry 7.56.0

---

## 프로젝트 구조

**상세 문서**: [project-structure.md](project-structure.md)

```
ppfront/
├── src/
│   ├── components/               # Presentational 컴포넌트
│   ├── containers/               # Container 컴포넌트 (Redux 연결)
│   ├── pages/                    # 페이지 컴포넌트 (라우팅)
│   ├── modules/                  # Redux 상태 관리 (Ducks 패턴)
│   ├── hooks/                    # 커스텀 React Hooks
│   ├── lib/                      # 유틸리티 함수
│   ├── material/                 # Material-UI 중앙 집중식 import
│   ├── locales/                  # 다국어 리소스 (8개 언어)
│   ├── assets/                   # 정적 자산 및 고객사별 커스텀 데이터
│   └── config/                   # Redux Store 등 앱 설정
├── vite.config.ts                # Vite 빌드 설정
├── tsconfig.json                 # TypeScript 설정
└── env-cmd-rc.js                 # 환경별 설정 (10+ 배포 환경)
```

### 아키텍처 패턴

**상세 문서**: [architecture-patterns.md](architecture-patterns.md)

- **Container/Presentational Pattern**: UI와 로직 분리
- **Redux Ducks Pattern**: 액션/리듀서를 단일 파일로 관리
- **Workspace Hardcoding**: S3 기반 `additional_features.json`으로 워크스페이스별 기능 관리

---

## 코드 스타일 및 규칙

**상세 문서**: [code-style.md](code-style.md)

### 주요 규칙

- **TypeScript Strict Mode** 활성화
- **경로 별칭 필수**: 상대 경로 import 금지 (`../` 사용 불가)
- **Material-UI 중앙 집중식 import**: `material/` 폴더를 통한 import 필수
  - 컴포넌트: `MUI` 접두사 (예: `MUIButton`)
  - 아이콘: `Icon` 접미사 (예: `AddIcon`)
- **ESLint + Prettier**: 자동 포맷팅
- **Git Hooks**: Pre-commit 시 lint-staged 실행

### Import 순서

1. React, Redux
2. External libraries
3. Material-UI (`material/components`, `material/icons`)
4. Containers
5. Components
6. Modules, Hooks, Lib

---

## 다국어 지원

### 지원 언어 (8개)

한국어(ko), 영어(en), 일본어(ja-JP), 중국어(zh-CN), 인도네시아어(id-ID), 베트남어(vi-VN), 태국어(th-TH)

**구조**: `src/locales/{언어}/` 디렉토리에 JSON 파일로 관리

---

## 핵심 파일

**상세 문서**: [core-files.md](core-files.md)

- `src/App.jsx`: 메인 앱 컴포넌트 (라우팅, 인증)
- `src/config/store.ts`: Redux Store 설정
- `src/locales/i18n.ts`: i18next 설정
- `vite.config.ts`: Vite 빌드 설정
- `tsconfig.json`: TypeScript 설정
- `env-cmd-rc.js`: 환경별 설정

---

## 개발 환경

### 실행 명령어

```bash
# 개발 서버 실행 (포트 3000)
yarn start

# 프로덕션 빌드
yarn build-app

# 배포
yarn deploy:stag         # Staging
yarn deploy:prod         # Production
yarn deploy:talenx-prod  # Talenx Production
```

### 환경 변수

- 10+ 배포 환경 지원 (development, staging, production, demo, talenx-\* 등)
- `env-cmd-rc.js`에서 환경별 설정 관리

---

## 주요 특징 및 주의사항

### 1. Legacy & Modern 혼재

- Material-UI v4와 v5가 동시 사용 (v5로 마이그레이션 중)
- Material Design Lite (MDL) 일부 사용

### 2. 엔터프라이즈 도구 (라이센스 필요)

- **AG Grid Enterprise**: 메인 데이터 그리드
- **IBSheet**: 레거시 스프레드시트 컴포넌트
- **Froala Editor**: 리치 텍스트 에디터

### 3. 커스텀 구현

- 고객사별 커스텀 로직 (Coway, Innocean, Maeil 등)
- `assets/` 디렉토리에 고객사별 데이터 및 설정

### 4. 성능 고려사항

- 빌드 시 메모리: `max-old-space-size=8192` 필요
- 청크 최적화 중요 (청크 크기 경고: 4096KB)

### 5. 보안

- `credentials.json`: 암호화된 설정
- Sentry 에러 트래킹

---

## 관련 문서

### 기본 문서

- [tech-stack.md](tech-stack.md): 기술 스택 상세 (React, Redux, Material-UI 등)
- [project-structure.md](project-structure.md): 프로젝트 구조 상세 (디렉토리별 역할)
- [code-style.md](code-style.md): 코딩 규칙, ESLint/Prettier 설정, Import 순서
- [core-files.md](core-files.md): 핵심 파일 상세 (App.jsx, vite.config.ts 등)
- [architecture-patterns.md](architecture-patterns.md): 아키텍처 패턴 (Container/Presentational, Redux Ducks, 평가 시스템)

### 기능별 체크리스트

- [checklist.md](checklist.md): 모든 기능의 상세 체크리스트

### 빌드 기록

- [../../build_record/roadmap.md](../../build_record/roadmap.md): 문서화 로드맵
- [../../build_record/20251023_build_day_2.md](../../build_record/20251023_build_day_2.md): Day 2 작업 일지

---

## 참고사항

### 문서화 원칙

- 이 문서는 LLM이 코드베이스를 이해하기 위한 가이드입니다
- 실제 코드는 ppfront 레포지토리를 참조하세요
- 문서와 코드가 불일치할 경우 코드가 우선이며, 문서를 업데이트해주세요

### 주요 브랜치

- **talenx**: 현재 개발 기준 브랜치

### 용어 정리

- **360 피드백**: Multi-Source Feedbacks (`multi_source_feedbacks`)
- **평가**: Appraisals (`appraisals`)
- **목표**: Objectives (`objectives`)
- **피드백**: Feedbacks (`feedbacks`) - 배지 피드백
- **업무보드**: Task Board (`task_board`)
- **스크럼보드**: Scrum Board (`scrum_board`)
