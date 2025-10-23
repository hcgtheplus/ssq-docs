# SSQ-Docs 중장기 로드맵

## 현재 상태 (2025-10-23)

### 완료
- ✓ 레포지토리 초기 설정
- ✓ 모든 관련 레포 클론 (update-repos.sh)
- ✓ ppfront overview.md 작성
- ✓ 기능 체크리스트 문서화
- ✓ build_record 디렉토리 구조

---

## Phase 1: 기본 문서화 (1-2주)

### ppfront 문서 완성
- [ ] tech-stack.md - 기술 스택 상세
- [ ] project-structure.md - 프로젝트 구조 상세
- [ ] code-style.md - 코딩 규칙 및 컨벤션
- [ ] core-files.md - 핵심 파일 및 유틸리티

### 주요 모듈 문서화
- [ ] modules/objectives.md - 목표 관리
- [ ] modules/appraisals.md - 평가 관리
- [ ] modules/multi_source_feedbacks.md - 360 피드백
- [ ] modules/task_board.md - 업무보드
- [ ] modules/feedbacks.md - 피드백 (배지)
- [ ] modules/one_on_one.md - 1:1 미팅
- [ ] modules/reviews.md - 리뷰

### ppback 문서 시작
- [ ] docs/ppback/overview.md
- [ ] docs/ppback/api-structure.md
- [ ] docs/ppback/models.md
- [ ] docs/ppback/services.md

---

## Phase 2: 구조 개선 (2-3주)

### 3-tier 문서 구조 적용
Claude Code Development Kit 참고

#### Tier 1: Foundation (기초)
- [ ] docs-overview.md - 전체 문서 네비게이션 허브
- [ ] architecture.md - 전체 아키텍처 개요
- [ ] getting-started.md - 신규 개발자 온보딩

#### Tier 2: Components (컴포넌트)
- [ ] 현재 tech-stack.md, project-structure.md 등을 이 레벨로 재구성
- [ ] 각 주요 기술/라이브러리별 상세 가이드
- [ ] 공통 패턴 및 유틸리티 문서

#### Tier 3: Features (기능)
- [ ] 현재 modules/ 문서들을 이 레벨로 유지
- [ ] 각 기능의 프론트/백엔드 통합 플로우
- [ ] API 연동 문서

### Custom Slash Commands 구현
- [ ] `/full-context` - 전체 컨텍스트 로드
- [ ] `/update-docs` - 문서 자동 업데이트
- [ ] `/module-docs <모듈명>` - 특정 모듈 문서 조회
- [ ] `/api-docs <엔드포인트>` - API 문서 조회

---

## Phase 3: MCP 서버화 (3-4주)

### MCP 서버 구현
- [ ] package.json 설정
- [ ] MCP 서버 코드 작성 (src/index.ts)
- [ ] 문서 제공 API 구현
- [ ] 문서 검색 기능

### MCP 기능
- [ ] 전체 문서 목록 조회
- [ ] 특정 문서 내용 반환
- [ ] 키워드 기반 문서 검색
- [ ] 관련 문서 추천
- [ ] 문서 간 참조 네비게이션

### 통합 테스트
- [ ] 각 작업 레포에서 MCP 서버 연동
- [ ] 새로운 Claude 세션에서 문서 참조 검증
- [ ] 성능 및 효율성 측정

---

## Phase 4: 자동화 및 최적화 (4-5주)

### Hooks 시스템
- [ ] pre-commit: 문서 일관성 검증
- [ ] post-commit: 자동 문서 업데이트 체크
- [ ] 보안 스캔: 민감 정보 노출 방지

### Sub-agent Context Injector
- [ ] 모든 에이전트에 자동 컨텍스트 주입
- [ ] 에이전트별 필요 문서 자동 선택
- [ ] 컨텍스트 캐싱 최적화

### 문서 자동 생성
- [ ] 코드 변경 시 문서 업데이트 제안
- [ ] API 변경 시 API 문서 자동 생성
- [ ] 타입 정의에서 문서 추출

---

## Phase 5: 고급 기능 (5주 이후)

### 비즈니스 로직 문서화
- [ ] docs/business-logic/ 디렉토리 생성
- [ ] 주요 비즈니스 프로세스 문서화
- [ ] 의사결정 로직 명시
- [ ] 예외 케이스 처리 문서화

### 통합 문서
- [ ] 프론트/백엔드 통합 플로우
- [ ] 인증/권한 체계
- [ ] 데이터 플로우 다이어그램
- [ ] 에러 처리 가이드

### 커스텀 로직 문서화
- [ ] Coway 커스텀 로직
- [ ] Innocean 커스텀 로직
- [ ] Maeil 커스텀 로직
- [ ] NHQV 커스텀 라우팅

### 다른 레포 문서화
- [ ] docs/talenx-admin/
- [ ] docs/theplus-back/
- [ ] docs/perpl-download/
- [ ] docs/perpl-notification/

---

## Phase 6: 지속적 개선

### 문서 품질 관리
- [ ] 정기적 문서 리뷰 프로세스
- [ ] 개발자 피드백 수집
- [ ] 문서 사용 패턴 분석
- [ ] 불필요한 문서 정리

### AI 효율성 측정
- [ ] 할루시네이션 발생률 추적
- [ ] 문서 참조 빈도 측정
- [ ] 개발 속도 개선 측정
- [ ] 에러 발생률 감소 측정

### 확장성
- [ ] 다국어 문서 지원 (영어)
- [ ] 문서 버전 관리
- [ ] 히스토리 추적
- [ ] 문서 변경 알림

---

## 우선순위

### High Priority (즉시 시작)
1. ppfront 기본 문서 완성 (tech-stack, project-structure, code-style)
2. 주요 모듈 문서화 (objectives, appraisals)
3. docs-overview.md 생성

### Medium Priority (2-3주 내)
1. 3-tier 구조 재정리
2. Custom slash commands
3. ppback 기본 문서

### Low Priority (장기)
1. MCP 서버화
2. 자동화 hooks
3. 기타 레포 문서화

---

## 성공 지표

### 정량적 지표
- [ ] 전체 문서 커버리지 80% 이상
- [ ] 주요 기능 100% 문서화
- [ ] 할루시네이션 발생률 50% 감소
- [ ] 신규 개발자 온보딩 시간 50% 단축

### 정성적 지표
- [ ] Claude가 정확한 코드 위치를 참조하는가?
- [ ] 비즈니스 로직을 올바르게 이해하는가?
- [ ] 커스텀 로직 할루시네이션이 감소했는가?
- [ ] 개발자들이 문서를 유용하게 사용하는가?

---

## 리스크 및 대응

### 리스크
1. 문서 작성 시간 소요 과다
2. 문서와 코드 불일치 발생
3. MCP 서버 성능 이슈
4. 개발자의 문서 업데이트 누락

### 대응 방안
1. 핵심 기능부터 우선 문서화
2. 자동 문서 검증 시스템 구축
3. 캐싱 및 최적화 전략
4. Git hooks로 문서 업데이트 강제

---

## 다음 액션 아이템

### 이번 주 (2025-10-23 ~ 10-27)
1. docs-overview.md 생성
2. ppfront/tech-stack.md 작성
3. ppfront/modules/objectives.md 시작

### 다음 주 (10-28 ~ 11-03)
1. ppfront 나머지 기본 문서 완성
2. ppback overview 시작
3. Custom slash commands 프로토타입
