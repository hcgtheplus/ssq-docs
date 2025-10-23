# ppfront - 코딩 규칙 및 컨벤션

ppfront 프로젝트의 코딩 스타일, 네이밍 규칙, ESLint/Prettier 설정에 대한 가이드입니다.

---

## 목차

1. [TypeScript 설정](#typescript-설정)
2. [ESLint 규칙](#eslint-규칙)
3. [Prettier 설정](#prettier-설정)
4. [Import 순서](#import-순서)
5. [네이밍 규칙](#네이밍-규칙)
6. [컴포넌트 작성 가이드](#컴포넌트-작성-가이드)
7. [Redux 모듈 작성 가이드](#redux-모듈-작성-가이드)
8. [주의사항](#주의사항)

---

## TypeScript 설정

### Strict Mode 활성화

```json
{
  "strict": true,
  "noUnusedLocals": true,
  "noUnusedParameters": true,
  "noFallthroughCasesInSwitch": true
}
```

**의미**:

- 모든 strict 타입 체크 활성화
- 사용되지 않는 변수/매개변수 에러 처리
- switch 문에서 fallthrough 방지

### 경로 별칭 사용 필수

**좋은 예시**:

```typescriptㄴ
import { ObjectiveList } from 'components/objective/ObjectiveList';
import { getDirectManager } from 'lib/getDirectManager';
import { fetchObjectives } from 'modules/objectives';
```

**나쁜 예시**:

```typescript
// 상대 경로 사용 금지
import { ObjectiveList } from "../../../components/objective/ObjectiveList"; // ❌
import { getDirectManager } from "../../lib/getDirectManager"; // ❌
```

**이유**: ESLint 규칙에서 상대 경로 import 금지 (`no-restricted-imports`)

---

## ESLint 규칙

### 주요 규칙

#### 1. 세미콜론 필수

```typescript
// ✅ Good
const name = "John";
const age = 30;

// ❌ Bad
const name = "John";
const age = 30;
```

#### 2. 사용되지 않는 변수 에러

```typescript
// ❌ Bad - @typescript-eslint/no-unused-vars: error
const unusedVariable = 10;
function doSomething(unusedParam: string) {
  console.log("hello");
}

// ✅ Good
const usedVariable = 10;
console.log(usedVariable);

function doSomething(_unusedParam: string) {
  // 언더스코어 접두사로 명시
  console.log("hello");
}
```

#### 3. React 관련 규칙

```typescript
// ✅ Good - React import 불필요 (React 17+)
import { useState } from "react";

function MyComponent() {
  return <div>Hello</div>;
}

// ✅ Good - PropTypes 체크 비활성화
// TypeScript 사용으로 PropTypes 불필요
const MyComponent = ({ name }: { name: string }) => {
  return <div>{name}</div>;
};

// ⚠️ Warning - display name 체크 비활성화
export default MyComponent; // display name 없어도 OK
```

#### 4. React Hooks 규칙

```typescript
// ⚠️ exhaustive-deps 비활성화됨 (주의 필요)
useEffect(() => {
  doSomething(value);
  // value를 deps에 넣지 않아도 경고 없음
  // 하지만 가능한 한 올바른 deps 작성 권장
}, []);
```

**주의**: `exhaustive-deps`가 꺼져 있지만, 가능한 한 의존성 배열을 정확히 작성해야 합니다.

#### 5. console.log 허용

```typescript
// ✅ Good - 개발 중 console.log 사용 가능
console.log("Debug info:", data);
console.warn("Warning:", warning);
console.error("Error:", error);
```

**주의**: 프로덕션 배포 전 불필요한 console은 제거 권장

#### 6. alert 허용

```typescript
// ✅ Good - alert 사용 가능
alert("작업이 완료되었습니다.");

// 하지만 권장: SweetAlert2 또는 Notistack 사용
Swal.fire("성공", "작업이 완료되었습니다.", "success");
```

---

## Prettier 설정

```json
{
  "semi": true, // 세미콜론 필수
  "tabWidth": 2, // 들여쓰기 2칸
  "trailingComma": "es5", // ES5 트레일링 콤마
  "printWidth": 80, // 최대 줄 길이 80자
  "arrowParens": "avoid" // 화살표 함수 괄호 생략
}
```

### 적용 예시

```typescript
// ✅ Good - Prettier 적용
const fetchData = async () => {
  const response = await axios.get("/api/data");
  return response.data;
};

const config = {
  name: "John",
  age: 30,
  address: "Seoul", // 트레일링 콤마
};

// ❌ Bad - printWidth 초과 (80자)
const veryLongFunctionName = (
  param1,
  param2,
  param3,
  param4,
  param5,
  param6
) => {
  /* ... */
};

// ✅ Good - 줄 바꿈
const veryLongFunctionName = (
  param1,
  param2,
  param3,
  param4,
  param5,
  param6
) => {
  /* ... */
};
```

---

## Import 순서

ESLint의 `import/order` 규칙에 따른 import 순서:

### 1. Builtin/External 라이브러리 (React, Redux 우선)

```typescript
import { useEffect, useState } from "react";
import { connect } from "react-redux";
import { bindActionCreators } from "redux";

import axios from "axios";
import clsx from "clsx";
import moment from "moment";
```

### 2. Material-UI

**중요**: ppfront에서는 Material-UI를 직접 import하지 않고, `material/` 폴더를 통해 중앙 집중식으로 import합니다.

```typescript
// ✅ Good - material 폴더를 통한 import
import { MUIBox, MUIButton, MUITextField } from "material/components";
import { AddIcon, CheckIcon, MenuIcon } from "material/icons";
import { makeStyles, useTheme } from "material/styles";

// ❌ Bad - 직접 import 금지
import { Box, Button } from "@mui/material"; // ❌
import AddIcon from "@mui/icons-material/Add"; // ❌
```

**네이밍 규칙**:
- **컴포넌트**: `MUI` 접두사 (예: `MUIButton`, `MUITextField`, `MUIBox`)
- **아이콘**: `Icon` 접미사 (예: `AddIcon`, `CheckIcon`, `DeleteIcon`)
- **스타일**: 그대로 사용 (예: `makeStyles`, `useTheme`, `styled`)

**이유**:
- Material-UI v4에서 v5로 마이그레이션 중
- 중앙 집중식 import로 버전 관리 및 일관성 유지
- 네이밍 충돌 방지

### 3. Internal 모듈 (containers, components)

```typescript
import ObjectiveListContainer from "containers/objective/ObjectiveListContainer";

import { StyledCard } from "components/styled/StyledCard";
import { LoadingSpinner } from "components/shared/LoadingSpinner";
import ObjectiveCard from "components/objective/ObjectiveCard";
```

### 4. Unknown (modules, config, hoc, hooks, lib, images, assets)

```typescript
import * as objectiveActions from "modules/objectives";

import store from "config/store";

import withAuth from "hoc/withAuth";

import { useDebounce } from "hooks/useDebounce";

import { getDirectManager } from "lib/getDirectManager";

import logoImage from "images/logo.png";

import configData from "assets/config.json";
```

### 전체 예시

```typescript
// 1. React, Redux
import { useEffect, useState } from "react";
import { connect } from "react-redux";

// 2. External libraries
import axios from "axios";
import clsx from "clsx";

// 3. Material-UI (material 폴더를 통한 import)
import { MUIBox, MUIButton, MUITextField } from "material/components";
import { AddIcon, CheckIcon } from "material/icons";
import { makeStyles } from "material/styles";

// 4. Containers
import ObjectiveListContainer from "containers/objective/ObjectiveListContainer";

// 5. Components
import { StyledCard } from "components/styled/StyledCard";
import ObjectiveCard from "components/objective/ObjectiveCard";

// 6. Modules
import * as objectiveActions from "modules/objectives";

// 7. Hooks
import { useDebounce } from "hooks/useDebounce";

// 8. Lib
import { getDirectManager } from "lib/getDirectManager";
```

**자동 정렬**: ESLint가 자동으로 알파벳순으로 정렬합니다.

---

## 네이밍 규칙

### 1. 컴포넌트

**React 컴포넌트**: PascalCase

```typescript
// ✅ Good
const ObjectiveList = () => {
  /* ... */
};
const AppraisalCard = () => {
  /* ... */
};

// ❌ Bad
const objectiveList = () => {
  /* ... */
};
const appraisal_card = () => {
  /* ... */
};
```

**Container 컴포넌트**: PascalCase + "Container" 접미사

```typescript
// ✅ Good
const ObjectiveListContainer = () => {
  /* ... */
};

// ❌ Bad
const ObjectiveList = () => {
  /* ... */
}; // Presentational과 구분 안됨
```

### 2. 파일명

**컴포넌트 파일**: 컴포넌트명과 동일 (PascalCase)

```
✅ ObjectiveList.tsx
✅ AppraisalCard.jsx
❌ objectiveList.tsx
❌ objective-list.tsx
```

**모듈 파일**: camelCase 또는 snake_case

```
✅ objectives.js
✅ multi_sources.js
✅ task_boards.js
❌ Objectives.js
```

**유틸리티 파일**: camelCase

```
✅ getDirectManager.ts
✅ handleLogout.ts
❌ get_direct_manager.ts
```

### 3. 변수 및 함수

**변수**: camelCase

```typescript
// ✅ Good
const userName = "John";
const isLoggedIn = true;
const objectiveList = [];

// ❌ Bad
const user_name = "John";
const IsLoggedIn = true;
```

**함수**: camelCase

```typescript
// ✅ Good
const fetchObjectives = () => {
  /* ... */
};
const handleSubmit = () => {
  /* ... */
};

// ❌ Bad
const FetchObjectives = () => {
  /* ... */
};
const handle_submit = () => {
  /* ... */
};
```

**Boolean 변수**: is, has, should 접두사

```typescript
// ✅ Good
const isLoading = true;
const hasError = false;
const shouldShowModal = true;

// ❌ Bad
const loading = true;
const error = false;
const showModal = true;
```

### 4. 상수

**전역 상수**: UPPER_SNAKE_CASE

```typescript
// ✅ Good - lib/constants.js
export const API_BASE_URL = "https://api.example.com";
export const MAX_RETRY_COUNT = 3;

// ❌ Bad
export const apiBaseUrl = "https://api.example.com";
```

**enum/타입**: PascalCase

```typescript
// ✅ Good
enum AppraisalStatus {
  Draft = "draft",
  InProgress = "in_progress",
  Completed = "completed",
}

type ObjectiveType = "individual" | "team" | "company";
```

### 5. 이벤트 핸들러

**이벤트 핸들러**: handle + EventName

```typescript
// ✅ Good
const handleClick = () => {
  /* ... */
};
const handleSubmit = () => {
  /* ... */
};
const handleChange = (e) => {
  /* ... */
};

// ❌ Bad
const onClick = () => {
  /* ... */
};
const submitForm = () => {
  /* ... */
};
```

**Callback Props**: on + EventName

```typescript
// ✅ Good
<Button onClick={handleClick} />
<Form onSubmit={handleSubmit} />

// ❌ Bad
<Button click={handleClick} />
<Form submit={handleSubmit} />
```

---

## 컴포넌트 작성 가이드

### Container/Presentational 패턴

#### Presentational 컴포넌트

```typescript
// components/objective/ObjectiveList.tsx
import { FC } from "react";

import { MUIBox, MUITypography } from "material/components";

interface Objective {
  id: number;
  title: string;
  description: string;
}

interface ObjectiveListProps {
  objectives: Objective[];
  onSelect: (id: number) => void;
}

// ✅ Good - Props만 받고 UI 렌더링
const ObjectiveList: FC<ObjectiveListProps> = ({ objectives, onSelect }) => {
  return (
    <MUIBox>
      {objectives.map((objective) => (
        <MUIBox key={objective.id} onClick={() => onSelect(objective.id)}>
          <MUITypography>{objective.title}</MUITypography>
        </MUIBox>
      ))}
    </MUIBox>
  );
};

export default ObjectiveList;
```

#### Container 컴포넌트

```typescript
// containers/objective/ObjectiveListContainer.tsx
import { useEffect } from "react";
import { connect } from "react-redux";
import { bindActionCreators } from "redux";

import ObjectiveList from "components/objective/ObjectiveList";

import * as objectiveActions from "modules/objectives";

// ✅ Good - Redux 연결, 로직 처리
const ObjectiveListContainer = ({ objectives, actions }) => {
  useEffect(() => {
    actions.fetchObjectives();
  }, []);

  const handleSelect = (id: number) => {
    actions.selectObjective(id);
  };

  return <ObjectiveList objectives={objectives} onSelect={handleSelect} />;
};

const mapStateToProps = (state) => ({
  objectives: state.objectives.list,
});

const mapDispatchToProps = (dispatch) => ({
  actions: bindActionCreators(objectiveActions, dispatch),
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ObjectiveListContainer);
```

### Custom Hook 작성

```typescript
// hooks/useDebounce.ts
import { useEffect, useState } from "react";

// ✅ Good - use 접두사, TypeScript 타입 지정
export const useDebounce = <T>(value: T, delay: number): T => {
  const [debouncedValue, setDebouncedValue] = useState<T>(value);

  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value);
    }, delay);

    return () => {
      clearTimeout(handler);
    };
  }, [value, delay]);

  return debouncedValue;
};
```

---

## Redux 모듈 작성 가이드

### Ducks 패턴

하나의 파일에 액션, 리듀서를 함께 관리:

```javascript
// modules/objectives.js
import { createAction, handleActions } from "redux-actions";
import { pender } from "redux-pender";

import * as api from "lib/api/objectives";

// 액션 타입
const FETCH_OBJECTIVES = "objectives/FETCH_OBJECTIVES";
const SELECT_OBJECTIVE = "objectives/SELECT_OBJECTIVE";

// 액션 생성자
export const fetchObjectives = createAction(
  FETCH_OBJECTIVES,
  api.fetchObjectives
);
export const selectObjective = createAction(SELECT_OBJECTIVE);

// 초기 상태
const initialState = {
  list: [],
  selectedId: null,
};

// 리듀서
export default handleActions(
  {
    ...pender({
      type: FETCH_OBJECTIVES,
      onSuccess: (state, action) => ({
        ...state,
        list: action.payload.data,
      }),
    }),
    [SELECT_OBJECTIVE]: (state, action) => ({
      ...state,
      selectedId: action.payload,
    }),
  },
  initialState
);
```

### Redux Pender 사용

비동기 작업은 Redux Pender로 관리:

```javascript
// ✅ Good - Redux Pender 사용
...pender({
  type: FETCH_OBJECTIVES,
  onPending: (state) => ({
    ...state,
    loading: true,
  }),
  onSuccess: (state, action) => ({
    ...state,
    loading: false,
    list: action.payload.data,
  }),
  onFailure: (state, action) => ({
    ...state,
    loading: false,
    error: action.payload,
  }),
}),
```

---

## 주의사항

### 1. 상대 경로 import 금지

```typescript
// ❌ Bad - ESLint 에러 발생
import { ObjectiveList } from "../../../components/objective/ObjectiveList";

// ✅ Good - 경로 별칭 사용
import { ObjectiveList } from "components/objective/ObjectiveList";
```

### 2. PropTypes 사용 불필요

TypeScript 사용으로 PropTypes 불필요:

```typescript
// ❌ Bad - 불필요
import PropTypes from "prop-types";

MyComponent.propTypes = {
  name: PropTypes.string.isRequired,
};

// ✅ Good - TypeScript 타입 사용
interface MyComponentProps {
  name: string;
}

const MyComponent: FC<MyComponentProps> = ({ name }) => {
  /* ... */
};
```

### 3. React import 불필요 (React 17+)

```typescript
// ❌ Bad - React 17+에서 불필요
import React from "react";

function MyComponent() {
  return <div>Hello</div>;
}

// ✅ Good
function MyComponent() {
  return <div>Hello</div>;
}
```

### 4. Hooks 의존성 배열 주의

`exhaustive-deps` 규칙이 꺼져 있지만, 올바른 의존성 작성 권장:

```typescript
// ⚠️ Warning - deps 누락 (ESLint 경고 없지만 버그 가능성)
useEffect(() => {
  fetchData(userId);
}, []); // userId 변경 시 재실행 안됨

// ✅ Good - 의존성 명시
useEffect(() => {
  fetchData(userId);
}, [userId]);
```

### 5. Material-UI import 규칙

```typescript
// ❌ Bad - 직접 import 금지
import { Button } from "@material-ui/core"; // v4 직접 import
import { TextField } from "@mui/material"; // v5 직접 import

// ✅ Good - material 폴더를 통한 import 필수
import { MUIButton, MUITextField } from "material/components";
import { AddIcon, DeleteIcon } from "material/icons";
```

**이유**:
- Material-UI v4 → v5 마이그레이션 중
- `material/` 폴더가 버전 변환을 중앙에서 관리
- 직접 import 시 버전 충돌 발생 가능

---

## Lint 및 Format 스크립트

### 수동 실행

```bash
# ESLint 검사
yarn eslint "src/**/*.{js,jsx,ts,tsx}"

# Prettier 포맷팅
yarn format
```

### Git Hooks (Husky)

**Pre-commit**: lint-staged

- 커밋 전 변경된 파일만 ESLint 자동 검사 및 수정

**Pre-push**: remote branch checker

- 푸시 전 브랜치 검증

---

## 다음 문서

- [tech-stack.md](tech-stack.md): 기술 스택 상세
- [project-structure.md](project-structure.md): 프로젝트 구조
- [overview.md](overview.md): ppfront 전체 개요
