# ppfront - Architecture

## 개요

ppfront는 **Container/Presentational Pattern**을 기반으로 하는 React 애플리케이션입니다. Redux를 통한 중앙 상태 관리와 명확한 레이어 분리로 확장 가능한 구조를 갖추고 있습니다.

---

## 아키텍처 패턴

### Container/Presentational Pattern

**핵심 개념:**

- **Presentational (Components)**: UI 렌더링만 담당, props로 데이터 전달받음
- **Container**: 비즈니스 로직, Redux 상태 연결, API 호출 처리
- **Page**: 라우트별 진입점, Container를 조합

**실제 구현 상황:**

- **이론**: Presentational은 순수 UI만, Container는 로직만
- **현실**: Presentational 컴포넌트에도 비즈니스 로직이 존재할 수 있음
  - 예: 데이터 가공, 필터링, 정렬, 계산 로직 등
  - 이유: 컴포넌트 복잡도 증가, 리팩토링 필요성, 개발 속도 우선
- **주의**: 완전히 분리된 구조가 아니므로, 코드 분석 시 Component 내부 로직도 확인 필요

**장점:**

- UI와 로직 분리로 재사용성 증가
- 테스트 용이성
- 관심사의 분리 (Separation of Concerns)

---

## 디렉토리 구조 및 역할

```
src/
├── pages/              # 라우트 진입점 (Route Entry Point)
├── containers/         # 비즈니스 로직 + Redux 연결 (Smart Components)
├── components/         # 순수 UI 컴포넌트 (Presentational Components)
├── modules/            # Redux 상태 관리 (Actions, Reducers)
├── hooks/              # 재사용 가능한 React Hooks
├── lib/                # 유틸리티 함수 (순수 함수)
├── hoc/                # Higher-Order Components
├── config/             # 앱 설정 (Redux Store, API 등)
└── locales/            # 다국어 리소스 (i18next)
```

### 1. pages/

**역할:** 라우트별 진입점, URL과 매핑되는 컴포넌트

**특징:**

- React Router의 Route 컴포넌트에서 직접 렌더링
- 주로 Container를 import해서 렌더링
- 최소한의 로직만 포함 (라우트 파라미터 전달 등)

**예시:**

```javascript
// pages/objective/list/index.jsx
import IndexList from "containers/objective/List";

const ObjectivesList = (props) => {
  return <IndexList {...props} />;
};

export default withTranslation()(ObjectivesList);
```

**디렉토리 구조:**

```
pages/
├── objective/
│   ├── index.js          # 라우트 export
│   ├── list/             # 목표 리스트
│   ├── new/              # 목표 생성
│   ├── show/             # 목표 상세
│   ├── map/              # 목표 맵
│   └── weight/           # 목표 가중치
```

---

### 2. containers/

**역할:** 비즈니스 로직 처리, Redux 상태와 컴포넌트 연결

**특징:**

- **대부분 React Class Component로 작성됨** (Function Component 전환 진행 중)
- Redux의 `connect()` HOC 사용
- `mapStateToProps`: Redux state → Component props
- `mapDispatchToProps`: Redux actions → Component props
- 라이프사이클에서 데이터 로딩 (`componentDidMount`)
- 비즈니스 로직 처리 (필터링, 정렬, 계산 등)
- Component에 가공된 데이터 전달

**예시:**

```javascript
// containers/objective/List.jsx
class ObjectiveList extends Component {
  componentDidMount() {
    // 1. API 호출로 데이터 로딩
    const { workspaceId, Actions } = this.props;
    Actions.loadMineObjectives({ workspaceId });
  }

  render() {
    // 2. Component에 props 전달
    return <Index {...this.props} />;
  }
}

// Redux 연결
const mapStateToProps = (state) => ({
  objectives: state.objectives.get("currentUserObjectives"),
  isLoading: state.pender.pending["objectives/list/LOAD_MINE_OBJECTIVES"],
});

const mapDispatchToProps = (dispatch) => ({
  Actions: bindActionCreators(actions, dispatch),
});

export default connect(mapStateToProps, mapDispatchToProps)(ObjectiveList);
```

**디렉토리 구조:**

```
containers/
├── objective/
│   ├── List.jsx          # 목표 리스트 컨테이너
│   ├── Form.jsx          # 목표 생성 및 수정 컨테이너
│   ├── Show.jsx          # 목표 상세 컨테이너
│   └── Map.jsx           # 목표 맵 컨테이너
```

**컨테이너 역할별 분류:**

- **List.jsx**: 데이터 목록 조회 및 표시
- **Form.jsx**: 데이터 생성(Create) 및 수정(Update) 처리
- **Show.jsx**: 데이터 상세 조회 (Read)
- **Map.jsx**: 특수 뷰 (조직도 기반 목표 트리)

---

### 3. components/

**역할:** UI 렌더링, props 기반 동작

**특징:**

- Redux와 직접 연결 없음 (props로 데이터 전달받음)
- props로 데이터와 콜백 함수 전달받음
- 재사용 가능한 UI 컴포넌트
- Material-UI, CSS-in-JS 스타일링
- **주의**: 이론상 "순수 UI만" 담당하지만, 실제로는 비즈니스 로직도 포함될 수 있음
  - 예: 데이터 가공, 필터링, 정렬, 계산, 상태 관리 (useState, useEffect)
  - MemberObjectiveList.jsx의 `settingStateUsedInCurrentComponent` 등

**예시:**

```javascript
// components/objective/list/index.jsx
const Index = ({
  Actions, // Container에서 전달받은 Redux 액션 함수들
  user, // Redux state에서 전달받은 데이터
  workspaceId,
  objectives,
  isLoading,
  ...props
}) => {
  return (
    <MUIGrid>
      <Header {...headerProps} />
      <ContentMain objectives={objectives} isLoading={isLoading} />
    </MUIGrid>
  );
};
```

**디렉토리 구조:**

```
components/
├── objective/
│   ├── list/
│   │   ├── index.jsx                    # 메인 컴포넌트
│   │   ├── Header.jsx                   # 헤더
│   │   ├── Tabs.jsx                     # 탭
│   │   ├── main/
│   │   │   ├── ContentMain.jsx          # 메인 콘텐츠
│   │   │   └── MemberObjectiveList.jsx  # 구성원 목표 리스트
│   │   └── GroupObjectiveList.jsx       # 그룹 목표 리스트
│   ├── form/          # 목표 폼
│   └── show/          # 목표 상세
```

---

### 4. modules/

**역할:** Redux 상태 관리 (Actions, Reducers)

**특징:**

- `redux-actions`로 액션 생성
- `redux-pender`로 비동기 처리
- Immutable.js로 불변성 관리
- API 호출 로직 포함

**예시:**

```javascript
// modules/objectives/list.js
import { createAction, handleActions } from "redux-actions";
import { pender } from "redux-pender";
import { fromJS, List, Map } from "immutable";

// 액션 타입 정의
const LOAD_MINE_OBJECTIVES = "objectives/list/LOAD_MINE_OBJECTIVES";

// 액션 생성 함수
export const loadMineObjectives = createAction(
  LOAD_MINE_OBJECTIVES,
  ({ workspaceId }) =>
    axiauth.get(`${HOST_V2}/workspaces/${workspaceId}/objectives/mine`)
);

// 초기 상태
const initialState = Map({
  currentUserObjectives: List([]),
  isLoading: false,
});

// 리듀서
export default handleActions(
  {
    ...pender({
      type: LOAD_MINE_OBJECTIVES,
      onSuccess: (state, action) => {
        const { data } = action.payload.data;
        return state.set("currentUserObjectives", fromJS(data));
      },
    }),
  },
  initialState
);
```

**디렉토리 구조:**

```
modules/
├── objectives/
│   ├── index.js       # 목표 공통 액션/리듀서
│   └── list.js        # 목표 리스트 전용 액션/리듀서
├── appraisals.js      # 평가 상태 관리
├── feedbacks.js       # 피드백 상태 관리
└── index.js           # 모든 리듀서 통합 (combineReducers)
```

---

### 5. hooks/

**역할:** 재사용 가능한 React Hooks

**특징:**

- 커스텀 Hook으로 로직 분리
- React Query (TanStack Query) 활용
- 상태 관리, 부수 효과 처리

**예시:**

```javascript
// hooks/AI_objective/useObjectiveAIRecommendation.jsx
export const useObjectiveAIRecommendation = ({ workspaceId, cycleId }) => {
  return useQuery({
    queryKey: ["ai-objective-recommendation", workspaceId, cycleId],
    queryFn: () => fetchAIRecommendation(workspaceId, cycleId),
    enabled: !!workspaceId && !!cycleId,
  });
};
```

**디렉토리 구조:**

```
hooks/
├── AI_objective/              # AI 목표 추천 Hooks
├── appraisal/                 # 평가 관련 Hooks
├── useDebounce.ts             # Debounce Hook
├── useToggleState.ts          # Toggle Hook
└── useIntersectionObserver.ts # Intersection Observer Hook
```

---

### 6. lib/

**역할:** 유틸리티 함수, 순수 함수

**특징:**

- Redux, React와 독립적
- 재사용 가능한 비즈니스 로직
- 데이터 가공, 변환, 검증

**예시:**

```javascript
// lib/objectives.js
export const sortByObjectiveSortOption = (objectives, sortOption) => {
  // 목표 정렬 로직
};

// lib/authenticate.js
export const authenticate = (token) => {
  // 인증 처리 로직
};
```

**디렉토리 구조:**

```
lib/
├── objectives.js              # 목표 관련 유틸리티
├── sortObjectives.ts          # 목표 정렬
├── feedback/                  # 피드백 유틸리티
├── appraisal/                 # 평가 유틸리티
├── string/                    # 문자열 처리
├── time/                      # 날짜/시간 처리
└── authenticate.js            # 인증 처리
```

---

### 7. config/

**역할:** 앱 전역 설정

**특징:**

- Redux Store 설정
- API 엔드포인트 정의
- 환경 설정

**예시:**

```javascript
// config/store.js
import { createStore, applyMiddleware } from "redux";
import ReduxThunk from "redux-thunk";
import penderMiddleware from "redux-pender";
import reducers from "modules";

const middlewares = [ReduxThunk, penderMiddleware()];
const store = createStore(reducers, applyMiddleware(...middlewares));

export default store;
```

```javascript
// config/api.js
export const HOST_V2 = process.env.VITE_API_HOST;
export const OBJECTIVES = "/objectives";
export const APPRAISALS = "/appraisals";
```

---

## 데이터 흐름 (Data Flow)

### 1. 일반적인 읽기 흐름 (조회)

```
User Action
    ↓
Page (Route Entry)
    ↓
Container
    ├─ componentDidMount()
    ├─ dispatch(action)        ← Redux Action 호출
    ↓
Module (Redux)
    ├─ Action Creator
    ├─ API 호출 (axiauth.get)
    ├─ Reducer (onSuccess)
    └─ State 업데이트
    ↓
Container
    ├─ mapStateToProps         ← Redux State → Props
    └─ render()
    ↓
Component (Presentational)
    └─ UI 렌더링
```

**목표 리스트 조회 예시:**

```
1. User: /workspaces/:id/objectives 접근
2. Page: pages/objective/list/index.jsx
3. Container: containers/objective/List.jsx
   - componentDidMount() 실행
   - Actions.loadMineObjectives() 호출
4. Module: modules/objectives/list.js
   - loadMineObjectives 액션 실행
   - API: GET /workspaces/:id/objectives/mine
   - Reducer: currentUserObjectives 상태 업데이트
5. Container: mapStateToProps로 objectives props 전달
6. Component: components/objective/list/index.jsx
   - objectives를 받아서 UI 렌더링
```

---

### 2. 쓰기 흐름 (생성/수정)

```
User Action (Button Click)
    ↓
Component
    ├─ onClick={handleSubmit}
    └─ 콜백 함수 실행
    ↓
Container
    ├─ handleSubmit()
    ├─ dispatch(action)
    ↓
Module (Redux)
    ├─ Action Creator
    ├─ API 호출 (axiauth.post)
    ├─ Reducer (onSuccess)
    └─ State 업데이트
    ↓
Component
    └─ UI 갱신 (성공 메시지, 리다이렉트 등)
```

---

## 전형적인 기능 구현 플로우

### 예시: 목표 리스트 (Objective List)

#### 1. Page (라우트 진입점)

**파일:** [pages/objective/list/index.jsx](../../ppfront/src/pages/objective/list/index.jsx)

```javascript
import IndexList from "containers/objective/List";

const ObjectivesList = (props) => {
  return <IndexList {...props} />;
};
```

**역할:**

- 라우트 `/workspaces/:id/objectives`와 매핑
- Container 렌더링
- withTranslation() HOC로 다국어 지원

---

#### 2. Container (비즈니스 로직)

**파일:** [containers/objective/List.jsx](../../ppfront/src/containers/objective/List.jsx)

**주요 로직:**

```javascript
class ObjectiveList extends Component {
  componentDidMount() {
    const { workspaceId, Actions } = this.props;

    // 1. 사이클 데이터 로딩
    Actions.loadCycles({ workspaceId });

    // 2. 내 목표 로딩
    Actions.loadMineObjectives({ workspaceId });

    // 3. 조직 목표 로딩
    Actions.loadOrganizationObjectives({ workspaceId });
  }

  render() {
    return <Index {...this.props} />;
  }
}

// Redux 연결
const mapStateToProps = (state) => ({
  objectives: state.objectives.getIn(["list", "currentUserObjectives"]),
  cycles: state.cycles.get("list"),
  user: state.base.get("user"),
});

const mapDispatchToProps = (dispatch) => ({
  Actions: bindActionCreators(actions, dispatch),
});

export default connect(mapStateToProps, mapDispatchToProps)(ObjectiveList);
```

**역할:**

- 데이터 로딩 오케스트레이션
- Redux state → props 변환
- 비즈니스 로직 처리

---

#### 3. Component (UI 렌더링)

**파일:** [components/objective/list/index.jsx](../../ppfront/src/components/objective/list/index.jsx)

```javascript
const Index = ({ Actions, user, objectives, cycles, isLoading, ...props }) => {
  const [selectedCycle, setSelectedCycle] = useState(null);

  return (
    <MUIGrid className={classes.pageContainer}>
      <Header
        cycles={cycles}
        selectedCycle={selectedCycle}
        onCycleChange={setSelectedCycle}
      />
      <ContentMain objectives={objectives} isLoading={isLoading} />
    </MUIGrid>
  );
};
```

**하위 컴포넌트:**

- `Header.jsx`: 헤더 (사이클 선택, 탭 등)
- `ContentMain.jsx`: 메인 콘텐츠
- `MemberObjectiveList.jsx`: 구성원별 목표 리스트

**역할:**

- props 기반 UI 렌더링
- Material-UI 스타일링
- 하위 컴포넌트 조합

---

#### 4. Module (Redux 상태 관리)

**파일:** [modules/objectives/list.js](../../ppfront/src/modules/objectives/list.js)

```javascript
// 액션 타입
const LOAD_MINE_OBJECTIVES = "objectives/list/LOAD_MINE_OBJECTIVES";

// 액션 생성 함수
export const loadMineObjectives = createAction(
  LOAD_MINE_OBJECTIVES,
  ({ workspaceId }) =>
    axiauth.get(`${HOST_V2}/workspaces/${workspaceId}/objectives/mine`)
);

// 초기 상태
const initialState = Map({
  currentUserObjectives: List([]),
  loaded: Map({ currentUserObjectives: false }),
});

// 리듀서
export default handleActions(
  {
    ...pender({
      type: LOAD_MINE_OBJECTIVES,
      onSuccess: (state, action) => {
        const { data } = action.payload.data;
        return state
          .set("currentUserObjectives", fromJS(camelCase(data)))
          .setIn(["loaded", "currentUserObjectives"], true);
      },
    }),
  },
  initialState
);
```

**역할:**

- API 호출 및 응답 처리
- Immutable.js로 상태 관리
- 비동기 처리 (redux-pender)

---

#### 5. Lib (유틸리티)

**파일:** [lib/objectives.js](../../ppfront/src/lib/objectives.js)

```javascript
// 목표 정렬
export const sortByObjectiveSortOption = (objectives, sortOption) => {
  // 정렬 로직
};

// 목표 필터링
export const filterObjectivesByStatus = (objectives, status) => {
  return objectives.filter((obj) => obj.status === status);
};
```

**역할:**

- 순수 함수로 데이터 가공
- Redux, React와 독립적

---

## 상태 관리 (State Management)

### Redux 구조

```
Redux Store
├── base                 # 기본 정보 (user, workspace, client)
├── objectives           # 목표 상태
│   └── list             # 목표 리스트 상태
├── appraisals           # 평가 상태
├── feedbacks            # 피드백 상태
├── cycles               # 사이클 상태
└── pender               # 비동기 상태 (loading, error)
```

### Redux-Pender

**비동기 처리 패턴:**

```javascript
// 1. 액션 타입 정의
const LOAD_MINE_OBJECTIVES = "objectives/list/LOAD_MINE_OBJECTIVES";

// 2. 액션 생성 함수 - axiauth 호출 객체를 반환
export const loadMineObjectives = createAction(
  LOAD_MINE_OBJECTIVES,
  (payload) =>
    axiauth({
      url: `${HOST_V2}/workspaces/${payload}/objectives?view_type=team&objective_type=user`,
    })
);

// 3. Container에서 액션 디스패치
Actions.loadMineObjectives(workspaceId);
// → pender 미들웨어가 자동으로 pending 상태 관리
// → state.pender.pending['objectives/list/LOAD_MINE_OBJECTIVES'] = true

// 4. 리듀서에서 handleActions + pender로 처리
export default handleActions(
  {
    ...pender({
      type: LOAD_MINE_OBJECTIVES,
      onSuccess: (state, action) => {
        const {
          data: { data },
        } = action.payload;
        return state
          .set("currentUserObjectives", fromJS(camelCase(data)))
          .setIn(["loaded", "currentUserObjectives"], true);
      },
      onFailure: (state, action) => {
        // 실패 시 에러 처리 (선택적)
      },
    }),
  },
  initialState
);

// 5. Container에서 loading 상태 확인
const mapStateToProps = (state) => ({
  objectives: state.objectives.getIn(["list", "currentUserObjectives"]),
  isLoading: state.pender.pending["objectives/list/LOAD_MINE_OBJECTIVES"],
});
```

**핵심 포인트:**

- `createAction`의 두 번째 인자는 `axiauth()` 호출을 반환하는 함수
- `axiauth()`는 Promise를 반환하는 axios 인스턴스
- pender 미들웨어가 자동으로 `state.pender.pending[액션타입]`에 loading 상태 저장
- 리듀서에서 `...pender({ type, onSuccess })` 스프레드 연산자로 처리
- `action.payload`에 axios 응답 객체가 담김

---

## 파일 네이밍 컨벤션

### 1. 컴포넌트 파일

- **PascalCase**: `ObjectiveList.jsx`, `ContentHeader.tsx`
- **index.jsx**: 디렉토리의 메인 컴포넌트

### 2. 모듈 파일 (Redux)

- **camelCase**: `objectives.js`, `appraisals.js`
- **네임스페이스**: `objectives/list.js`, `objectives/form.js`

### 3. 유틸리티 파일

- **camelCase**: `authenticate.js`, `sortObjectives.ts`
- **디렉토리 그룹**: `lib/feedback/`, `lib/string/`

### 4. Hook 파일

- **camelCase with 'use' prefix**: `useDebounce.ts`, `useToggleState.ts`
- **디렉토리 그룹**: `hooks/appraisal/`, `hooks/AI_objective/`

---

## 라우팅 구조

### React Router 설정

**파일:** [src/App.jsx](../../ppfront/src/App.jsx)

```javascript
<BrowserRouter>
  <Switch>
    <Route
      path="/workspaces/:workspaceId/objectives"
      component={ObjectiveList}
    />
    <Route
      path="/workspaces/:workspaceId/objectives/new"
      component={ObjectiveNew}
    />
    <Route
      path="/workspaces/:workspaceId/objectives/:objectiveId"
      component={ObjectiveShow}
    />
  </Switch>
</BrowserRouter>
```

### 라우트 파라미터 접근

```javascript
// Container에서
const {
  match: {
    params: { workspaceId, objectiveId },
  },
} = this.props;

// Component에서 (props로 전달받음)
const { workspaceId, objectiveId } = props;
```

---

## API 호출 패턴

### axiauth (Axios + Auth)

**파일:** [lib/axiauth.js](../../ppfront/src/lib/axiauth.js)

```javascript
import axios from "axios";

// 인증 토큰 자동 추가
const axiauth = axios.create({
  headers: {
    Authorization: `Bearer ${getToken()}`,
  },
});

// 사용 예시
axiauth.get("/api/objectives");
axiauth.post("/api/objectives", data);
axiauth.put("/api/objectives/:id", data);
axiauth.delete("/api/objectives/:id");
```

### API 엔드포인트 관리

**파일:** [config/api.js](../../ppfront/src/config/api.js)

```javascript
export const HOST_V2 = process.env.VITE_API_HOST;
export const OBJECTIVES = "/objectives";
export const APPRAISALS = "/appraisals";

// 사용 예시
axiauth.get(`${HOST_V2}/workspaces/${workspaceId}${OBJECTIVES}`);
```

---

## 스타일링

### Material-UI (MUI)

**v4와 v5 혼재:**

- 레거시: Material-UI v4
- 신규: @mui/material v5

**CSS-in-JS:**

- **Emotion**: MUI v5의 기본 스타일 엔진
- **tss-react/mui**: MUI v5에서 `makeStyles` 대체

**예시:**

```javascript
import { makeStyles } from "tss-react/mui";

const useStyles = makeStyles()((theme) => ({
  container: {
    padding: theme.spacing(2),
    backgroundColor: theme.palette.background.paper,
  },
}));

const Component = () => {
  const { classes } = useStyles();
  return <div className={classes.container}>...</div>;
};
```

---

## 다국어 처리

### i18next

**파일:** [locales/i18n.ts](../../ppfront/src/locales/i18n.ts)

```javascript
import i18n from "i18next";
import { initReactI18next } from "react-i18next";

i18n.use(initReactI18next).init({
  resources: {
    ko: { translation: require("./ko/translation.json") },
    en: { translation: require("./en/translation.json") },
  },
  lng: "ko",
  fallbackLng: "ko",
});
```

**사용 예시:**

```javascript
import { useTranslation } from "react-i18next";

const Component = () => {
  const { t } = useTranslation();
  return <div>{t("objectives.title")}</div>;
};

// HOC 방식
export default withTranslation()(Component);
```

---

## 주요 특징

### 1. Immutable.js 사용

- Redux state를 Immutable 객체로 관리
- `Map`, `List`, `fromJS` 활용
- 불변성 보장

```javascript
// 읽기
state.objectives.get("list");
state.objectives.getIn(["list", "currentUserObjectives"]);

// 쓰기
state.set("list", newList);
state.setIn(["list", "currentUserObjectives"], newObjectives);
```

### 2. Class Component 기반

- Container는 주로 Class Component
- Component는 Function Component로 점진적 전환 중
- Hooks 도입 진행 중

### 3. Redux Thunk + Redux Pender

- 비동기 액션 처리
- loading, error 상태 자동 관리

### 4. TypeScript 마이그레이션 중

- `.jsx` → `.tsx` 점진적 전환
- 신규 컴포넌트는 TypeScript 우선

---

## 참고 문서

- [overview.md](overview.md): ppfront 프로젝트 전체 개요 및 기능 영역
- [checklist.md](checklist.md): 전체 기능 체크리스트

---

## 요약

**Claude에게 "목표 리스트 코드 참고해라"라고 하면:**

1. **Page 확인**: `pages/objective/list/index.jsx` (라우트 진입점)
2. **Container 확인**: `containers/objective/List.jsx` (비즈니스 로직)
3. **Component 확인**: `components/objective/list/index.jsx` (UI)
4. **Module 확인**: `modules/objectives/list.js` (Redux 상태)
5. **Lib 확인**: `lib/objectives.js` (유틸리티)

**데이터 흐름:**

```
User → Page → Container → Module (API) → Redux State → Container → Component → UI
```
