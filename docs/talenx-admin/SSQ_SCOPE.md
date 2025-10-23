# Talenx-Admin SSQ 문서화 범위

**작성일**: 2025-10-23
**목적**: SSQ 성과관리 시스템 관련 기능만 문서화

---

## ✅ 문서화 대상 (SSQ 관련)

talenx-admin은 전체 HR 시스템이지만, **SSQ 성과관리 시스템 관련 부분만** 문서화합니다.

### 1. Performance (성과관리)
**경로**: `src/pages/performance/`

#### 1-1. Objective (목표)
- 관리자 시스템에서의 목표 관리
- ppfront의 objectives와 동일한 기능
- **하위 페이지**: `src/pages/performance/objective/`

#### 1-2. Feedback (피드백/배지)
- 배지 피드백 관리
- ppfront의 feedbacks와 동일한 기능
- **하위 페이지**: `src/pages/performance/feedback/`

#### 1-3. One-on-One (1:1 미팅)
- 1:1 미팅 관리
- ppfront의 one_on_one과 동일한 기능
- **하위 페이지**: `src/pages/performance/one_on_one/`

#### 1-4. Review (리뷰)
- 리뷰 관리
- ppfront의 reviews와 동일한 기능
- **하위 페이지**: `src/pages/performance/review/`

#### 1-5. Job Categories (직무 카테고리)
- 직무 카테고리 설정
- **하위 페이지**: `src/pages/performance/job_categories/`

---

### 2. Appraisal (평가관리)
**경로**: `src/pages/appraisal/`

#### 2-1. Settings (평가 설정)
- 평가 생성/수정/삭제
- 평가 일정, 대상자, 평가자 설정
- **하위 페이지**: `src/pages/appraisal/settings/`

#### 2-2. Templates (평가 템플릿)
- 평가 양식 관리
- 영역/문항/배점 설정
- **하위 페이지**: `src/pages/appraisal/templates/`

#### 2-3. Records (평가 기록)
- 평가 진행 현황
- 평가 결과 조회
- **하위 페이지**: `src/pages/appraisal/records/`

#### 2-4. Appraiser Records (평가자 기록)
- 평가자별 진행 현황
- **하위 페이지**: `src/pages/appraisal/appraiser_records/`

#### 2-5. Ratings (등급)
- 등급 조정
- 등급 분포
- **하위 페이지**: `src/pages/appraisal/ratings/`

#### 2-6. Objections (이의신청)
- 이의신청 관리
- **하위 페이지**: `src/pages/appraisal/objections/`

#### 2-7. Open Result Records (결과 공개)
- 평가 결과 공개 관리
- **하위 페이지**: `src/pages/appraisal/open_result_records/`

---

### 3. Multi-Source Feedback (360 피드백)
**경로**: `src/pages/multi_source_feedback/`

#### 3-1. Settings (360 설정)
- 360 피드백 생성/수정/삭제
- 대상자, 평가자 설정
- **하위 페이지**: `src/pages/multi_source_feedback/settings/`

#### 3-2. Templates (360 템플릿)
- 360 피드백 양식 관리
- **하위 페이지**: `src/pages/multi_source_feedback/templates/`

#### 3-3. Records (360 기록)
- 360 피드백 진행 현황
- 응답 결과 조회
- **하위 페이지**: `src/pages/multi_source_feedback/records/`

#### 3-4. Assessor Records (평가자 기록)
- 평가자별 응답 현황
- **하위 페이지**: `src/pages/multi_source_feedback/assessor_records/`

#### 3-5. Group (그룹 360)
- 그룹 360 피드백 관리
- **하위 페이지**: `src/pages/multi_source_feedback/group/`

---

### 4. Task (업무관리)
**경로**: `src/pages/task/`

#### 4-1. Task Board (업무보드)
- 업무보드 관리
- ppfront의 task_board와 동일한 기능
- **하위 페이지**: `src/pages/task/task_board/`

#### 4-2. Scrum Board (스크럼보드)
- 스크럼보드 관리
- ppfront의 scrum_board와 동일한 기능
- **하위 페이지**: `src/pages/task/scrum_board/`

#### 4-3. Scrum (스크럼 설정)
- 스크럼 생성/관리
- 스크럼 설정
- **하위 페이지**: `src/pages/task/scrum/`

---

## ❌ 문서화 제외 (SSQ 무관)

다음은 HR/급여/근태 관련이므로 **문서화하지 않습니다**:

### 제외 영역
1. **HR Core** (`src/pages/hrcore/`)
   - 조직, 구성원, 발령 등 인사 기본 정보

2. **Attendance** (`src/pages/attendance/`)
   - 근태관리

3. **Pay** (`src/pages/pay/`)
   - 급여관리

4. **SINS** (`src/pages/sins/`)
   - 4대보험

5. **Report** (`src/pages/report/`)
   - 보고서 (SSQ 무관)

6. **System** (`src/pages/system/`)
   - 시스템 설정 중 SSQ 무관 부분
   - 단, **job_grades**(직급)는 성과관리에 사용되므로 참고 가능

---

## 📝 문서화 전략

### 기본 문서 (공통)
ppfront 참고하여 6개 기본 문서 작성:

1. **tech-stack.md** - 기술 스택 (전체, 간결하게)
2. **project-structure.md** - SSQ 관련 디렉토리 구조만
3. **code-style.md** - 코딩 규칙
4. **core-files.md** - main.tsx, App.tsx, store 등
5. **architecture.md** - Redux Toolkit + React Query
6. **architecture-patterns.md** - Formik, AG Grid 패턴

### 모듈별 상세 문서
ppfront의 modules/ 구조 참고:

1. **modules/performance.md**
   - objective, feedback, one_on_one, review, job_categories 통합

2. **modules/appraisal.md**
   - settings, templates, records, ratings, objections 통합

3. **modules/multi_source_feedback.md**
   - 360 피드백 전체

4. **modules/task.md**
   - task_board, scrum_board, scrum 통합

---

## 🎯 ppfront와의 관계

### talenx-admin = 관리자 시스템
- **ppfront**: 일반 사용자용 (구성원 + 관리자)
- **talenx-admin**: 관리자 전용 (HR Admin, Sub Admin, 조직장)

### 기능 중복
talenx-admin의 Performance는 ppfront와 **동일한 기능을 관리자 시점에서 제공**:
- ppfront: 내 목표, 내 피드백
- talenx-admin: 전체 구성원의 목표, 피드백 관리

### 차이점
- **Appraisal/Multi-Source Feedback**: 관리자 전용 (설정, 템플릿, 현황)
- **Task**: ppfront와 동일하지만 관리자 뷰

---

## ✅ Phase 1 사전 조사 (SSQ 범위)

### 확인 완료
- [x] Performance 페이지 구조 (5개)
- [x] Appraisal 페이지 구조 (7개)
- [x] Multi-Source Feedback 페이지 구조 (5개)
- [x] Task 페이지 구조 (3개)
- [x] 총 **20개 페이지**

### 제외 확인
- [x] HR Core 제외 (17개 페이지)
- [x] Pay 제외 (20+ 페이지)
- [x] Attendance 제외 (4개 페이지)
- [x] SINS 제외 (3개 페이지)
- [x] System 제외 (대부분, job_grades만 참고)

---

## 📊 예상 작업량 (SSQ 범위)

### Phase 2: 기본 문서 (3-4시간)
- tech-stack.md (45분)
- project-structure.md (45분) - SSQ 관련만
- code-style.md (30분)
- core-files.md (45분)
- architecture.md (45분)
- architecture-patterns.md (45분)

### Phase 3: 모듈 문서 (8-10시간)
- modules/performance.md (2-3시간)
- modules/appraisal.md (2-3시간)
- modules/multi_source_feedback.md (2-3시간)
- modules/task.md (1-2시간)

### 총 예상 시간
- **11-14시간** (2-3일)
- ppfront 대비 50% 작업량 (SSQ 범위만)

---

**작성자**: Claude (AI Assistant)
**확인자**: (사용자)
**최종 업데이트**: 2025-10-23
