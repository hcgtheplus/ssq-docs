# SSQ-Docs 문서 개요

이 문서는 SSQ 프로젝트의 모든 문서에 대한 네비게이션 허브입니다.

---

## 프로젝트 소개

SSQ는 엔터프라이즈급 HR/HCM 성과관리 플랫폼입니다.

- **제품군**: Performance Plus, Talenx
- **주요 영역**: 성과관리, 업무관리, 360 진단, 평가관리

---

## 빠른 시작

### 새로 합류한 개발자라면?

1. [README.md](README.md) - 프로젝트 전체 소개 및 환경 구성
2. [docs/ppfront/overview.md](docs/ppfront/overview.md) - 프론트엔드 전체 구조 및 주요 기능

### 특정 기능을 확인하려면?

- [docs/ppfront/checklist.md](docs/ppfront/checklist.md) - 모든 기능의 상세 체크리스트

---

## 문서 구조

### 레포지토리 관리

- [README.md](README.md) - 레포지토리 소개, 사용법, 문서 작성 원칙
- [update-repos.sh](update-repos.sh) - 모든 레포 최신화 스크립트
- [.gitignore](.gitignore) - Git 추적 제외 항목

### ppfront (프론트엔드)

현재 문서:

- [docs/ppfront/overview.md](docs/ppfront/overview.md) - 전체 개요
  - 5개 주요 영역 (COMMON, 성과관리, 업무관리, 360 진단, 평가관리)
  - 기술 스택 (React 17, TypeScript, Vite, Redux)
  - 프로젝트 구조 (Container/Presentational 패턴)
  - 개발 환경 및 실행 명령어
- [docs/ppfront/checklist.md](docs/ppfront/checklist.md) - 기능별 상세 체크리스트
  - COMMON 영역 체크리스트
  - 성과관리 영역 체크리스트
  - 업무관리 영역 체크리스트
  - 360 진단 영역 체크리스트
  - 평가관리 영역 체크리스트

예정된 문서:

- docs/ppfront/tech-stack.md - 기술 스택 상세
- docs/ppfront/project-structure.md - 프로젝트 구조 상세
- docs/ppfront/code-style.md - 코딩 규칙 및 컨벤션
- docs/ppfront/core-files.md - 핵심 파일 및 유틸리티
- docs/ppfront/modules/ - 기능별 상세 문서

### ppback (백엔드)

예정:

- docs/ppback/overview.md
- docs/ppback/api-structure.md
- docs/ppback/models.md

### 기타 레포

예정:

- docs/talenx-admin/
- docs/theplus-back/
- docs/perpl-download/
- docs/perpl-notification/

### 빌드 기록

- [build_record/20251022_build_day_1.md](build_record/20251022_build_day_1.md) - Day 1 작업 일지
- [build_record/20251023_build_day_2.md](build_record/20251023_build_day_2.md) - Day 2 작업 일지
- [build_record/roadmap.md](build_record/roadmap.md) - 중장기 로드맵

---

## 상황별 문서 찾기

### 프론트엔드 개발 중이라면

**전체 구조를 파악하고 싶다면:**
→ [docs/ppfront/overview.md](docs/ppfront/overview.md)

**특정 기능 동작을 확인하고 싶다면:**
→ [docs/ppfront/checklist.md](docs/ppfront/checklist.md)에서 해당 영역 검색

**기술 스택이나 라이브러리를 확인하고 싶다면:**
→ [docs/ppfront/overview.md](docs/ppfront/overview.md)의 "기술 스택" 섹션

**코드 작성 규칙을 확인하고 싶다면:**
→ [docs/ppfront/overview.md](docs/ppfront/overview.md)의 "코드 스타일 및 규칙" 섹션

**환경 설정이나 실행 방법을 확인하고 싶다면:**
→ [docs/ppfront/overview.md](docs/ppfront/overview.md)의 "개발 환경" 섹션

### 백엔드 개발 중이라면

현재 문서 없음 (작성 예정)

### 환경 설정 중이라면

**전체 레포 클론 및 최신화:**
→ [README.md](README.md)의 "로컬 환경 구성" 섹션
→ [update-repos.sh](update-repos.sh) 스크립트 실행

### 프로젝트 진행 상황을 확인하고 싶다면

**일일 작업 기록:**
→ [build_record/](build_record/) 디렉토리의 일자별 파일

**향후 계획:**
→ [build_record/roadmap.md](build_record/roadmap.md)

---

## 주요 기능 영역별 문서

### 1. COMMON (공통 기능)

- GNB, 알림, 검색, 대시보드, 마이페이지
- 문서: [docs/ppfront/overview.md](docs/ppfront/overview.md#1-common-공통)
- 체크리스트: [docs/ppfront/checklist.md](docs/ppfront/checklist.md#common)

### 2. 성과관리

- 목표 (Objectives), 피드백 (Feedbacks), 1:1 미팅, 리뷰
- 문서: [docs/ppfront/overview.md](docs/ppfront/overview.md#2-성과관리)
- 체크리스트: [docs/ppfront/checklist.md](docs/ppfront/checklist.md#성과관리)

### 3. 업무관리

- 업무보드 (Task Board), 스크럼보드 (Scrum Board)
- 문서: [docs/ppfront/overview.md](docs/ppfront/overview.md#3-업무관리)
- 체크리스트: [docs/ppfront/checklist.md](docs/ppfront/checklist.md#업무관리)

### 4. 360 진단

- 360 피드백 (Multi-Source Feedbacks)
- 문서: [docs/ppfront/overview.md](docs/ppfront/overview.md#4-360-진단)
- 체크리스트: [docs/ppfront/checklist.md](docs/ppfront/checklist.md#360-진단)

### 5. 평가관리

- 평가 (Appraisals), 평가 대시보드
- 문서: [docs/ppfront/overview.md](docs/ppfront/overview.md#5-평가관리-appraisals)
- 체크리스트: [docs/ppfront/checklist.md](docs/ppfront/checklist.md#평가관리)

---

## 용어 정리

- **360 피드백**: Multi-Source Feedbacks (`multi_source_feedbacks`)
- **평가**: Appraisals (`appraisals`)
- **목표**: Objectives (`objectives`)
- **피드백**: Feedbacks (`feedbacks`) - 배지 피드백
- **업무보드**: Task Board (`task_board`)
- **스크럼보드**: Scrum Board (`scrum_board`)

---

## 문서 작성 원칙

1. **LLM 풀스캔 의존 금지**: 정성스럽게 작성된 문서 제공
2. **명확성과 정확성**: 할루시네이션 방지를 위한 정확한 정보
3. **기능 단위 문서화**: 프론트/백엔드 통합 관점
4. **지속적 업데이트**: 코드 변경 시 문서도 함께 업데이트
5. **경로 독립적**: 각 개발자의 로컬 환경에 관계없이 사용 가능

---

## 다음 단계

현재 진행 중인 작업은 [build_record/roadmap.md](build_record/roadmap.md)를 참고하세요.

**Phase 1 우선순위:**

1. ppfront 기본 문서 완성 (tech-stack, project-structure, code-style)
2. 주요 모듈 문서화 (objectives, appraisals)
3. ppback 문서 시작
