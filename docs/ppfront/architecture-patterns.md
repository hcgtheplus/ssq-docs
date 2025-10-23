# ppfront - 아키텍처 패턴 및 특수 기능

ppfront 프로젝트의 핵심 아키텍처 패턴과 특수 기능에 대한 상세 가이드입니다.

---

## 목차

1. [Container/Presentational 패턴](#containerpresentational-패턴)
2. [Redux Ducks 패턴](#redux-ducks-패턴)
3. [워크스페이스별 하드코딩 관리](#워크스페이스별-하드코딩-관리)
4. [평가 시스템](#평가-시스템)

---

## Container/Presentational 패턴

ppfront는 **Dan Abramov**가 제안한 Container/Presentational 패턴을 엄격히 따릅니다.

### 왜 이 패턴을 사용하는가?

> "You'll find your components much easier to reuse and reason about if you divide them into two categories."
>
> 2가지 카테고리(container, presentational 컴포넌트)로 나누어 사용한다면 재사용과 유지보수가 훨씬 쉬워집니다.

**문제점**:
- 모든 작업을 Presentational 컴포넌트에 떠넘기면 복잡도가 높아짐
- 퍼블리셔/디자이너와 개발자의 작업 영역이 명확히 분리되지 않음
- Storybook에서 독립적인 테스트가 어려움

**해결책**:
- Presentational: 퍼블리셔/디자이너가 집중
- Container: 개발자가 집중

---

### Presentational 컴포넌트

#### 특징

1. **어떻게 보여질 것인지에 대해 고려**
2. 마크업과 자체 style을 가질 수 있음
3. `this.props.children`로 다른 컴포넌트를 사용 가능
4. Redux의 action 또는 store에 의존성을 가지지 않음
5. 데이터가 어떻게 로드되고 변경되는 것에 대해 알 필요 없음
6. **Props를 통해서 data와 callback function를 전달 받음**
7. UI state를 관리해야할 때만 자신의 state를 가짐
8. 일부의 경우(lifecycle, state를 사용해야되는 경우)를 제외하고는 **함수형 컴포넌트로 작성**

#### 예시

```typescript
// components/objective/ObjectiveList.tsx
import { FC } from 'react';

import { Box, Typography } from '@mui/material';

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
    <Box>
      {objectives.map(objective => (
        <Box key={objective.id} onClick={() => onSelect(objective.id)}>
          <Typography>{objective.title}</Typography>
        </Box>
      ))}
    </Box>
  );
};

export default ObjectiveList;
```

---

### Container 컴포넌트

#### 특징

1. **어떻게 동작해야되는지에 대해 고려**
2. Wrapper용 `div`를 제외한 마크업과 자체 style을 가질 수 없음
3. Presentational 컴포넌트에 데이터와 데이터를 변경시키는 함수를 전달
4. Presentational 컴포넌트에 구독한 Redux의 state와 디스패처를 전달
5. 주로 state를 갖고있는 경우가 많음
6. `connect`, HoC로부터 props를 받아 생성되는 경우가 많음

#### 예시

```typescript
// containers/objective/ObjectiveListContainer.tsx
import { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';

import ObjectiveList from 'components/objective/ObjectiveList';

import * as objectiveActions from 'modules/objectives';

class ObjectiveListContainer extends Component {
  componentDidMount() {
    this.props.Actions.fetchObjectives();
  }

  handleSelect = (id: number) => {
    this.props.Actions.selectObjective(id);
  }

  render() {
    return (
      <ObjectiveList
        objectives={this.props.objectives}
        onSelect={this.handleSelect}
      />
    );
  }
}

const mapStateToProps = (state) => ({
  objectives: state.objectives.get('list'),
});

const mapDispatchToProps = (dispatch) => ({
  Actions: bindActionCreators(objectiveActions, dispatch),
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ObjectiveListContainer);
```

---

### 수정 전/후 비교

#### 수정 전 (안티패턴)

```javascript
// components/task_boards/Add.js
import React, { Component } from 'react';
import ModalFixedBg from 'hoc/ModalFixedBg'; // ❌ Presentational이 HoC 직접 사용

class AddTaskBoard extends Component {
  constructor(props) {
    super(props);
    this.state = {
      index: null,
      id: null, // ❌ Presentational이 데이터 state 관리
    };
  }

  selectTaskBoard(index) {
    const { task_boards } = this.props;
    this.setState({ // ❌ Presentational이 state 업데이트
      index: index,
      id: task_boards.getIn(["public_task_boards", index, "id"]),
    });
  }

  joinTaskBoard() {
    const { Actions, toggleModal } = this.props;
    Actions.joinTaskBoard(this.state.id) // ❌ Presentational이 Redux 액션 호출
      .then(() => toggleModal());
  }

  render() {
    // ... UI 렌더링
  }
}

export default ModalFixedBg(AddTaskBoard); // ❌ Presentational이 HoC 직접 사용
```

```javascript
// containers/task_boards/Add.js
const mapStateToProps = (state) => ({
  users: state.task_boards.get('users'),
  // ...
});

export default connect(mapStateToProps, mapDispatchToProps)(TaskBoardAdd); // ❌ Container가 connect만 하고 로직 없음
```

#### 수정 후 (올바른 패턴)

```javascript
// components/task_boards/Add.js
import React from 'react';
import './form.css';

const renderTaskBoards = (items, selectTaskBoard, index) => {
  if (items.size === 0) {
    return <p>모든 공개 업무 보드가 리스트에 추가되어 있습니다</p>;
  }

  return items && items.map((t, i) => (
    <p
      key={i}
      onClick={() => selectTaskBoard(i)}
      className={`${index === i ? "selected" : ""}`}
    >
      {t.get('title')}
    </p>
  ));
};

const AddTaskBoard = (props) => { // ✅ 함수형 컴포넌트
  const {
    id,
    index,
    joinTaskBoard, // ✅ Container로부터 받은 콜백
    selectTaskBoard, // ✅ Container로부터 받은 콜백
    task_boards,
    toggleModal,
  } = props;

  const items = task_boards.get('public_task_boards');

  return (
    <div className="content">
      {/* UI 렌더링만 담당 */}
      <div className="new-task-board-form add-task-board">
        <div className="new-task-board-container mb10">
          {renderTaskBoards(items, selectTaskBoard, index)}
        </div>
        <div className="tc">
          <button onClick={() => toggleModal()}>취소</button>
          {(items.size === 0) || (id === null) ? (
            <input type="submit" value="저장" className="basicBtn f13 disabled" />
          ) : (
            <input type="submit" value="저장" onClick={() => joinTaskBoard()} />
          )}
        </div>
      </div>
    </div>
  );
};

export default AddTaskBoard; // ✅ HoC 없음
```

```javascript
// containers/task_boards/Add.js
import * as actions from 'modules/task_boards';
import ModalFixedBg from 'hoc/ModalFixedBg';
import React, { Component } from 'react';
import TaskBoardAdd from 'components/task_boards/Add';
import { bindActionCreators, compose } from 'redux';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';

class AddTaskBoardContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      index: null,
      id: null, // ✅ Container가 데이터 state 관리
    };
  }

  selectTaskBoard = (index) => { // ✅ Container가 비즈니스 로직 처리
    const { task_boards } = this.props;
    this.setState({
      index: index,
      id: task_boards.getIn(["public_task_boards", index, "id"]),
    });
  }

  joinTaskBoard = () => { // ✅ Container가 Redux 액션 호출
    const { Actions, toggleModal } = this.props;
    Actions.joinTaskBoard(this.state.id).then(() => toggleModal());
  }

  render() {
    const { selectTaskBoard, joinTaskBoard } = this;
    const { toggleModal, task_boards } = this.props;
    const { index, id } = this.state;

    return (
      <TaskBoardAdd
        id={id}
        index={index}
        joinTaskBoard={joinTaskBoard} // ✅ 콜백 전달
        selectTaskBoard={selectTaskBoard} // ✅ 콜백 전달
        task_boards={task_boards}
        toggleModal={toggleModal}
      />
    );
  }
}

const mapStateToProps = (state) => ({
  task_boards: state.task_boards,
  // ...
});

const mapDispatchToProps = (dispatch) => ({
  Actions: bindActionCreators(actions, dispatch),
});

// ✅ Container가 HoC와 connect 사용
export default compose(
  connect(mapStateToProps, mapDispatchToProps),
  ModalFixedBg,
  withRouter
)(AddTaskBoardContainer);
```

---

### Pages 역할

#### src/pages/

**특징**:
1. 하위 디렉토리 및 파일은 오로지 **페이지(URL route)의 역할만** 담당
2. 통신의 역할이 아예 없을 경우에도 **Container를 생성해 import**
3. API 호출이나 Redux 연결 없음

```typescript
// pages/objective/ObjectivePage.tsx
import React from 'react';
import ObjectiveListContainer from 'containers/objective/ObjectiveListContainer';

const ObjectivePage = () => {
  return (
    <div>
      <ObjectiveListContainer />
    </div>
  );
};

export default ObjectivePage;
```

---

### 중요한 구분 기준

> "Presentational components tend to be stateless pure functions, and containers tend to be stateful pure classes. However this is not a rule but an observation."
>
> Presentational 컴포넌트는 state가 없는 순수 함수형 컴포넌트인 경향이 있고, container 컴포넌트는 state가 있는 순수 class형 컴포넌트인 경향이 있습니다. 하지만 이것이 규칙이란 얘기는 아니고 특수한 상황에선 반대의 경우도 있을 수 있습니다.

**핵심**: State의 유무나 class형 컴포넌트 여부가 구분 기준이 아님!

**진짜 구분 기준**:
- **데이터 관리 = Container**
- **마크업 = Presentational**

---

### 수정 가이드

#### Presentational 컴포넌트 수정

1. HoC, connect가 있다면 제거 → Container로 이동
2. Redux dispatch 사용 중이라면 → Container로 이동
3. Lifecycle을 사용 중이라면 → 그대로 놔둬도 됨 (class 컴포넌트 사용 가능)
4. State 사용 중이라면 → UI 조절용인지 확인, 아니면 Container로 이동

#### Container 컴포넌트 수정

1. Connect와 다수의 HoC가 같이 사용된다면 → Redux의 `compose` 사용

```typescript
// ✅ Good - compose 사용
export default compose(
  connect(mapStateToProps, mapDispatchToProps),
  ModalFixedBg,
  withRouter
)(MyContainer);

// ❌ Bad - 중첩 HOC
export default withRouter(ModalFixedBg(connect(...)(MyContainer)));
```

---

### 참고 문서

1. [Presentational and Container Components – Dan Abramov](https://medium.com/@dan_abramov/smart-and-dumb-components-7ca2f9a7c7d0)
2. [ppfront wiki - Container and Presentational Component](https://github.com/hcgtheplus/ppfront.wiki/blob/master/08.-Container-and-Presentational-Component.md)
3. [ppfront wiki - React Coding Style](https://github.com/hcgtheplus/ppfront.wiki/blob/master/05.-React-Coding-Style.md)
4. [Container Components](https://medium.com/@learnreact/container-components-c0e67432e005)
5. [Storybook Tutorial - Construct a screen](https://www.learnstorybook.com/react/en/screen/)

---

## Redux Ducks 패턴

모든 Redux 모듈은 Ducks 패턴을 따릅니다:
- 액션 타입, 액션 생성자, 리듀서를 **하나의 파일에 관리**
- Redux Pender로 비동기 작업 통합 관리
- Immutable.js 사용으로 불변성 보장

### 예시 구조

**파일**: [src/modules/objectives.js](../../ppfront/src/modules/objectives.js)

```javascript
import { createAction, handleActions } from 'redux-actions';
import { pender } from 'redux-pender';
import * as api from 'lib/api/objectives';

// 1. 액션 타입
const FETCH_OBJECTIVES = 'objectives/FETCH_OBJECTIVES';
const SELECT_OBJECTIVE = 'objectives/SELECT_OBJECTIVE';

// 2. 액션 생성자
export const fetchObjectives = createAction(FETCH_OBJECTIVES, api.fetchObjectives);
export const selectObjective = createAction(SELECT_OBJECTIVE);

// 3. 초기 상태
const initialState = {
  list: [],
  selectedId: null,
};

// 4. 리듀서
export default handleActions({
  ...pender({
    type: FETCH_OBJECTIVES,
    onPending: (state) => state.set('loading', true),
    onSuccess: (state, action) => state.set('list', action.payload.data).set('loading', false),
    onFailure: (state, action) => state.set('error', action.payload).set('loading', false),
  }),
  [SELECT_OBJECTIVE]: (state, action) => state.set('selectedId', action.payload),
}, initialState);
```

---

## 워크스페이스별 하드코딩 관리

특정 워크스페이스(고객사)에만 적용되는 기능은 `additional_features.json`으로 관리합니다.

### 탄생 배경

**문제점**:
1. 매번 `if (workspaceId === 조건)` 코드 추가 시 관리가 어려움
2. 프론트 배포 후 새로고침 전까지는 사용자에게 반영되지 않음
3. "이걸 위해 기능까지 만들어야하나...?" 딜레마
4. 백엔드 리소스 부족

**해결책**:
- S3에 하드코딩 종류 및 워크스페이스 목록을 정리한 JSON 파일 세팅
- 프론트 첫 로드 시 해당 파일을 불러와 조건에 맞는 워크스페이스에 하드코딩 적용
- 코드 배포 없이 즉시 적용 가능

---

### 파일 위치

- **S3 버킷**: `hcg-front-resource/resources/`
- **ppfront**: `https://hcg-front-resource.s3.ap-northeast-2.amazonaws.com/resources/additional_features_v2.json`
- **talenx**: `https://hcg-front-resource.s3.ap-northeast-2.amazonaws.com/resources/additional_features_v2_talenx.json`
- **로컬 관리**: `src/assets/additional_features_v2.json` (Git 버전 관리)

---

### JSON 파일 구조

```json
[
  {
    "id": 1,
    "type": "featureRequest",
    "code": [12345, 67890]
  },
  {
    "id": 2,
    "type": "defaultPageToObjective",
    "code": [11111, 22222, 33333]
  }
]
```

**속성 설명**:
- `id`: 식별자 (관리용)
- `type`: 하드코딩할 기능 타입
- `code`: 워크스페이스 ID 목록 (보안을 위해 hash ID가 아닌 숫자 ID 사용)

---

### 지원 기능 타입

| Type | 설명 | 사용 워크스페이스 |
|------|------|-------------------|
| `featureRequest` | 퍼플 기능 제안 링크 사용 | 휴먼컨설팅그룹 |
| `defaultPageToObjective` | 메인 페이지를 목표로 설정 | 현대백화점그룹 전체 |
| `removeObjectiveMainPageTab` | 목표 메인 페이지 상단 탭 제거 | 현대백화점그룹 전체 |
| `removeHistoryLogTab` | 목표/협업 상세보기 변경이력 탭 제거 | 현대백화점그룹 전체 |
| `usedObjectiveWeightFeature` | 목표 가중치 기능 사용 | 현대백화점그룹 전체 |
| `usedVideoLectureLink` | 동영상 강의 링크 사용 | 현대백화점그룹 전체 |
| `usedWebchat` | 웹챗 기능 사용 | 휴넷 |
| `defaultCommentBadgeUnChecked` | 목표 내 피드백 보내기 시 "배지도 함께 보내기" 언체크 | 현대백화점그룹 전체 |
| `doNotShowLayoutNavigation` | 상단 네비게이션 바를 보여주지 않음 | NHQV, KIA (서베이 프로젝트) |

---

### 처리 로직

**위치**: [src/modules/people_engine.js](../../ppfront/src/modules/people_engine.js)

**트리거**: `LOAD_ADDITIONAL_FEATURES` 액션

**시점**: `show workspace` 요청 성공 후 (워크스페이스 ID 필요)

```javascript
// modules/people_engine.js
...pender({
  type: LOAD_ADDITIONAL_FEATURES,
  onSuccess: (state, action) => {
    const additionalFeatures = action.payload.data;
    const workspaceId = state.get('workspaceId');

    // 워크스페이스 ID에 해당하는 기능만 필터링
    const enabledFeatures = additionalFeatures.filter(feature =>
      feature.code.includes(workspaceId)
    );

    return state.set('additionalFeatures', enabledFeatures);
  },
}),
```

---

### 업로드 방법

#### 1. 스크립트 사용 (권장)

```bash
# AWS 자격증명 설정
weep file FrontendDeveloper-Staging --profile default

# 1. 암호화
yarn presync:additional_features

# 2. S3 업로드
yarn sync:additional_features

# 3. 로컬 암호화 파일 삭제
yarn postsync:additional_features
```

**package.json 스크립트**:
```json
{
  "scripts": {
    "presync:additional_features": "node src/assets/encryptAdditionalFeatures.js",
    "sync:additional_features": "aws s3 cp src/assets/encrypted_additional_features_v2.json s3://hcg-front-resource/resources/additional_features_v2_talenx.json --acl=public-read --cache-control=no-cache,no-store,must-revalidate --region ap-northeast-2 --sse AES256",
    "postsync:additional_features": "rm -rf src/assets/encrypted_additional_features_v2.json"
  }
}
```

#### 2. S3 직접 업로드

**주의**: 암호화 필수!

1. **파일 암호화**:
```bash
node src/assets/encryptAdditionalFeatures.js
```
암호화된 파일: `encrypted_additional_features_v2.json` 생성됨

2. **S3 업로드**:
   - `hcg-front-resource` 버킷 → `resources` 디렉토리
   - 파일명: `additional_features_v2.json` (ppfront) 또는 `additional_features_v2_talenx.json` (talenx)

3. **권한 설정** (권한 탭):
   - 모든 사람(Everyone)에게 읽기 권한 부여
   - 경고 문구 체크

4. **암호화 키 지정**:
   - 암호화: `AES256`

5. **메타데이터 설정** (속성 탭):
   - 시스템 정의 메타데이터 추가
   - Key: `Cache-Control`
   - Value: `no-cache, no-store, must-revalidate`

---

### 주의사항

⚠️ **매우 중요!**

1. **환경 통합**: 모든 환경(production/staging/demo)이 같은 파일 사용
   - 로컬만 예외: `src/assets/` 파일 사용

2. **작업 공유**: 파일 변경 시 팀원에게 미리 알림

3. **배포 시점**:
   - 하드코딩 작업은 로컬에서 완료
   - JSON 파일 변경: 프로덕션 배포 전
   - JSON 파일 추가: 스테이징 배포 단계부터

4. **서비스 확인**: S3 업로드 후 **반드시 프로덕션 서비스 동작 확인**

5. **암호화 필수**: S3 직접 업로드 시 `encryptAdditionalFeatures.js` 스크립트 사용

---

### 참고 문서

- [ppfront wiki - additional_features.json](https://github.com/hcgtheplus/ppfront.wiki/blob/master/additional_features.json-파일을-이용한-하드코딩.md)

---

## 평가 시스템

ppfront의 가장 복잡한 기능 영역입니다.

### 개요

- **기획 폴더**: [평가 기획 폴더](https://drive.google.com/drive/folders/1ZyXNb16CakzLR6g8cC5SFZOaNWuLoDZY?usp=sharing)
- **API 명세**: [Swagger 문서](https://redocly.github.io/redoc/?nocors&url=http://localhost:4000/swagger_doc#operation/putApiV1WorkspacesWorkspaceIdAppraisalUsersResponse)

---

### 주요 데이터 구조

#### 1. allResponses (원천 데이터)

현재 대상자에 대해 현재 평가자가 볼 수 있는 **모든 응답 값**을 저장합니다.

**Response 속성**:
- `id`: response 테이블 PK (임시저장/저장 이후 관리)
- `appraiserId`: 평가자 ID (필수)
- `sectionId`: 영역 ID (종합 영역 제외 모두 필수)
- `elementId`: 문항 ID (문항 응답인 경우)
- `elementOptionId`: 선택지 ID (선택지 문항인 경우)
- `objectiveId`: 목표 ID (목표/핵심성과 영역)
- `badgepoolId`: 배지 ID (배지 영역)
- `keyResultId`: 핵심성과 ID (핵심성과 영역)
- `content`: 텍스트 응답값
  - 영역/종합 의견
  - 텍스트 문항 응답
  - 선택지 값
- `score`: 점수 응답값
  - 영역/종합 점수 (입력 또는 자동 계산)
  - 점수 문항 응답
  - 선택지 점수
- `rank`: 등급 응답값
- `canWriteScore`: 영역 점수 직접 입력 가능 여부 (프론트 전용)
- `boxType`: 컴포넌트 타입 (프론트 전용)

#### 2. responseSummary (파생 데이터)

대상자 탭이나 헤더에 표기되는 **최종 종합 점수, 최종 종합 등급** 값을 관리합니다.

- 대상자 네비게이션 API에서 초기값 수신
- 응답값 변경 시마다 갱신

#### 3. scoreArray (파생 데이터)

각 section, process별 **영역 점수**를 저장하는 배열입니다.

**속성**:
- `score`: 원 점수 값 (자동 합산 or 직접 입력)
- `adjustedScore`: `combinedRatio`가 적용된 점수
- `autoScore`: 자동 합산 점수

#### 4. rawData

성과 데이터 (목표, 배지, 피드백 등)

---

### 점수 계산 로직

#### 1. 양식 영역 점수

```
영역 종합 점수 = Σ {(각 문항의 점수 / 각 문항의 최대 점수) × (각 문항의 가중치 / 해당 영역 모든 문항의 가중치 총합) × 영역 최대 점수}
```

**주의**: 가중치가 없는 문항은 가중치가 100으로 설정됩니다.

#### 2. 목표/배지 영역 점수

**가중치가 없는 경우**:
```
영역 종합 점수 = Σ {(각 목표/배지의 점수 / 각 목표/배지의 최대 점수) × (1 / 모든 목표/배지의 개수) × 영역 최대 점수}
```

**가중치가 있는 목표 영역**:
```
영역 종합 점수 = Σ {(각 목표의 점수 / 각 목표의 최대 점수) × (각 목표의 가중치 / 해당 영역 모든 목표의 가중치 총합) × 영역 최대 점수}
```

#### 3. 핵심성과 영역 점수

```
영역 종합 점수 = Σ {(각 핵심성과의 점수 / 각 핵심성과의 최대 점수) × (각 핵심성과의 가중치 / 해당 영역 모든 핵심성과의 가중치 총합) × 영역 최대 점수}
```

**각 핵심성과의 가중치 계산**:

| 목표 가중치 | 핵심성과 가중치 | 핵심성과 가중치 계산식 |
|-------------|-----------------|----------------------|
| 없음 | 없음 | `(1 / 해당 목표의 핵심성과 수) × (100 / 목표 개수)` |
| 없음 | 있음 | `(핵심성과 가중치 / 해당 목표의 핵심성과 가중치의 총합) × (100 / 목표 개수)` |
| 있음 | 없음 | `(1 / 해당 목표의 핵심성과 수) × 해당 목표 가중치` |
| 있음 | 있음 | `(핵심성과 가중치 / 해당 목표의 핵심성과 가중치의 총합) × 해당 목표 가중치` |

#### 4. 종합 점수표 계산

관리자 페이지에서 입력한 **평가 점수 합산 비율**(`combinedRatio`)이 최대 점수가 됩니다 (합산 100점).

**영역과 프로세스별 종합 점수**:
```
점수 = (영역 종합 점수 / 영역 최대 점수) × combined_ratio
```

**영역별 최종 점수**:
```
해당 영역의 모든 프로세스의 종합 점수를 합산 (테이블의 행을 합산)
```

**종합 점수** (`totalScore`):
```
모든 영역별 최종 점수를 합산 (테이블의 마지막 열을 합산)
```

---

### Change Handling

모든 응답 값은 리덕스에서 `allResponses` 배열로 관리됩니다.

**프로세스**:
1. 응답 값 변경 발생
2. `reducerUpdateAllResponses` 함수 실행
3. 실행 결과에 따라 응답값/점수값이 리덕스 store에 업데이트

**데이터 관계**:
- `allResponses`: 응답 값 **원천 데이터**
- `scoreArray`, `responseSummary`: **파생 데이터**

**변경해야할 값 결정 테이블**:

| response type | 문항 점수 | 영역 점수 | 영역 점수 자동 합산 | 종합 점수 | 종합 점수 자동 합산 | response | 영역 점수 | 자동 합산 영역 점수 | 종합 점수 | 자동 합산 종합 점수 |
|---------------|-----------|-----------|---------------------|-----------|---------------------|----------|-----------|---------------------|-----------|---------------------|
| 일반 문항 | X | X | X | - | - | ✓ | | | | |
| 일반 문항 | X | O | X | - | - | ✓ | | | | |
| 일반 문항 | X | O | O | - | - | ✓ | | | | |
| 일반 문항 | O | X | X | - | - | ✓ | | | | |
| 일반 문항 | O | O | X | - | - | ✓ | | ✓ | | |
| 일반 문항 | O | O | O | X | X | ✓ | ✓ | ✓ | | |
| 일반 문항 | O | O | O | O | X | ✓ | ✓ | ✓ | | ✓ |
| 일반 문항 | O | O | O | O | O | ✓ | ✓ | ✓ | ✓ | ✓ |
| 영역 의견 | - | - | - | - | - | ✓ | | | | |
| 영역 점수 | - | O | - | X | X | ✓ | ✓ | | | |
| 영역 점수 | - | O | - | O | X | ✓ | ✓ | | | ✓ |
| 영역 점수 | - | O | - | O | O | ✓ | ✓ | | ✓ | ✓ |
| 영역 등급 | - | - | - | - | - | ✓ | | | | |
| 종합 의견 | - | - | - | - | - | ✓ | | | | |
| 종합 점수 | - | - | - | - | - | ✓ | | | ✓ | |
| 종합 등급 | - | - | - | - | - | ✓ | | | | |

---

### 공개범위 설정

**프로세스**: 본인 평가 → 다면 평가 → 상위자 평가

**결과 공개 범위 예시**:

| 공개 대상 | 본인 평가 | 다면 평가 | 상위자 평가 |
|-----------|-----------|-----------|------------|
| 본인 | 공개 | 비공개 | 공개 |
| 다면 평가자 | 비공개 | 공개 | 비공개 |
| 상위자 평가자 | 공개 | 공개 | 공개 |

**각 평가자가 볼 수 있는 내용**:
1. **평가 대상자 본인**: 본인 평가, 상위자 평가
2. **다면 평가자**: 다면평가자 본인이 작성한 다면 평가만
3. **상위자 평가자**: 본인 평가, 다면 평가(전체), 상위자 평가

---

### Response 종류별 속성

| appraiser_id | content | score | element_id | element_option_id | section_id | objective_id | badgepool_id | key_result_id | rank | rank_id | 설명 |
|--------------|---------|-------|------------|-------------------|------------|--------------|--------------|---------------|------|---------|------|
| O | O | X | X | X | O | X | X | X | X | X | 영역 코멘트 |
| O | X | X | X | X | O | X | X | X | O | O | 영역 등급 |
| O | X | O | X | X | O | X | X | X | X | X | 영역 점수 |
| O | O | O | O | O | O | X | X | O | X | X | 평가 항목 배지 + 단일 선택지 방식 + 평가 문항 점수를 부여 |
| O | O | O | O | O | O | O | X | X | X | X | 평가 항목 목표 + 단일 선택지 방식 + 평가 문항 점수를 부여 |
| O | X | O | O | X | O | O | X | X | X | X | 평가 항목 목표 + 점수 방식 |
| O | O | O | O | O | O | O | O | X | X | X | 핵심성과 + 단일 선택지 방식 + 평가 문항 점수를 부여 |
| O | O | O | O | O | O | X | X | X | X | X | 평가 항목 양식 적용 + 단일 선택지 방식 + 평가 문항 점수를 부여 |

---

### 참고 문서

- [ppfront wiki - 평가](https://github.com/hcgtheplus/ppfront.wiki/blob/master/평가.md)
- [평가 기획 폴더](https://drive.google.com/drive/folders/1ZyXNb16CakzLR6g8cC5SFZOaNWuLoDZY?usp=sharing)
- [점수 계산 엑셀 스레드](https://hcgtheplus.slack.com/archives/C01A1FYK0D7/p1606443757081900)

---

## 다음 문서

- [tech-stack.md](tech-stack.md): 기술 스택 상세
- [project-structure.md](project-structure.md): 프로젝트 구조
- [code-style.md](code-style.md): 코딩 규칙 및 컨벤션
- [core-files.md](core-files.md): 핵심 파일 가이드
- [overview.md](overview.md): ppfront 전체 개요
- [ppfront wiki](https://github.com/hcgtheplus/ppfront.wiki): 공식 위키
