# Objectives (목표 관리)

> **이 문서는**: ppfront의 목표 관리 기능을 상세히 설명합니다.
> **언제 보나**: 목표 생성/수정/조회 기능을 구현하거나 수정할 때
> **관련 문서**:
> - 전체 개요: [../overview.md](../overview.md#2-1-목표-objectives)
> - 아키텍처: [../architecture.md](../architecture.md)
> - 기능 체크리스트: [../checklist.md](../checklist.md#목표-objectives)

---

## 목차

1. [개요](#개요)
2. [주요 기능](#주요-기능)
   - [1. 목표 생성 및 관리](#1-목표-생성-및-관리)
   - [2. Key Results 관리](#2-key-results-핵심-성과-관리)
   - [3. 목표 목록 조회](#3-목표-목록-조회)
   - [4. 목표 맵](#4-목표-맵-objective-map)
   - [5. 목표 가중치 설정](#5-목표-가중치-설정)
   - [6. 체크인](#6-체크인-check-in)
   - [7. 고급 설정](#7-고급-설정-advanced-options)
   - [8. AI 목표 추천](#8-ai-목표-추천-objective-ai-recommendation)
   - [9. 목표 활동 제한 설정](#9-목표-활동-제한-설정)
3. [데이터 구조](#데이터-구조)
   - [Objective (목표)](#objective-목표)
   - [Key Result (핵심 성과)](#key-result-핵심-성과)
   - [Objective Stage (목표 단계)](#objective-stage-목표-단계)
4. [파일 구조](#파일-구조)
   - [Redux 모듈](#redux-모듈)
   - [컴포넌트](#컴포넌트)
   - [컨테이너](#컨테이너)
   - [페이지](#페이지)
   - [유틸리티](#유틸리티)
   - [Hooks](#hooks)
5. [주요 플로우](#주요-플로우)
   - [1. 목표 생성 플로우](#1-목표-생성-플로우)
   - [2. 목표 리스트 조회 플로우](#2-목표-리스트-조회-플로우)
   - [3. Key Result 진행률 계산 플로우](#3-key-result-진행률-계산-플로우)
   - [4. 목표 가중치 승인 플로우](#4-목표-가중치-승인-플로우)
6. [Redux 상태 관리](#redux-상태-관리)
   - [State 구조](#state-구조)
   - [주요 액션](#주요-액션)
7. [API 엔드포인트](#api-엔드포인트)
   - [목표 CRUD](#목표-crud)
   - [목표 리스트](#목표-리스트)
   - [목표 마감](#목표-마감)
   - [Key Results](#key-results)
   - [체크인](#체크인)
   - [가중치](#가중치)
   - [파일](#파일)
   - [댓글/피드백](#댓글피드백)
   - [설정/태그](#설정태그)
   - [AI 추천](#ai-추천)
8. [주요 컴포넌트](#주요-컴포넌트)
   - [1. ObjectiveForm.jsx](#1-objectiveformjsx---목표-생성수정-폼)
   - [2. KeyResults.jsx](#2-keyresultsjsx---key-results-관리)
   - [3. KeyResultInput.jsx](#3-keyresultinputjsx---key-result-개별-입력)
   - [4. MemberObjectiveList.jsx](#4-memberobjectivelistjsx---구성원별-목표-리스트)
   - [5. ObjectiveCard](#5-objectivecard---목표-카드)

---

## 개요

목표(Objectives) 기능은 SSQ의 핵심 성과관리 기능으로, 개인/팀/조직의 목표를 설정하고 추적하는 시스템입니다.

### 핵심 개념

- **Objective (목표)**: 달성하고자 하는 목표
- **Key Results (핵심 성과)**: 목표 달성을 측정하는 지표
- **Cycle (주기)**: 목표 관리 기간 (분기, 반기, 연간 등)
- **Weight (가중치)**: 목표별 중요도 (%)
- **Check-in (체크인)**: 목표 진행 상황 업데이트

---

## 주요 기능

> **빠른 참조**:
> - 목표 생성/수정/삭제 → [#1](#1-목표-생성-및-관리)
> - Key Results 관리 (4가지 방식) → [#2](#2-key-results-핵심-성과-관리)
> - 목표 목록 (4가지 탭) → [#3](#3-목표-목록-조회)
> - 목표 맵 (조직 트리) → [#4](#4-목표-맵-objective-map)
> - 가중치 설정/승인 → [#5](#5-목표-가중치-설정)
> - 체크인 (진행 업데이트) → [#6](#6-체크인-check-in)
> - 고급 설정 (7가지 옵션) → [#7](#7-고급-설정-advanced-options)
> - AI 목표 추천 → [#8](#8-ai-목표-추천-objective-ai-recommendation)

### 1. 목표 생성 및 관리

- 목표 생성/수정/삭제
- 목표 마감 (Close) 및 마감 취소
- 목표 보관 (Archive) - 삭제 처리되나 복원 가능
- 임시 저장 기능

### 2. Key Results (핵심 성과) 관리

- Key Result 추가/수정/삭제
- 관리방식 설정 (4가지 방식)
  - **달성률**: 퍼센트 기반 진행률 관리
  - **절대값**: 고정된 목표값 달성 여부
  - **구간**: 시작값-목표값 구간 내 진행률 (증가/감소, 이상/미만/초과/이하)
  - **여부**: 완료/미완료 이진 관리
- 진행률 자동 계산
- 상위 목표 연계

### 3. 목표 목록 조회

목표 목록은 4가지 탭으로 구성됩니다:

#### 3-1. 나의 목표 요약
- 현재 주기의 내 목표 요약 정보
- 진행 중인 목표 통계

#### 3-2. 소속 기준
- **내 목표**: 내가 담당자인 목표
- **조직별 목표**: 조직 카드로 그룹핑
  - **조직 탭**: 해당 조직의 팀 목표
  - **구성원 탭**: 해당 조직 구성원들의 개인 목표

#### 3-3. 역할 기준
- **내가 담당자**: 내가 담당자로 지정된 목표
- **내가 관리자**: 내가 관리자로 지정된 목표 (승인 권한)
- **내가 팔로우**: 내가 팔로우하는 목표

#### 3-4. 나의 전체 목표 (주기별)
- 주기별 내 목표 전체 조회
- 과거 주기 목표 확인

**필터링 및 정렬**:
- 필터링: 주기, 상태, 태그 등 (도메인 로직에 따라 구현)
- 정렬: 업데이트 날짜, 진행률, 마감일 등 (코드 참조)

### 4. 목표 맵 (Objective Map)

- 조직도 기반 목표 트리 구조
- 상위-하위 목표 연결 시각화
- 조직 전체 목표 현황 파악

### 5. 목표 가중치 설정

- 목표별 가중치 설정 (%)
- 가중치 승인 프로세스
- 가중치 변경 이력 관리

### 6. 체크인 (Check-in)

> **참고**: 체크인 기능은 어드민에서 "체크인 필요" 옵션 설정에 따라 활성화/비활성화됩니다.

- 목표 진행 상황 업데이트
- Key Result 값 입력
- 진행률 자동 계산
- 체크인 이력 관리

### 7. 고급 설정 (Advanced Options)

목표 생성/수정 폼에서 **"고급 설정"** 체크박스를 통해 추가 옵션들을 표시/숨김 처리합니다.

#### 고급 설정 활성화 시 표시되는 항목:

1. **관련 사용자 설정** (RelatedUserForm)
   - 관리자 (Managers) 지정
   - 팔로워 (Followers) 지정
   - 조건: `hasAdvancedObjectiveCreateOptions || managers.length === 0 || isDefaultManagersEmpty`

2. **목표 가중치 설정** (ObjectiveWeightForm)
   - 목표 가중치 입력 (%)
   - 조건: `hasAdvancedObjectiveCreateOptions && useWeightWithObjectivePage`

3. **직접 승인 설정** (DirectApprovalForm)
   - 체크인 직접 승인
   - 수정 직접 승인
   - 마감 직접 승인
   - 삭제 직접 승인
   - 조건: `hasAdvancedObjectiveCreateOptions && canEditDirectApprovalSetting`

4. **비활성 알림 기간** (InactiveAlertTerm)
   - 목표 활동이 없을 때 알림 기간 설정 (일)
   - 기본값: 28일
   - 조건: `hasAdvancedObjectiveCreateOptions && !isSKBioscienceWorkspace`

5. **태그 설정** (TagSetting)
   - 목표 태그 선택
   - 조건: `hasAdvancedObjectiveCreateOptions || useTagsRequired`

6. **공개 범위 설정** (PrivacyForm)
   - 전체 공개 (all)
   - 선택 공개 (select) - 특정 사용자/팀만
   - 비공개 (private)
   - 조건: `hasAdvancedObjectiveCreateOptions || (privacy === "select" && selectAuthorizedMembers.length === 0)`

7. **검토자 설정** (ReviewerForm)
   - 목표 검토자 지정
   - 조건: `hasAdvancedObjectiveCreateOptions || !reviewer || isDefaultReviewerEmpty`

#### 구현 위치:

- **Component**: [components/objective/form/index.jsx:488-498](../../ppfront/src/components/objective/form/index.jsx#L488-L498)
- **State**: [containers/objective/Form.jsx:70](../../ppfront/src/containers/objective/Form.jsx#L70)
- **Handler**: [containers/objective/Form.jsx:1039-1048](../../ppfront/src/containers/objective/Form.jsx#L1039-L1048)

```javascript
// 고급 설정 체크박스 (components/objective/form/index.jsx:488-498)
<CheckBox
  name="hasAdvancedObjectiveCreateOptions"
  checked={hasAdvancedObjectiveCreateOptions}
  onChange={onCheckedChange}
  disabled={canNotCheckAdvancedObjectiveCreateOption}
  label={t("NEW.advancedOption")} // "고급 설정"
/>

// 상태 변경 핸들러 (containers/objective/Form.jsx:1039-1048)
handleCheckedChange = event => {
  const { target: { name, checked } } = event;
  this.setState(
    { [name]: checked, promptStatus: true },
    this.isObjectiveStateChanged
  );
};
```

### 8. AI 목표 추천 (Objective AI Recommendation)

목표 생성 시 AI가 맞춤형 목표를 추천하는 기능입니다.

#### 주요 특징:

1. **추천 가능 여부 확인**
   - Workspace 설정에서 `use_ai_objective_recommendation` 옵션 확인
   - API: `GET /workspaces/:workspaceId/ai_features?type=user`
   - Hook: `useObjectiveAIRecommendation` - `hasRecommendationAvailable` 상태

2. **AI 추천 버튼**
   - 목표 생성 페이지 상단에 표시
   - 조건: `!isEdit && hasRecommendationAvailable && !isRecommendationCheckLoading`
   - 비활성화 조건: 상위 목표 핵심성과 연계 시 (`isConnectedWithSuperKeyResult`)
   - 컴포넌트: [ObjectiveAIRecommendationButton.jsx](../../ppfront/src/components/AI_objective/on_create_recommend/ObjectiveAIRecommendationButton.jsx)

3. **추천 생성 프로세스**
   ```
   User: "AI 목표 추천" 버튼 클릭
       ↓
   Hook: useObjectiveAIRecommendation.handleModalOpen()
       ├─ 모달 즉시 열기
       ├─ 로딩 상태 표시
       ├─ API: POST /workspaces/:workspaceId/objectives/ai_recommendation
       │   └─ Body: { prompt: AI_FEATURE_OBJECTIVE_RECOMMENDATION_PROMPT }
       ↓
   Response: recommendedOkrs[]
       ├─ priorityRank (추천순위)
       ├─ confidence (신뢰도)
       ├─ objective { name, description }
       ├─ keyResults[]
       ├─ alignment (상위 목표 연계성)
       ├─ references (참조 근거)
       ├─ differentiation (기존 목표와의 차별점)
       └─ expectedImpact (기대 효과)
       ↓
   Modal: ObjectiveAIRecommendationModal
       ├─ 추천 목표 리스트 표시
       ├─ 각 항목 확장/축소 가능
       ├─ 사용자 선택
       └─ "확인" 클릭
       ↓
   Form: onApplyAiRecommendation(selectedOKR)
       ├─ 목표명 자동 입력
       ├─ 설명 자동 입력
       └─ Key Results 자동 생성
   ```

4. **에러 처리**
   - API 실패 시: `errorMessage` 표시
   - AbortController로 중복 요청 방지
   - 모달 닫을 때 진행 중인 요청 중단

#### 구현 위치:

- **Hook**: [hooks/AI_objective/on_create_recommend/useObjectiveAIRecommendation.jsx](../../ppfront/src/hooks/AI_objective/on_create_recommend/useObjectiveAIRecommendation.jsx)
- **Button**: [components/AI_objective/on_create_recommend/ObjectiveAIRecommendationButton.jsx](../../ppfront/src/components/AI_objective/on_create_recommend/ObjectiveAIRecommendationButton.jsx)
- **Modal**: [components/AI_objective/on_create_recommend/ObjectiveAIRecommendationModal.jsx](../../ppfront/src/components/AI_objective/on_create_recommend/ObjectiveAIRecommendationModal.jsx)
- **Form 통합**: [components/objective/form/index.jsx:357-381, 500-511, 756-766](../../ppfront/src/components/objective/form/index.jsx)

```javascript
// Hook 사용 (components/objective/form/index.jsx:357-372)
const {
  aiRecommendationModalOpen,
  aiRecommendationLoading,
  recommendedOKRs,
  selectedOKRPriorityRank,
  errorMessage,
  expandedPriorityRanks,
  hasRecommendationAvailable,
  isRecommendationCheckLoading,
  handleModalOpen,
  handleModalClose,
  handleOKRSelection,
  handleConfirmSelection,
  toggleExpanded,
} = useObjectiveAIRecommendation({ workspaceId });

// AI 추천 적용 (components/objective/form/index.jsx:375-381)
const handleConfirmAISelection = () => {
  const selectedOKR = handleConfirmSelection();
  if (selectedOKR) {
    onApplyAiRecommendation(selectedOKR);
  }
};
```

### 9. 목표 활동 제한 설정

- 비활성 알림 설정
- 목표 활동 기간 제한
- 알림 주기 설정

---

## 데이터 구조

### Objective (목표)

```typescript
interface IObjectiveItem {
  id: number;
  name: string;                     // 목표명
  description: string;              // 설명
  progress: number;                 // 진행률 (0-100)
  status: string;                   // 상태 (active, closed, archived)
  stage: ObjectiveStage;            // 단계 (pending_create, pending_update 등)
  cycleId: number;                  // 사이클 ID
  weight: number | null;            // 가중치 (%)
  hasWeight: number;                // 가중치 사용 여부
  startedOn: string;                // 시작일
  endedOn: string;                  // 종료일
  createdAt: string;
  updatedAt: string;

  // 담당자/팀
  assignees: {
    userIds: number[];              // 담당자 ID 목록
    teamIds: number[];              // 담당 팀 ID 목록
  };

  // Key Results
  keyResults?: IObjectiveItemKeyResult[];

  // 태그
  tagIds: number[];

  // 상태 플래그
  isNew: boolean;                   // 신규 목표 여부
  isIndivObj: boolean;              // 개인 목표 여부
  isCheckinPending: boolean;        // 체크인 대기 중
  uncheckCount: number;             // 미확인 개수

  // 승인 관련
  approveType?: "objective";
  approver?: {
    userId: number;
    displayName: string;
    avatar: { url: string };
  };
}
```

### Key Result (핵심 성과)

```typescript
interface IObjectiveItemKeyResult {
  id: number;
  name: string;                     // Key Result명
  weight: number;                   // 가중치 (%)

  // 진행률 계산 관련
  intervalType: string;             // 구간 타입 (increase, decrease)
  intervalOption: string;           // 구간 옵션 (more_than, less_than, over, under)
  startValue: number;               // 시작값
  targetValue: number;              // 목표값
  currentValue: number;             // 현재값
  progress: number;                 // 진행률 (0-100)

  // 상위 목표 연계
  superKeyResultId?: number;        // 상위 Key Result ID
}
```

### Objective Stage (목표 단계)

```typescript
type ObjectiveStage =
  | "pending_check_in"              // 체크인 대기
  | "pending_archive"               // 보관 대기
  | "pending_closed"                // 마감 대기
  | "pending_create"                // 생성 대기
  | "pending_restore"               // 복원 대기
  | "pending_update"                // 수정 대기
  | "pending_archive_restore";      // 보관 복원 대기
```

### Objective Weight (가중치)

```typescript
interface IObjectiveAfterWeightChangeItem {
  id: number;
  weight: number;                   // 현재 가중치
  nextWeight: number;               // 다음 가중치 (승인 대기)
  status: string;                   // 상태 (pending, approved, rejected)
  cycleId: number;
  objectiveId: number;
  userId: number;
  approverId: number;
  approver: {
    userId: number;
    displayName: string;
    avatar: { url: string };
  };
}
```

---

## 파일 구조

> **빠른 참조**:
> - Redux 모듈 → [objectives.js](#redux-모듈), [objectives/](#redux-모듈)
> - 컴포넌트 → [form/](#컴포넌트), [list/](#컴포넌트), [show/](#컴포넌트), [map/](#컴포넌트), [weight/](#컴포넌트)
> - 컨테이너 → [Form.jsx](#컨테이너), [List.jsx](#컨테이너), [Show.jsx](#컨테이너)
> - 페이지 → [new/](#페이지), [list/](#페이지), [show/](#페이지)
> - Hook → [useObjectiveAIRecommendation](#hooks)
> - Lib → [objectives.js](#유틸리티), [constants.js (findIntervalProgress)](#유틸리티)

### Redux 모듈

```
src/modules/
├── objectives.js                   # 메인 목표 모듈
└── objectives/
    ├── list.js                     # 목표 리스트 관리
    ├── close_requests.js           # 목표 마감 요청
    ├── trees.js                    # 목표 트리 (맵)
    └── weight.js                   # 가중치 관리
```

### 컴포넌트

```
src/components/objective/
├── form/                           # 목표 생성/수정 폼
│   ├── index.jsx                  # 폼 메인 진입점
│   ├── Buttons.jsx                # 폼 버튼 (저장, 취소 등)
│   ├── DirectApproval.jsx         # 직접 승인 설정
│   ├── ErrorMessage.tsx           # 에러 메시지 표시
│   ├── InactiveAlertTerm.jsx      # 비활성 알림 설정
│   ├── KeyResult.jsx              # Key Result 관리
│   ├── KeyResultInput.jsx         # Key Result 개별 입력
│   ├── Privacy.jsx                # 공개 설정
│   ├── RelatedUser.jsx            # 관련 사용자
│   ├── Reviewer.jsx               # 검토자 설정
│   ├── TagSetting.tsx             # 태그 설정
│   ├── content/                   # 폼 콘텐츠 컴포넌트
│   │   ├── ObjectiveForm.jsx      # 목표 폼 메인
│   │   ├── ObjectiveWeightForm.tsx # 가중치 폼
│   │   ├── KeyResults.jsx         # Key Results 전체 관리
│   │   ├── KeyResultInput.jsx     # Key Result 입력
│   │   ├── Buttons.jsx            # 폼 버튼
│   │   ├── DirectApproval.tsx     # 직접 승인
│   │   ├── InactiveAlertTerm.jsx  # 비활성 알림
│   │   ├── Privacy.jsx            # 공개 설정
│   │   ├── RelatedUser.jsx        # 관련 사용자
│   │   ├── Reviewer.jsx           # 검토자
│   │   └── TagSetting.tsx         # 태그
│   └── modalContents/             # 모달 콘텐츠
│       ├── DescriptionModal.jsx   # 설명 모달
│       └── DescriptionModalContents.tsx
├── list/                           # 목표 리스트
│   ├── index.jsx                  # 리스트 메인
│   ├── Header.jsx                 # 헤더 (필터, 탭)
│   ├── Tabs.jsx                   # 탭 네비게이션
│   ├── Title.jsx                  # 타이틀
│   ├── NoResult.jsx               # 검색 결과 없음
│   ├── GroupObjectiveList.jsx     # 그룹별 목표 리스트
│   ├── OrganizationCardSettingDialog.tsx  # 조직 카드 설정
│   ├── SortSetting.tsx            # 정렬 설정
│   ├── StageIconLabel.tsx         # 단계 아이콘 라벨
│   └── main/                      # 메인 리스트 컴포넌트
│       ├── AlertPaper.tsx         # 알림 페이퍼
│       ├── AssigneeObjective.jsx  # 담당자별 목표
│       ├── BelongList.jsx         # 소속 기준 리스트
│       ├── ContentHeader.tsx      # 콘텐츠 헤더
│       ├── ContentMain.jsx        # 콘텐츠 메인
│       ├── DoughnutChart.jsx      # 도넛 차트
│       ├── ManagerExcelDownload.tsx  # 관리자 엑셀 다운로드
│       ├── MemberObjectiveList.jsx   # 구성원별 목표 리스트
│       ├── MyAssignedList.jsx     # 내가 담당한 목표
│       ├── MyTotalProgress.jsx    # 내 전체 진행률
│       ├── Objective.jsx          # 목표 아이템
│       ├── ObjectiveGroup.jsx     # 목표 그룹
│       ├── ParticipatingList.jsx  # 참여 중인 목표
│       ├── PendingObjective.jsx   # 승인 대기 목표
│       ├── PendingObjectiveItem.tsx  # 승인 대기 아이템
│       ├── SortTab.jsx            # 정렬 탭
│       ├── StatusChartObjective.jsx  # 상태 차트 목표
│       └── SummaryList.tsx        # 요약 리스트
├── show/                           # 목표 상세
│   ├── index.jsx                  # 상세 메인
│   ├── AttachedTags.tsx           # 첨부 태그
│   ├── HoverButton.jsx            # 호버 버튼
│   ├── MultisoucrceTakerRow.jsx   # 다면평가 응시자
│   ├── ObjectiveButtons.jsx       # 목표 버튼
│   ├── ObjectiveDescription.jsx   # 목표 설명
│   ├── ObjectiveHeader.jsx        # 목표 헤더
│   ├── content/                   # 상세 콘텐츠
│   │   ├── ObjectiveButtons.jsx   # 목표 버튼
│   │   ├── ObjectiveDescription.tsx  # 목표 설명
│   │   ├── ObjectiveHeader.jsx    # 목표 헤더
│   │   ├── ObjectiveProgress.jsx  # 목표 진행률
│   │   └── UserList.jsx           # 사용자 목록
│   ├── key_result/                # Key Result 관련
│   │   ├── CalculatorModal.jsx    # 계산기 모달
│   │   ├── Item.jsx               # Key Result 아이템
│   │   ├── List.jsx               # Key Result 리스트
│   │   ├── SuperObjectiveKeyResult.jsx  # 상위 목표 KR
│   │   └── Table.jsx              # Key Result 테이블
│   └── right/                     # 우측 정보 패널
│       ├── InfoList.jsx           # 정보 리스트
│       ├── InfoListDrawer.jsx     # 정보 드로어
│       └── InfoSkeleton.tsx       # 정보 스켈레톤
├── map/                            # 목표 맵
│   ├── index.jsx                  # 맵 메인
│   ├── Card.jsx                   # 목표 카드
│   ├── DetailModal.jsx            # 상세 모달
│   ├── Node.jsx                   # 트리 노드
│   ├── NonExistentObjective.jsx   # 존재하지 않는 목표
│   ├── OrganizationChart.jsx      # 조직 차트
│   ├── StatusSpan.jsx             # 상태 스팬
│   ├── Tree.jsx                   # 트리 컴포넌트
│   └── content/
│       └── OrganiztionTreeChart.jsx  # 조직 트리 차트
├── weight/                         # 가중치 관리
│   ├── index.jsx                  # 가중치 메인
│   ├── Filter.jsx                 # 필터
│   ├── Header.tsx                 # 헤더
│   ├── History.jsx                # 변경 이력
│   ├── Table.jsx                  # 가중치 테이블
│   └── content/
│       ├── Filter.jsx             # 필터
│       ├── History.jsx            # 변경 이력
│       └── Table.jsx              # 테이블
├── Assignees.tsx                   # 담당자 표시
├── BarGraph.tsx                    # 막대 그래프
├── BarGraphWithBadge.tsx           # 배지 포함 막대 그래프
├── BarGraphWithWeight.tsx          # 가중치 포함 막대 그래프
├── CustomDoughnutChart.jsx         # 커스텀 도넛 차트
├── ItemContent.jsx                 # 아이템 콘텐츠
├── OverdueLabel.jsx                # 기한 초과 라벨
├── StageLabel.jsx                  # 단계 라벨
└── Title.tsx                       # 목표 제목 컴포넌트
```

### 컨테이너

```
src/containers/objective/
├── List.jsx                        # 목표 리스트 컨테이너
├── Form.jsx                        # 목표 생성/수정 컨테이너
├── Show.jsx                        # 목표 상세 컨테이너
├── Map.jsx                         # 목표 맵 컨테이너
├── Weight.jsx                      # 가중치 컨테이너
├── GraphModal.tsx                  # 그래프 모달
├── MultisourceFeedbackTemplate.jsx # 다면평가 템플릿
└── SuperObjectiveModal.jsx         # 상위 목표 모달
```

### 페이지

```
src/pages/objective/
├── index.js                        # 라우팅 메인
├── list/index.jsx                  # 목표 리스트 페이지
├── new/index.jsx                   # 목표 생성 페이지
├── show/index.jsx                  # 목표 상세 페이지
├── map/index.jsx                   # 목표 맵 페이지
├── search/index.jsx                # 목표 검색 페이지
└── weight/index.jsx                # 가중치 페이지
```

### 유틸리티

```
src/lib/
├── objectives.js                   # 목표 관련 유틸리티 함수
└── sortObjectives.ts               # 목표 정렬 로직
```

### Hooks

```
src/hooks/
├── AI_objective/
│   └── on_create_recommend/
│       └── useObjectiveAIRecommendation.jsx  # AI 목표 추천
└── useSubmitBulkObjectiveApprove.ts  # 일괄 승인 훅
```

---

## 주요 플로우

### 1. 목표 생성 플로우

```
User Input
    ↓
Page: pages/objective/new/index.jsx
    ↓
Container: containers/objective/Form.jsx
    ├─ 주기 로드
    ├─ 태그 로드
    ├─ 설정 로드
    ├─ State: hasAdvancedObjectiveCreateOptions = false (초기값)
    ↓
Component: components/objective/form/index.jsx
    ├─ 필수 항목 표시 (*)
    ├─ "고급 설정" 체크박스
    │   └─ onChange → handleCheckedChange()
    │       └─ setState({ hasAdvancedObjectiveCreateOptions: checked })
    │
    ├─ ObjectiveForm (항상 표시)
    │   └─ content/ObjectiveForm.jsx
    │       ├─ 목표명 입력 (필수)
    │       ├─ 주기 선택 (필수)
    │       ├─ 기간 선택
    │       ├─ 설명 입력
    │       └─ 담당자/팀 선택
    │
    ├─ KeyResults (항상 표시)
    │   └─ content/KeyResults.jsx
    │       ├─ Key Result 추가/삭제
    │       └─ 진행률 관리방식 설정
    │
    └─ 고급 설정 섹션 (hasAdvancedObjectiveCreateOptions = true 일 때만 표시)
        ├─ RelatedUserForm (관리자, 팔로워)
        ├─ ObjectiveWeightForm (목표 가중치)
        ├─ DirectApprovalForm (직접 승인 설정)
        ├─ InactiveAlertTerm (비활성 알림)
        ├─ TagSetting (태그)
        ├─ PrivacyForm (공개 범위)
        └─ ReviewerForm (검토자)
        ↓
Container: handleSubmit()
    ├─ dispatch(createObjective)
    ↓
Module: modules/objectives.js
    ├─ CREATE_OBJECTIVE 액션
    ├─ API: POST /workspaces/:id/objectives
    ├─ Reducer: 상태 업데이트
    ↓
Redirect to objectives list
```

### 2. 목표 리스트 조회 플로우

```
User Access: /workspaces/:id/objectives
    ↓
Page: pages/objective/list/index.jsx
    ↓
Container: containers/objective/List.jsx
    ├─ componentDidMount()
    ├─ dispatch(loadMineObjectives)
    ├─ dispatch(loadOrganizationObjectives)
    ├─ dispatch(loadCycles)
    ↓
Module: modules/objectives/list.js
    ├─ LOAD_MINE_OBJECTIVES
    ├─ API: GET /workspaces/:id/objectives/mine
    ├─ Reducer: currentUserObjectives 업데이트
    ↓
Container: mapStateToProps
    ├─ objectives: state.objectives.list.currentUserObjectives
    ├─ cycles: state.cycles.list
    ↓
Component: components/objective/list/index.jsx
    ├─ Header.jsx (필터)
    ├─ Tabs.jsx (4가지 탭: 요약/소속/역할/전체)
    ├─ main/ContentMain.jsx
    │   ├─ main/SummaryList.tsx (나의 목표 요약)
    │   ├─ main/BelongList.jsx (소속 기준)
    │   ├─ main/AssigneeObjective.jsx (역할 기준)
    │   └─ main/MemberObjectiveList.jsx (구성원별)
    │       └─ main/Objective.jsx (각 목표 아이템)
    ↓
UI 렌더링
```

### 3. Key Result 진행률 계산 플로우

```
User Input: 현재값 입력
    ↓
Component: components/objective/form/content/KeyResultInput.jsx
    ├─ onChange 이벤트
    ├─ 관리방식 확인 (달성률/절대값/구간/여부)
    ├─ 구간 타입 확인 (increase/decrease)
    ├─ 구간 옵션 확인 (over/greater/under/less)
    ↓
Lib: lib/constants.js → findIntervalProgress()
    ├─ 진행률 계산 로직 (구간 방식)
    │   역순으로 구간 값 검색하여 매칭:
    │   - over: value <= targetValue
    │   - greater: value < targetValue
    │   - under: value >= targetValue
    │   - less: value > targetValue
    ├─ 매칭된 구간의 progress 반환 (0-100)
    ↓
Component: 진행률 표시
    ├─ BarGraph.tsx 업데이트
    ├─ 퍼센트 텍스트 업데이트
```

### 4. 목표 가중치 승인 플로우

```
Manager: 가중치 설정
    ↓
Page: pages/objective/weight/index.jsx
    ↓
Container: containers/objective/Weight.jsx
    ├─ dispatch(loadObjectiveWeights)
    ↓
Component: components/objective/weight/index.jsx
    ├─ weight/Header.tsx (헤더, 필터)
    ├─ weight/content/Filter.jsx (필터 설정)
    └─ weight/content/Table.jsx
        ├─ 가중치 입력 (%)
        ├─ 변경 사항 저장
        ↓
Container: handleSubmit()
    ├─ dispatch(updateWeight)
    ↓
Module: modules/objectives/weight.js
    ├─ UPDATE_WEIGHT 액션
    ├─ API: PATCH /workspaces/:id/objective_weights/:weightId
    ├─ Reducer: 상태 업데이트
    ↓
Approver: 승인 처리
    ├─ dispatch(approveWeight)
    ├─ API: POST /workspaces/:id/objective_weights/:weightId/approve
    ├─ status: pending → approved
    ↓
Component: weight/content/History.jsx
    └─ 가중치 변경 이력 표시
```

---

## Redux 상태 관리

### State 구조

```javascript
state.objectives = {
  // 현재 활성 목표 (상세 보기)
  activeObjective: {
    histories: List([]),              // 체크인 이력
    temp_file_lists: List([]),        // 임시 파일 리스트
  },

  // 모달용 목표 데이터
  modalObjective: Map({}),

  // 목표 상세 정보
  show: {
    id: number,
    name: string,
    // ... 목표 전체 정보
  },

  // 목표 설정
  setting: {
    useSuperKeyResultLink: boolean,
    useWeightWithObjectivePage: boolean,
    useKeyResultWeight: boolean,
    // ... 기타 설정
  },

  // 이전 모달 데이터 (캐시)
  prevModalData: {},

  // 태그 목록
  tags: [
    {
      id: number,
      title: string,
      color: string,
      objectiveCount: number,
    },
  ],
};

// 목표 리스트 (서브 모듈)
state.objectives.list = {
  currentUserObjectives: List([]),    // 내 목표
  organizationObjectives: List([]),   // 조직 목표
  loaded: Map({
    currentUserObjectives: boolean,
    organizationObjectives: boolean,
  }),
};

// 가중치 (서브 모듈)
state.objectives.weight = {
  weights: List([]),                  // 가중치 목록
  history: List([]),                  // 변경 이력
};
```

### 주요 액션

```javascript
// 목표 CRUD
CREATE_OBJECTIVE                // 목표 생성
UPDATE_OBJECTIVE                // 목표 수정
ARCHIVE_OBJECTIVE               // 목표 보관
RESTORE_ARCHIVE_OBJECTIVE       // 보관 복원

// 목표 조회
SHOW_OBJECTIVE                  // 목표 상세 조회
SHOW_OBJECTIVE_HISTORY          // 목표 이력 조회
SHOW_OBJECTIVE_FILES            // 목표 파일 조회

// 목표 마감
CLOSE_REQUEST_CREATE            // 마감 요청 생성
CLOSE_REQUEST_UPDATE            // 마감 요청 수정
CANCEL_CLOSE                    // 마감 취소
CLOSE_RESTORE                   // 마감 복원

// Key Results
LOAD_KEY_RESULTS                // Key Results 로드
SET_PROGRESS_INTERVAL           // 진행률 구간 설정

// 체크인
CHECKIN_REQUEST                 // 체크인 요청
MAKE_RECENT_HISTORY             // 최근 이력 생성

// 가중치
LOAD_OBJECTIVE_WEIGHTS          // 가중치 로드
UPDATE_WEIGHT                   // 가중치 수정

// 댓글/피드백
CREATE_COMMENT                  // 댓글 생성
UPDATE_COMMENT                  // 댓글 수정
DELETE_COMMENT                  // 댓글 삭제
BADGE_IN_OBJECTIVE              // 배지 피드백

// 파일
UPLOAD_FILE                     // 파일 업로드
DELETE_FILE                     // 파일 삭제

// 설정/태그
LOAD_SETTING                    // 설정 로드
LOAD_TAGS                       // 태그 로드
```

---

## API 엔드포인트

> **빠른 참조**:
> - 목표 CRUD → [GET/POST/PATCH/DELETE /objectives](#목표-crud)
> - 목표 리스트 → [GET /objectives?view_type=](#목표-리스트)
> - 목표 마감 → [POST /close_requests](#목표-마감)
> - Key Results → [GET/POST/PATCH /key_results](#key-results)
> - 체크인 → [POST /checkins](#체크인)
> - 가중치 → [GET/PATCH /objective_weights](#가중치)
> - 파일 업로드 → [POST /files](#파일)
> - 댓글/피드백 → [POST/PATCH/DELETE /comments](#댓글피드백)
> - 태그/설정 → [GET /objective_tags, /objective_settings](#설정태그)
> - AI 추천 → [GET /ai_features, POST /ai/recommendations](#ai-추천)

### 목표 CRUD

```
GET    /workspaces/:workspaceId/objectives/mine
       → 내 목표 목록 조회

GET    /workspaces/:workspaceId/objectives/:objectiveId
       → 목표 상세 조회

POST   /workspaces/:workspaceId/objectives
       → 목표 생성
       Body: { name, description, cycleId, keyResults, assignees, ... }

PATCH  /workspaces/:workspaceId/objectives/:objectiveId
       → 목표 수정

DELETE /workspaces/:workspaceId/objectives/:objectiveId
       → 목표 삭제 (소프트 삭제)
```

### 목표 리스트

```
GET    /workspaces/:workspaceId/objectives?view_type=team&objective_type=user
       → 팀 목표 조회

GET    /workspaces/:workspaceId/objectives?view_type=organization
       → 조직 목표 조회

GET    /workspaces/:workspaceId/objectives/trees
       → 목표 트리 구조 조회 (맵)
```

### 목표 마감

```
POST   /workspaces/:workspaceId/objectives/:objectiveId/close_requests
       → 마감 요청 생성

PATCH  /workspaces/:workspaceId/objectives/:objectiveId/close_requests/:requestId
       → 마감 요청 승인/거부

DELETE /workspaces/:workspaceId/objectives/:objectiveId/close_requests/:requestId
       → 마감 요청 취소
```

### Key Results

```
GET    /workspaces/:workspaceId/objectives/:objectiveId/key_results
       → Key Results 목록 조회

POST   /workspaces/:workspaceId/objectives/:objectiveId/key_results
       → Key Result 생성

PATCH  /workspaces/:workspaceId/key_results/:keyResultId
       → Key Result 수정
```

### 체크인

```
POST   /workspaces/:workspaceId/objectives/:objectiveId/checkins
       → 체크인 생성
       Body: { keyResults: [{ id, currentValue }] }

GET    /workspaces/:workspaceId/objectives/:objectiveId/history
       → 체크인 이력 조회
```

### 가중치

```
GET    /workspaces/:workspaceId/objective_weights?cycle_id=:cycleId
       → 가중치 목록 조회

PATCH  /workspaces/:workspaceId/objective_weights/:weightId
       → 가중치 수정
       Body: { nextWeight }

POST   /workspaces/:workspaceId/objective_weights/:weightId/approve
       → 가중치 승인

POST   /workspaces/:workspaceId/objective_weights/:weightId/reject
       → 가중치 거부
```

### 파일

```
POST   /workspaces/:workspaceId/objectives/:objectiveId/files
       → 파일 업로드

DELETE /workspaces/:workspaceId/files/:fileId
       → 파일 삭제
```

### 댓글/피드백

```
POST   /workspaces/:workspaceId/objectives/:objectiveId/comments
       → 댓글 생성

PATCH  /workspaces/:workspaceId/comments/:commentId
       → 댓글 수정

DELETE /workspaces/:workspaceId/comments/:commentId
       → 댓글 삭제

POST   /workspaces/:workspaceId/objectives/:objectiveId/feedbacks
       → 배지 피드백 전송
```

### 설정/태그

```
GET    /workspaces/:workspaceId/objective_settings
       → 목표 설정 조회

GET    /workspaces/:workspaceId/objective_tags
       → 태그 목록 조회
```

### AI 추천

```
GET    /workspaces/:workspaceId/ai_features?type=user
       → AI 기능 사용 가능 여부 확인
       Response: { use_ai_objective_recommendation: boolean }

POST   /workspaces/:workspaceId/ai/objective_insights/recommendations
       → AI 목표 추천 요청
       Body: { prompt: string }
       Response: {
         success: boolean,
         message?: string,
         recommended_okrs?: [
           {
             priority_rank: number,           // 추천순위
             confidence: number,               // 신뢰도 (0-100)
             objective: {
               name: string,
               description: string
             },
             key_results: [
               {
                 name: string,
                 description: string,
                 management_type: string       // "달성률" | "절대값" | "구간" | "여부"
               }
             ],
             alignment: string,                // 상위 목표 연계성
             references: string[],             // 참조 근거
             differentiation: string,          // 기존 목표와의 차별점
             expected_impact: string           // 기대 효과
           }
         ]
       }
```

---

## 주요 컴포넌트

### 1. ObjectiveForm.jsx - 목표 생성/수정 폼

**위치**: `components/objective/form/content/ObjectiveForm.jsx`

**역할**:
- 목표 생성/수정 메인 폼
- 모든 서브 컴포넌트 통합

**주요 Props**:
```typescript
{
  objective: IObjectiveItem,        // 수정 시 기존 목표 데이터
  cycles: ICycle[],                 // 사이클 목록
  tags: IObjectivesTagItem[],       // 태그 목록
  setting: IObjectSetting,          // 목표 설정
  onSubmit: (data) => void,         // 제출 핸들러
}
```

---

### 2. KeyResults.jsx - Key Results 관리

**위치**: `components/objective/form/content/KeyResults.jsx`

**역할**:
- Key Result 추가/삭제
- 각 Key Result 입력 폼 관리

**주요 기능**:
- Key Result 동적 추가/삭제
- 가중치 합계 검증 (100%)
- 진행률 구간 설정

---

### 3. KeyResultInput.jsx - Key Result 개별 입력

**위치**: `components/objective/form/content/KeyResultInput.jsx`

**역할**:
- Key Result 단일 입력 폼
- 진행률 계산 및 표시

**주요 Props**:
```typescript
{
  keyResult: IObjectiveItemKeyResult,
  onChange: (updatedKR) => void,
  onDelete: () => void,
  index: number,
}
```

---

### 4. MemberObjectiveList.jsx - 구성원별 목표 리스트

**위치**: `components/objective/list/main/MemberObjectiveList.jsx`

**역할**:
- 구성원별 목표 그룹핑
- 목표 카드 렌더링
- 드래그 앤 드롭 정렬

**주요 Props**:
```typescript
{
  objectives: IObjectiveItem[],
  onSelect: (objectiveId) => void,
  cycleId: number,
}
```

---

### 5. ObjectiveCard - 목표 카드

**역할**:
- 목표 요약 정보 표시
- 진행률 바 표시
- Key Results 미리보기
- 상태 뱃지 표시

---

## 관련 문서

- [../overview.md](../overview.md#2-1-목표-objectives): 목표 기능 개요
- [../architecture.md](../architecture.md#전형적인-기능-구현-플로우): 목표 리스트 구현 예시
- [../checklist.md](../checklist.md#목표-objectives): 목표 기능 체크리스트
- [../project-structure.md](../project-structure.md): 파일 구조 상세
- [appraisals.md](appraisals.md): 평가 시스템 (목표와 연동)
