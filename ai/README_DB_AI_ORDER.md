# DB 기반 AI 주문 시스템

이 프로젝트는 `AiServiceFewShot`의 하드코딩된 프롬프트 대신 데이터베이스에서 메뉴 정보를 동적으로 가져와서 AI 주문을 처리하는 시스템입니다.

## 🏗️ 시스템 구조

### 데이터베이스 테이블
- **menu**: 메뉴 정보 (메뉴명, 가격, 이미지, 카테고리 등)
- **topping**: 토핑 정보 (토핑명, 가격 등)
- **side_dish**: 사이드 메뉴 정보 (사이드메뉴명, 가격 등)

### 주요 컴포넌트
1. **DTO 클래스**: Menu, Topping, SideDish, OrderItem
2. **Repository**: 데이터베이스 접근을 위한 MyBatis 매퍼
3. **Service**: 비즈니스 로직 처리
4. **AiServiceDbBased**: DB 기반 AI 주문 처리 서비스
5. **AiDbController**: REST API 엔드포인트
6. **프론트엔드**: 실시간 주문 처리 웹 인터페이스

## 🚀 사용법

### 1. 데이터베이스 설정
PostgreSQL 데이터베이스가 실행 중이어야 합니다.

### 2. 애플리케이션 실행
```bash
cd ai
./gradlew bootRun
```

### 3. 웹 인터페이스 접속
브라우저에서 `http://localhost/ai-db-order` 접속

### 4. 주문 테스트
웹 페이지에서 다음과 같은 주문을 입력해보세요:
- "돈코츠라멘에 면 추가하고 차슈도 넣어주세요."
- "소유라멘 하나랑, 미소라멘 하나에 교자 추가해주세요."
- "시오라멘 두 개 주세요."

## 🔧 API 엔드포인트

### 주문 처리
- `POST /ai/db/order` - AI 주문 처리
  - 파라미터: `order` (주문 텍스트)
  - 응답: JSON 배열 형태의 주문 결과

### 메뉴 관리
- `GET /ai/db/menus` - 모든 메뉴 조회
- `GET /ai/db/menus/available` - 사용 가능한 메뉴 조회
- `GET /ai/db/menus/category/{category}` - 카테고리별 메뉴 조회
- `POST /ai/db/menus` - 메뉴 추가

### 토핑 관리
- `GET /ai/db/toppings` - 모든 토핑 조회
- `GET /ai/db/toppings/available` - 사용 가능한 토핑 조회
- `POST /ai/db/toppings` - 토핑 추가

### 사이드 메뉴 관리
- `GET /ai/db/side-dishes` - 모든 사이드 메뉴 조회
- `GET /ai/db/side-dishes/available` - 사용 가능한 사이드 메뉴 조회
- `POST /ai/db/side-dishes` - 사이드 메뉴 추가

## 🧪 테스트

브라우저 개발자 도구 콘솔에서 다음 명령어를 사용하여 테스트할 수 있습니다:

```javascript
// 메뉴 정보 테스트
testMenuInfo();

// 주문 테스트 실행
runTests();
```

## 📊 응답 형식

AI는 다음과 같은 JSON 배열 형식으로 주문을 반환합니다:

```json
[
  {
    "menuName": "돈코츠라멘",
    "quantity": 1,
    "price": 10000,
    "imageName": "donkotsu.jpg",
    "extraNoodles": true,
    "tasteStrength": "보통",
    "toppings": ["차슈"],
    "sideDishes": []
  }
]
```

## 🔄 기존 시스템과의 차이점

### 기존 AiServiceFewShot
- 하드코딩된 프롬프트 사용
- 메뉴 정보가 코드에 직접 포함
- 메뉴 변경 시 코드 수정 필요

### 새로운 AiServiceDbBased
- 데이터베이스에서 동적으로 메뉴 정보 로드
- 실시간 메뉴 업데이트 가능
- 관리자가 웹 인터페이스로 메뉴 관리 가능
- 더 유연하고 확장 가능한 구조

## 🛠️ 개발 및 확장

### 새로운 메뉴 추가
1. 데이터베이스에 직접 INSERT 또는
2. API를 통해 메뉴 추가:
```bash
curl -X POST http://localhost/ai/db/menus \
  -H "Content-Type: application/json" \
  -d '{
    "menuName": "신메뉴",
    "price": 8000,
    "imageName": "new.jpg",
    "category": "라멘",
    "description": "새로운 라멘",
    "isAvailable": true
  }'
```

### 새로운 토핑/사이드메뉴 추가
마찬가지로 API를 통해 동적으로 추가 가능합니다.

## 📝 주의사항

1. **데이터베이스 연결**: PostgreSQL이 실행 중이어야 합니다.
2. **AI API 키**: OpenAI API 키가 설정되어 있어야 합니다.
3. **메뉴 이름**: AI가 정확히 인식할 수 있도록 메뉴 이름을 일관되게 사용하세요.
4. **가격 계산**: 토핑과 사이드메뉴 가격이 자동으로 합산됩니다.

## 🔍 문제 해결

### 일반적인 문제들
1. **데이터베이스 연결 오류**: PostgreSQL 서비스 상태 확인
2. **AI 응답 오류**: API 키 설정 확인
3. **메뉴가 표시되지 않음**: 데이터베이스에 기본 데이터 삽입 확인

### 로그 확인
애플리케이션 로그에서 상세한 오류 정보를 확인할 수 있습니다.
