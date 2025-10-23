# ppfront - Architecture

> **이 문서는**: ppfront의 아키텍처 패턴과 데이터 흐름을 설명합니다.
> **언제 보나**: "어떻게 구현하는지" 이해할 때
> **관련 문서**:
> - 파일 위치 및 디렉토리 구조: [project-structure.md](project-structure.md)
> - 상세 패턴 가이드: [architecture-patterns.md](architecture-patterns.md)
> - 전체 개요: [overview.md](overview.md)
> - 코딩 규칙: [code-style.md](code-style.md)

---

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

> **상세 가이드 및 예시**: [architecture-patterns.md#containerpresentational-패턴](architecture-patterns.md#1-containerpresentational-pattern)

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

> **디렉토리 상세**: 각 디렉토리의 파일 목록과 구조는 [project-structure.md](project-structure.md) 참조

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

**파일**: `pages/objective/list/index.jsx`

```javascript
import IndexList from "containers/objective/List";

const ObjectivesList = (props) => {
  return <IndexList {...props} />;
};

export default withTranslation()(ObjectivesList);
```

**역할:**
- 라우트 `/workspaces/:id/objectives`와 매핑
- Container 렌더링
- withTranslation() HOC로 다국어 지원

---

#### 2. Container (비즈니스 로직)

**파일**: `containers/objective/List.jsx`

**특징:**
- **대부분 React Class Component로 작성됨** (Function Component 전환 진행 중)
- Redux의 `connect()` HOC 사용
- `mapStateToProps`: Redux state → Component props
- `mapDispatchToProps`: Redux actions → Component props

**주요 로직:**

```javascript
class ObjectiveList extends Component {
  componentDidMount() {
    const { workspaceId, Actions } = this.props;
    Actions.loadMineObjectives({ workspaceId });
  }

  render() {
    return <Index {...this.props} />;
  }
}

// Redux 연결
const mapStateToProps = (state) => ({
  objectives: state.objectives.getIn(["list", "currentUserObjectives"]),
  isLoading: state.pender.pending["objectives/list/LOAD_MINE_OBJECTIVES"],
});

const mapDispatchToProps = (dispatch) => ({
  Actions: bindActionCreators(actions, dispatch),
});

export default connect(mapStateToProps, mapDispatchToProps)(ObjectiveList);
```

---

#### 3. Component (UI 렌더링)

**파일**: `components/objective/list/index.jsx`

```javascript
const Index = ({ Actions, user, objectives, isLoading, ...props }) => {
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

**역할:**
- props 기반 UI 렌더링
- Material-UI 스타일링
- 하위 컴포넌트 조합

---

#### 4. Module (Redux 상태 관리)

**파일**: `modules/objectives/list.js`

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

> **Ducks 패턴 상세**: [architecture-patterns.md#redux-ducks-패턴](architecture-patterns.md#2-redux-ducks-패턴)

---

#### 5. Lib (유틸리티)

**파일**: `lib/objectives.js`

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

> **Redux Store 설정**: `config/store.ts` - [core-files.md#redux-store](core-files.md) 참조

---

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
        const { data: { data } } = action.payload;
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

## 라우팅 구조

### React Router 설정

**파일**: `src/App.jsx`

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

**파일**: `lib/axiauth.js`

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

**파일**: `config/api.js`

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

**중앙 집중식 import (필수):**

```javascript
// ✅ Good - material 폴더를 통한 import
import { MUIButton, MUITextField } from "material/components";
import { AddIcon, CheckIcon } from "material/icons";

// ❌ Bad - 직접 import 금지
import { Button } from "@mui/material";
```

> **Material-UI import 규칙**: [code-style.md#material-ui](code-style.md#2-material-ui) 참조

**CSS-in-JS:**

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

**파일**: `locales/i18n.ts`

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

> **다국어 파일 구조**: [project-structure.md#srclocales](project-structure.md#7-srclocales---다국어-지원) 참조

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

> **파일 명명 규칙 상세**: [project-structure.md#파일-명명-규칙](project-structure.md#파일-명명-규칙) 참조

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

---

## 관련 문서

### 필수 참조
- [project-structure.md](project-structure.md): 디렉토리 구조 및 파일 위치
- [architecture-patterns.md](architecture-patterns.md): Container/Presentational, Redux Ducks, 평가 시스템 상세
- [code-style.md](code-style.md): 코딩 규칙, Import 순서, ESLint 설정

### 기타 참조
- [overview.md](overview.md): ppfront 전체 개요
- [tech-stack.md](tech-stack.md): 기술 스택 상세
- [core-files.md](core-files.md): 핵심 파일 상세
- [checklist.md](checklist.md): 기능별 체크리스트
