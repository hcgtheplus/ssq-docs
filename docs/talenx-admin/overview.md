# talenx-admin - Overview

## 프로젝트 소개

**talenx-admin**은 SSQ 성과관리 시스템의 **관리자 전용 애플리케이션**입니다.

### 역할

- **ppfront**: 일반 사용자(구성원)가 사용하는 화면
- **talenx-admin**: 어드민 권한이 있는 유저(HR Admin, Sub Admin)만 사용하는 관리 화면

### 주요 기능

ppfront에서 사용되는 성과관리 기능들을 **설정/관리**합니다:
- 평가 생성 및 그룹/대상자 지정, 평가 양식 연결
- 360 피드백 설정 및 평가자 지정
- 목표/피드백/1:1 미팅 설정
- 업무보드/스크럼보드 관리
- 진행 현황 모니터링

---

## 문서화 범위

**중요**: talenx-admin은 전체 HR 시스템(조직, 급여, 근태 등)이지만, 이 문서는 **SSQ 성과관리 관련 부분만** 다룹니다.

**문서화 대상**:
- ✅ Performance (성과관리)
- ✅ Appraisal (평가관리)
- ✅ Multi-Source Feedback (360 피드백)
- ✅ System (SSQ 관련 설정만)
  - 권한 설정
  - 조직 설정
  - 구성원 정보
  - 직급 설정
  - 대시보드
  - 로그 (구성원 활동, 코멘트)
- ✅ Task (업무관리)

**문서화 제외**:
- ❌ HR Core (인사 핵심 - 발령, 인사이동 등)
- ❌ Pay (급여관리)
- ❌ Attendance (근태관리)
- ❌ SINS (4대보험)
- ❌ System의 나머지 (워크스페이스, 법인정보, 보안 등)

---

## 주요 기능 영역

SSQ 성과관리 시스템은 **5개 영역**으로 구성됩니다:

### 1. Performance (성과관리)

**경로**: `src/pages/performance/`

#### 1-1. Objective (목표 관리)

**하위 페이지**:
- **cycles** - 목표 주기 설정
- **settings** - 목표 설정
- **records** - 목표 기록 조회
- **weight_records** - 가중치 기록
- **key_result_records** - Key Result 기록
- **user_records** - 사용자별 목표 기록
- **user_statistics** - 사용자 통계

**관련 코드**:
- Pages: `src/pages/performance/objective/`
- 관리자가 ppfront의 목표 기능을 설정/모니터링

#### 1-2. Feedback (피드백/배지 관리)

**하위 페이지**:
- **settings** - 피드백 설정
- **records** - 피드백 기록 조회
- **overview** - 피드백 개요
- **badge_settings** - 배지 설정
- **badge_records** - 배지 기록
- **thanks_gift_settings** - 감사 선물 설정
- **thanks_gift_records** - 감사 선물 기록

**관련 코드**:
- Pages: `src/pages/performance/feedback/`
- ppfront의 배지 피드백 시스템 설정

#### 1-3. One-on-One (1:1 미팅 관리)

**하위 페이지**:
- **settings** - 1:1 미팅 설정
- **templates** - 1:1 미팅 템플릿 관리
  - 템플릿 생성/수정 (`new`, `[oneOnOneId]`)
- **records** - 1:1 미팅 기록 조회

**관련 코드**:
- Pages: `src/pages/performance/one_on_one/`
- ppfront의 1:1 미팅 양식 및 설정 관리

#### 1-4. Review (리뷰 관리)

**하위 페이지**:
- **settings** - 리뷰 설정
- **templates** - 리뷰 템플릿 관리
- **records** - 리뷰 기록 조회
- **snapshot_records** - 스냅샷 기록 (인재 스냅샷)

**관련 코드**:
- Pages: `src/pages/performance/review/`
- ppfront의 리뷰 시스템 설정

#### 1-5. Job Categories (직무 카테고리)

**하위 페이지**:
- **index** - 직무 카테고리 목록
- **[jobCategoryId]** - 직무 카테고리 상세
- **template** - 직무별 템플릿 관리

**관련 코드**:
- Pages: `src/pages/performance/job_categories/`
- 성과관리에 사용되는 직무 분류 체계

---

### 2. Appraisal (평가관리)

**경로**: `src/pages/appraisal/`

#### 2-1. Settings (평가 설정)

**기능**:
- 평가 생성/수정/삭제
- 평가 일정 설정
- 그룹 생성 및 관리
  - 그룹별 대상자 지정
  - 그룹별 평가자 지정
  - 그룹별 평가 양식(Template) 연결
- 평가는 여러 그룹을 포함할 수 있음

**하위 페이지**:
- **index** - 평가 목록
- **[appraisalId]** - 평가 상세 설정
- **[appraisalId]/group/[groupId]** - 그룹별 상세 설정

**관련 코드**:
- Pages: `src/pages/appraisal/settings/`

#### 2-2. Templates (평가 템플릿)

**기능**:
- 평가 양식 생성/수정
- 영역 설정
- 문항 설정
- 배점 설정

**하위 페이지**:
- **index** - 템플릿 목록
- **new** - 새 템플릿 생성
- **[appraisalTemplateId]** - 템플릿 수정

**관련 코드**:
- Pages: `src/pages/appraisal/templates/`

#### 2-3. Records (평가 기록)

**기능**:
- 평가 진행 현황 조회
- 평가 결과 확인
- 대상자별 진행 상황

**관련 코드**:
- Pages: `src/pages/appraisal/records/`

#### 2-4. Appraiser Records (평가자 기록)

**기능**:
- 평가자별 진행 현황
- 미제출 평가자 확인

**관련 코드**:
- Pages: `src/pages/appraisal/appraiser_records/`

#### 2-5. Ratings (등급 관리)

**기능**:
- 등급 조정
- 등급 분포 관리
- 등급 확정

**하위 페이지**:
- **index** - 등급 목록
- **new** - 새 등급 생성
- **[appraisalRatingId]** - 등급 수정

**관련 코드**:
- Pages: `src/pages/appraisal/ratings/`

#### 2-6. Objections (이의신청 관리)

**기능**:
- 이의신청 내역 조회
- 이의신청 처리
- 검토자 의견 관리

**관련 코드**:
- Pages: `src/pages/appraisal/objections/`

#### 2-7. Open Result Records (결과 공개)

**기능**:
- 평가 결과 공개 관리
- 공개 범위 설정
- 공개 일정 관리

**관련 코드**:
- Pages: `src/pages/appraisal/open_result_records/`

---

### 3. Multi-Source Feedback (360 피드백)

**경로**: `src/pages/multi_source_feedback/`

#### 3-1. Settings (360 설정)

**기능**:
- 360 피드백 생성/수정/삭제
- 대상자 지정
- 평가자 지정
- 일정 설정

**하위 페이지**:
- **index** - 360 피드백 목록
- **[multiSourceFeedbackId]** - 360 피드백 상세 설정

**관련 코드**:
- Pages: `src/pages/multi_source_feedback/settings/`

#### 3-2. Templates (360 템플릿)

**기능**:
- 360 피드백 양식 생성/수정
- 문항 설정
- 응답 유형 설정 (다중 선택, 서술형 등)

**하위 페이지**:
- **index** - 템플릿 목록
- **new** - 새 템플릿 생성
- **[templateId]** - 템플릿 수정

**관련 코드**:
- Pages: `src/pages/multi_source_feedback/templates/`

#### 3-3. Records (360 기록)

**기능**:
- 360 피드백 진행 현황 조회
- 응답률 확인
- 결과 조회

**관련 코드**:
- Pages: `src/pages/multi_source_feedback/records/`

#### 3-4. Assessor Records (평가자 기록)

**기능**:
- 평가자별 응답 현황
- 미응답자 확인

**관련 코드**:
- Pages: `src/pages/multi_source_feedback/assessor_records/`

#### 3-5. Group (그룹 360)

**기능**:
- 그룹 360 피드백 관리
- 그룹별 결과 집계

**관련 코드**:
- Pages: `src/pages/multi_source_feedback/group/`

---

### 4. System (시스템 설정 - SSQ 관련만)

**경로**: `src/pages/system/`

**중요**: System 영역은 전체 HR 시스템 설정이지만, **SSQ 성과관리에 필요한 부분만** 문서화합니다.

#### 4-1. Auth (권한 설정)

**기능**:
- 서비스 관리자 권한 설정
- SSQ 모듈별 권한 관리

**하위 페이지**:
- **service_admin** - 서비스 관리자 설정

**관련 코드**:
- Pages: `src/pages/system/auth/`

#### 4-2. Organization (조직 설정)

**기능**:
- 조직 구조 관리
- 성과관리에서 사용되는 조직 정보

**하위 페이지**:
- **index** - 조직 관리

**관련 코드**:
- Pages: `src/pages/system/organization/`

#### 4-3. Member (구성원 정보)

**기능**:
- 구성원 정보 조회
- 구성원 개요

**하위 페이지**:
- **info** - 구성원 상세 정보
- **overview** - 구성원 개요

**관련 코드**:
- Pages: `src/pages/system/member/`

#### 4-4. Job Grades (직급 설정)

**기능**:
- 직급 체계 관리
- 성과관리에서 사용되는 직급 정보

**하위 페이지**:
- **index** - 직급 목록 및 설정

**관련 코드**:
- Pages: `src/pages/system/job_grades/`

#### 4-5. Dashboard (대시보드)

**기능**:
- 관리자 대시보드
- 성과관리 현황 모니터링

**하위 페이지**:
- **settings** - 대시보드 설정

**관련 코드**:
- Pages: `src/pages/system/dashboard/`

#### 4-6. Log (로그)

**기능**:
- 구성원 활동 로그
- 코멘트 로그
- 파일 로그
- HR 관리자 로그
- 전체 관리자 로그

**하위 페이지**:
- **comments** - 코멘트 로그
- **file** - 파일 로그
- **hr_admin** - HR 관리자 활동 로그
- **total_admin** - 전체 관리자 활동 로그

**관련 코드**:
- Pages: `src/pages/system/log/`

**참고**: 직무 관리는 Performance > Job Categories에 있음

---

### 5. Task (업무관리)

**경로**: `src/pages/task/`

#### 5-1. Task Board (업무보드 관리)

**기능**:
- 업무보드 생성/수정/삭제
- 공개 범위 설정
- 구성원 관리

**관련 코드**:
- Pages: `src/pages/task/task_board/`
- ppfront의 업무보드 시스템 설정

#### 5-2. Scrum Board (스크럼보드 관리)

**기능**:
- 스크럼보드 생성/수정/삭제
- 유형 설정
- 참여자 관리

**관련 코드**:
- Pages: `src/pages/task/scrum_board/`
- ppfront의 스크럼보드 시스템 설정

#### 5-3. Scrum (스크럼 설정)

**기능**:
- 스크럼 생성/관리
- 스크럼 설정

**관련 코드**:
- Pages: `src/pages/task/scrum/`

---

## 기술 스택 요약

### Core
- **React**: 18.2.0 (ppfront는 17.0.2)
- **TypeScript**: 4.2.4
- **Vite**: 4.5.3

### State Management
- **Redux Toolkit**: 1.9.5 (Modern Redux)
- **Redux Persist**: 6.0.0
- **React Query**: 5.35.1

### UI Framework
- **MUI**: v5 전용 (ppfront는 v4/v5 혼재)
- **AG Grid Enterprise**: 33.1.1
- **Formik**: 2.4.5 (폼 관리)

### Routing
- **React Router**: 6.14.2

더 자세한 내용은 [tech-stack.md](tech-stack.md)를 참고하세요.

---

## 프로젝트 구조 요약

```
talenx-admin/src/
├── pages/
│   ├── performance/       # 성과관리
│   │   ├── objective/
│   │   ├── feedback/
│   │   ├── one_on_one/
│   │   ├── review/
│   │   └─��� job_categories/
│   ├── appraisal/         # 평가관리
│   │   ├── settings/
│   │   ├── templates/
│   │   ├── records/
│   │   ├── ratings/
│   │   ├── objections/
│   │   └── open_result_records/
│   ├── multi_source_feedback/  # 360 피드백
│   │   ├── settings/
│   │   ├── templates/
│   │   ├── records/
│   │   ├── assessor_records/
│   │   └── group/
│   └── task/              # 업무관리
│       ├── task_board/
│       ├── scrum_board/
│       └── scrum/
├── components/            # Presentational 컴포넌트
├── containers/            # Container 컴포넌트
├── modules/               # Redux 모듈 (8개)
├── config/
│   ├── store.ts          # Redux Store
│   └── api/              # API 설정
├── hooks/                # Custom Hooks (29개)
├── helpers/              # 헬퍼 함수 (55개)
├── lib/                  # 유틸리티 (36개)
└── locales/              # 다국어 (i18n)
```

더 자세한 내용은 [project-structure.md](project-structure.md)를 참고하세요.

---

## 아키텍처 요약

### Redux Toolkit + React Query

- **Redux Toolkit**: 전역 상태 관리 (menu, user, organizations, members 등)
- **React Query**: 서버 상태 관리 (API 호출, 캐싱)
- **Formik**: 폼 상태 관리

더 자세한 내용은 [architecture.md](architecture.md)를 참고하세요.

---

## 코드 스타일 및 규칙

### ESLint 및 Prettier
- ESLint: 8.6.0
- Prettier: 1.18.2
- Husky + lint-staged: pre-commit hooks

### Import 순서
1. React 관련
2. External Libraries
3. MUI 관련
4. Internal Components
5. Modules (Redux)
6. Hooks
7. Lib/Helpers

더 자세한 내용은 [code-style.md](code-style.md)를 참고하세요.

---

## 개발 환경

### 설치
```bash
yarn install
```

### 개발 서버 실행
```bash
yarn start
# 또는
yarn vite
```

### 빌드
```bash
# Staging
yarn build:staging

# Production
yarn build:production
```

### E2E 테스트
```bash
# 일반 실행
yarn test:e2e

# UI 모드
yarn test:e2e:ui

# Headed 모드
yarn test:e2e:headed
```

---

## 참고 문서

### 기본 문서
- [tech-stack.md](tech-stack.md) - 기술 스택 상세
- [project-structure.md](project-structure.md) - 프로젝트 구조 상세
- [code-style.md](code-style.md) - 코딩 규칙
- [core-files.md](core-files.md) - 핵심 파일 설명
- [architecture.md](architecture.md) - 아키텍처 패턴

### 모듈별 상세 문서
- [modules/performance.md](modules/performance.md) - 성과관리 모듈
- [modules/appraisal.md](modules/appraisal.md) - 평가관리 모듈
- [modules/multi_source_feedback.md](modules/multi_source_feedback.md) - 360 피드백 모듈
- [modules/task.md](modules/task.md) - 업무관리 모듈

---

## ppfront와의 관계

### 역할 구분
- **ppfront**: 일반 사용자(구성원)가 사용
  - 목표 작성, 피드백 주고받기, 평가 응답 등
- **talenx-admin**: 어드민 권한이 있는 유저만 사용
  - 시스템 설정, 양식 관리, 현황 모니터링 등
  - HR Admin, Sub Admin

### 기능 연관성
talenx-admin에서 설정한 내용이 ppfront에서 사용됩니다:
- talenx-admin: 평가 생성 + 그룹 설정 + 평가 양식 연결 → ppfront: 구성원이 평가 응답
- talenx-admin: 360 피드백 대상자 지정 → ppfront: 평가자가 응답
- talenx-admin: 목표 설정 관리 → ppfront: 구성원이 목표 작성

**평가 구조 예시**:
```
평가 (Appraisal)
├── 그룹 A
│   ├── 대상자: 팀 A 구성원
│   ├── 평가자: 팀 A 관리자
│   └── 평가 양식: 일반 직원용 템플릿
└── 그룹 B
    ├── 대상자: 팀 B 구성원
    ├── 평가자: 팀 B 관리자
    └── 평가 양식: 관리자용 템플릿
```

---

**작성일**: 2025-10-23
**작성자**: Claude (AI Assistant)
**검증**: 실제 코드베이스 기반
