# ppfront - 핵심 파일 가이드

ppfront 프로젝트의 핵심 파일들과 그 역할, 중요한 유틸리티 함수들에 대한 가이드입니다.

---

## 목차

1. [진입점 (Entry Points)](#진입점-entry-points)
2. [앱 초기화](#앱-초기화)
3. [Redux Store 설정](#redux-store-설정)
4. [API 설정](#api-설정)
5. [라우팅](#라우팅)
6. [인증 및 권한](#인증-및-권한)
7. [핵심 유틸리티](#핵심-유틸리티)
8. [다국어 설정](#다국어-설정)

---

## 진입점 (Entry Points)

### src/index.ts

**역할**: 애플리케이션의 최초 진입점. 라이브러리 초기화 및 렌더링 시작.

**주요 작업**:

1. AG Grid 라이센스 설정
2. IBSheet 라이센스 설정
3. Froala 에디터 플러그인 및 언어팩 로드
4. Material Design Lite CSS/JS 로드
5. Service Worker 등록 (PWA)
6. 인증 체크 및 조건부 렌더링

**핵심 코드**:

```typescript
// AG Grid 라이센스
LicenseManager.setLicenseKey(process.env.VITE_AG_GRID_LICENSE_KEY);

// 모듈 등록
ModuleRegistry.registerModules([
  AllEnterpriseModule,
  IntegratedChartsModule.with(AgChartsEnterpriseModule),
]);

// 인증 체크
const isExceptionList = whiteListsWithoutAuthentication.some((list) =>
  window.location.pathname.includes(list)
);

// 조건부 렌더링
if (!getCookie("signedIn") && !isExceptionList) {
  handleLogout({ cause: LOGOUT_CAUSES.ERROR.SIGNED_IN_MISSING });
} else {
  renderApp(isExceptionList).then((appComponent) => {
    ReactDOM.render(appComponent, document.getElementById("root"));
  });
}
```

**화이트리스트**:

- `feedbacks/teams`: Teams 피드백 (인증 불필요)
- `/auth`: 인증 페이지

---

### src/App.jsx

**역할**: React 애플리케이션의 루트 컴포넌트. Provider 설정 및 글로벌 테마 적용.

**주요 Provider**:

1. **Redux Provider**: Redux store 연결
2. **I18nextProvider**: 다국어 지원
3. **QueryClientProvider**: TanStack React Query
4. **SnackbarProvider**: Notistack 알림
5. **ThemeProvider**: MUI 글로벌 테마
6. **StyledEngineProvider**: MUI Emotion 엔진
7. **Sentry ErrorBoundary**: 에러 추적

**글로벌 테마 설정**:

```javascript
const globalTheme = createTheme({
  typography: {
    fontFamily: "Pretendard", // 전역 폰트
  },
  palette: {
    secondary: { main: "#f50057" },
  },
  components: {
    MuiUseMediaQuery: {
      defaultProps: { noSsr: true }, // SSR 비활성화
    },
    MuiButtonBase: {
      defaultProps: { disableRipple: true }, // Ripple 효과 비활성화
    },
    MuiButton: {
      styleOverrides: {
        root: { textTransform: "none" }, // 대문자 변환 비활성화
      },
    },
  },
});
```

**React Query 설정**:

```javascript
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      refetchOnWindowFocus: false, // 포커스 시 자동 refetch 비활성화
      retry: 1, // 실패 시 1회 재시도
    },
  },
});
```

**IBSheet 라이센스 적용**:

```javascript
useEffect(() => {
  loader.config({
    registry: [
      {
        name: "ibsheet",
        baseUrl: "/ibsheet",
        license: process.env.VITE_IBSHEET_LICENSE_KEY,
        locales: ["ko", "en"],
      },
    ],
  });
}, []);
```

**MUI X 라이센스 적용**:

```javascript
useEffect(() => {
  LicenseInfo.setLicenseKey(process.env.VITE_MUI_X_LICENSE_KEY);
}, []);
```

---

## Redux Store 설정

### src/config/store.js

**역할**: Redux store 초기화 및 미들웨어 설정.

**미들웨어**:

1. **Redux Thunk**: 비동기 액션 지원
2. **Redux Pender**: 비동기 작업 관리 (pending/success/failure)

**Redux DevTools 설정**:

- local 및 staging 환경에서만 활성화
- Immutable.js 직렬화 지원

**전체 코드**:

```javascript
import { applyMiddleware, compose, createStore } from "redux";
import penderMiddleware from "redux-pender";
import ReduxThunk from "redux-thunk";
import Immutable from "immutable";
import reducers from "modules";

const middlewares = [ReduxThunk, penderMiddleware()];

const composeEnhancer =
  typeof window === "object" &&
  window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ &&
  (process.env.VITE_BUILD_ENV === "local" ||
    process.env.VITE_BUILD_ENV === "staging")
    ? window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__({
        serialize: { immutable: Immutable },
      })
    : compose;

const store = createStore(
  reducers,
  composeEnhancer(applyMiddleware(...middlewares))
);

export default store;
```

---

## API 설정

### src/config/api.js

**역할**: API 엔드포인트 상수 정의. 모든 API 경로를 중앙 관리.

**주요 HOST 정의**:

```javascript
export const HOST = `${process.env.VITE_API_URL}/api/v1`;
export const HOST_V2 = `${process.env.VITE_API_URL}/api/v2`;
export const HOST_PEOPLE = `${process.env.VITE_PEOPLE_SERVER}/api/v1`;
export const HOST_NOTIFICATION = `${process.env.VITE_NOTIFICATION_API}/api/v1`;
export const OPTIMIZ_TIME_API = process.env.VITE_OPTIMIZ_TIME_API_URL;
export const OPTIMIZ_HRM_API = process.env.VITE_OPTIMIZ_HRM_API_URL;
export const OPTIMIZ_SYSTEM_API = process.env.VITE_OPTIMIZ_SYSTEM_API_URL;
export const OPTIMIZ_PAY_API = process.env.VITE_OPTIMIZ_PAY_API_URL;
export const DOWNLOAD_HOST_V1 = `${process.env.VITE_DOWNLOAD_API_URL}/api/v1`;
export const DOWNLOAD_HOST_V2 = `${process.env.VITE_DOWNLOAD_API_URL}/api/v2`;
```

**엔드포인트 구조**:

```javascript
export const OBJECTIVES = {
  INDEX: `${WORKSPACES.SHOW}/objectives`,
  CREATE: `${WORKSPACES.SHOW}/objectives`,
  SHOW: `${WORKSPACES.SHOW}/objectives/:objectiveId`,
  UPDATE: "/objectives/:objective_id",
  // ... 수십 개의 목표 관련 엔드포인트
};

export const APPRAISALS = {
  INDEX: "/workspaces/:workspaceId/appraisal_users",
  SHOW: "/workspaces/:workspaceId/appraisal_users/response",
  UPDATE: "/workspaces/:workspaceId/appraisal_users/response",
  // ... 수십 개의 평가 관련 엔드포인트
};
```

**주요 엔드포인트 그룹**:

- **AUTH**: 인증 관련
- **WORKSPACES**: 워크스페이스
- **OBJECTIVES**: 목표 관리
- **APPRAISALS**: 평가 관리
- **FEEDBACKS**: 피드백
- **MULTI_SOURCES**: 360 피드백
- **ONE_ON_ONES**: 1:1 미팅
- **REVIEWS**: 리뷰
- **TASKBOARDS**, **TASKLISTS**, **TASKS**: 업무 관리
- **SCRUM**, **SCRUM_BOARDS**: 스크럼보드
- **ATTENDANCE**: 근태 관리
- **HRM**, **HR_CORE**: 인사 관리
- **WORKFLOW**: 워크플로우
- **PAY**: 급여
- **ACCOUNT**, **ACCOUNTS**: 계정 관리

**사용 예시**:

```javascript
import { OBJECTIVES } from "config/api";

const url = OBJECTIVES.SHOW.replace(":workspaceId", workspaceId).replace(
  ":objectiveId",
  objectiveId
);
```

---

## 라우팅

### src/containers/Route.jsx

**역할**: React Router 설정 및 WebSocket 연결 (ActionCable).

**ActionCable 설정**:

```javascript
const consumer = createConsumer(process.env.VITE_NOTIFICATION_WS);

const actioncable = {
  subscribe: ({ channel, callback }) => {
    return consumer.subscriptions.create(
      { channel },
      {
        connected: () => console.log("Connected notification"),
        disconnected: () => console.log("Disconnected notification"),
        received: (data) => {
          toastNotification(data);
          updateUnreadCount();
        },
      }
    );
  },
  // ...
};
```

**주요 기능**:

1. 알림 실시간 구독 (WebSocket)
2. 읽지 않은 알림 카운트 업데이트
3. 히스토리 변경 실시간 추적

---

## 인증 및 권한

### src/lib/axiauth.js

**역할**: Axios 인터셉터 및 인증 로직. 모든 API 요청의 핵심.

**주요 기능**:

#### 1. Access Token 자동 갱신

```javascript
const refreshToken = async () => {
  if (isRefreshing) {
    return new Promise((resolve) => {
      refreshSubscribers.push(resolve);
    });
  }

  isRefreshing = true;

  try {
    await axios.get(
      OPTIMIZ_SYSTEM_API + AUTH.REFRESH_TOKEN + `?clientId=${clientId}`,
      { withCredentials: true }
    );

    refreshSubscribers.forEach((callback) => callback());
    refreshSubscribers = [];
  } catch (refreshError) {
    handleLogout({ cause: LOGOUT_CAUSES.ERROR.REFRESH_TOKEN_ERROR });
    throw refreshError;
  } finally {
    isRefreshing = false;
  }
};
```

**특징**:

- 401 에러 시 자동 토큰 갱신
- 동시 다발적 요청 시 한 번만 갱신 (refreshSubscribers 큐 사용)
- 갱신 실패 시 자동 로그아웃

#### 2. 클라이언트 500 에러 재시도

```javascript
if (
  error.response?.status === 500 &&
  originalRequest.url === `${OPTIMIZ_SYSTEM_API}${SYSTEM.CLIENTS.INDEX}`
) {
  const retryCount = originalRequest._retryCount || 0;

  if (retryCount < MAX_CLIENTS_RETRY_COUNT) {
    originalRequest._retryCount = retryCount + 1;

    // 1초 후 재시도
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        instance(originalRequest).then(resolve).catch(reject);
      }, 1000);
    });
  }
}
```

#### 3. 모듈 활성화 체크

```javascript
const checkModuleAccess = (url) => {
  for (const [module, host] of Object.entries(MODULE_HOST_MAP)) {
    if (url.includes(host) && !userModuleUsageList.includes(module)) {
      if (process.env.VITE_BUILD_ENV !== "production") {
        console.warn(`Module ${module} is not active`);
      }
      return false; // 요청 중단
    }
  }
  return true;
};
```

**MODULE_HOST_MAP**:

```javascript
const MODULE_HOST_MAP = {
  HR: OPTIMIZ_HRM_API,
  TIME: OPTIMIZ_TIME_API,
};
```

---

### src/lib/authenticate.js

**역할**: 사용자 인증 상태 체크 및 초기 데이터 로드.

**주요 작업**:

- 쿠키에서 인증 정보 확인
- 사용자 정보 로드
- 워크스페이스 정보 로드
- 권한 체크

---

### src/lib/handleLogout.ts

**역할**: 로그아웃 처리 및 세션 정리.

**로그아웃 원인 정의**:

```typescript
export const LOGOUT_CAUSES = {
  ERROR: {
    SIGNED_IN_MISSING: "SIGNED_IN_MISSING",
    REFRESH_TOKEN_ERROR: "REFRESH_TOKEN_ERROR",
  },
  USER_ACTION: {
    MANUAL_LOGOUT: "MANUAL_LOGOUT",
  },
};
```

**처리 과정**:

1. 쿠키 삭제
2. Redux store 초기화
3. 로그인 페이지로 리다이렉트
4. 로그아웃 원인 로깅 (Sentry 등)

---

### src/lib/handleInitialPasswordChange.ts

**역할**: 초기 비밀번호 변경 강제 처리.

**조건**:

- `expiredPasswordChangeForced === true`인 경우
- 비밀번호 변경 페이지로 강제 이동

---

## 핵심 유틸리티

### src/lib/cookie.ts

**역할**: 쿠키 관리 유틸리티.

**주요 함수**:

```typescript
export const getCookie = (name: string): string | undefined;
export const setCookie = (name: string, value: string, days?: number): void;
export const deleteCookie = (name: string): void;
```

---

### src/lib/encrypt.ts & decrypt.ts

**역할**: 암호화/복호화 (crypto-js 사용).

**사용처**:

- 민감한 데이터 전송
- 설정 파일 암호화

---

### src/lib/getWorkspaceInfo.ts

**역할**: 현재 워크스페이스 정보 조회.

**반환 값**:

```typescript
{
  workspaceId: number;
  workspaceName: string;
  permissions: string[];
  // ...
}
```

---

### src/lib/getDirectManager.ts

**역할**: 사용자의 직속 상사 조회.

**사용처**:

- 승인 라인 설정
- 조직도 표시
- 1:1 미팅 대상 자동 설정

---

### src/lib/checkWorkspacePermission.ts

**역할**: 워크스페이스 권한 체크.

**권한 종류**:

- `admin`: 관리자
- `manager`: 매니저
- `member`: 일반 멤버

**사용 예시**:

```typescript
if (checkWorkspacePermission("admin")) {
  // 관리자 전용 기능
}
```

---

### src/lib/excelDownload.ts

**역할**: 엑셀 다운로드 유틸리티 (xlsx 사용).

**주요 함수**:

```typescript
export const downloadExcel = (data: any[], filename: string): void;
export const exportToExcel = (tableId: string, filename: string): void;
```

---

### src/lib/download.js

**역할**: 파일 다운로드 헬퍼.

**기능**:

- Blob 다운로드
- URL 다운로드
- 파일명 자동 설정

---

### src/lib/constants.js

**역할**: 애플리케이션 전역 상수 정의.

**주요 상수**:

```javascript
export const DATE_FORMAT = "YYYY-MM-DD";
export const DATETIME_FORMAT = "YYYY-MM-DD HH:mm:ss";
export const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
export const ALLOWED_FILE_EXTENSIONS = [".jpg", ".png", ".pdf", ".xlsx"];
// ... 수십 개의 상수
```

---

## 다국어 설정

### src/locales/i18n.ts

**역할**: i18next 초기화 및 언어 설정.

**지원 언어** (8개):

- ko (한국어) - 기본
- en (영어)
- ja-JP (일본어)
- zh-CN (중국어)
- id-ID (인도네시아어)
- vi-VN (베트남어)
- th-TH (태국어)

**설정**:

```typescript
i18n.use(initReactI18next).init({
  resources: {
    ko: { translation: koTranslation },
    en: { translation: enTranslation },
    // ...
  },
  lng: "ko", // 기본 언어
  fallbackLng: "ko", // 번역 없을 시 대체 언어
  interpolation: {
    escapeValue: false,
  },
});
```

**사용 예시**:

```typescript
import { useTranslation } from "react-i18next";

const MyComponent = () => {
  const { t } = useTranslation();

  return <div>{t("common.save")}</div>;
};
```

---

## 환경 변수

모든 핵심 파일에서 사용되는 환경 변수:

```bash
# API 엔드포인트
VITE_API_URL=https://api.example.com
VITE_PEOPLE_SERVER=https://people.example.com
VITE_NOTIFICATION_API=https://notification.example.com
VITE_NOTIFICATION_WS=wss://notification.example.com/cable
VITE_DOWNLOAD_API_URL=https://download.example.com

# Optimiz 서버
VITE_OPTIMIZ_TIME_API_URL=https://time.optimiz.com
VITE_OPTIMIZ_HRM_API_URL=https://hrm.optimiz.com
VITE_OPTIMIZ_SYSTEM_API_URL=https://system.optimiz.com
VITE_OPTIMIZ_PAY_API_URL=https://pay.optimiz.com

# 라이센스
VITE_AG_GRID_LICENSE_KEY=...
VITE_IBSHEET_LICENSE_KEY=...
VITE_MUI_X_LICENSE_KEY=...

# Sentry
VITE_SENTRY_ORG=...
VITE_SENTRY_PROJECT=...
VITE_SENTRY_AUTH_TOKEN=...

# 빌드 환경
VITE_BUILD_ENV=local|staging|production
```

---

## 파일 의존성 그래프

```
index.ts (진입점)
  ↓
App.jsx (루트 컴포넌트)
  ├─ config/store.js (Redux Store)
  │   └─ modules/index.js (Root Reducer)
  ├─ containers/Route.jsx (라우팅)
  ├─ locales/i18n.ts (다국어)
  └─ lib/authenticate.js (인증)
      ├─ lib/axiauth.js (API 인터셉터)
      │   ├─ config/api.js (API 엔드포인트)
      │   ├─ lib/handleLogout.ts
      │   └─ lib/handleInitialPasswordChange.ts
      ├─ lib/cookie.ts
      ├─ lib/getWorkspaceInfo.ts
      └─ lib/checkWorkspacePermission.ts
```

---

## 다음 문서

- [tech-stack.md](tech-stack.md): 기술 스택 상세
- [project-structure.md](project-structure.md): 프로젝트 구조
- [code-style.md](code-style.md): 코딩 규칙 및 컨벤션
- [overview.md](overview.md): ppfront 전체 개요
