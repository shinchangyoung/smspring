# DB 연동 테스트 실행 가이드

## 🧪 테스트 파일 구조

```
ai/src/test/java/edu/sm/menu/
├── MenuTests.java           # 메뉴 서비스 통합 테스트
├── AiDbServiceTests.java    # AI DB 서비스 테스트
└── AiDbControllerTests.java # 컨트롤러 API 테스트
```

## 🚀 테스트 실행 방법

### 1. 전체 테스트 실행
```bash
cd ai
./gradlew test
```

### 2. 특정 테스트 클래스 실행
```bash
# 메뉴 서비스 테스트만 실행
./gradlew test --tests MenuTests

# AI DB 서비스 테스트만 실행
./gradlew test --tests AiDbServiceTests

# 컨트롤러 테스트만 실행
./gradlew test --tests AiDbControllerTests
```

### 3. 특정 테스트 메서드 실행
```bash
# 데이터베이스 연결 테스트만 실행
./gradlew test --tests MenuTests.testDatabaseConnection

# 주문 처리 테스트만 실행
./gradlew test --tests AiDbServiceTests.testAiServiceDbBasedOrderProcessing
```

### 4. 테스트 결과 확인
```bash
# 테스트 결과 HTML 리포트 확인
./gradlew test
open build/reports/tests/test/index.html
```

## 📋 테스트 내용

### MenuTests.java
- ✅ **메뉴 서비스 통합 테스트**: 전체/사용가능/카테고리별 메뉴 조회
- ✅ **토핑 서비스 통합 테스트**: 전체/사용가능 토핑 조회
- ✅ **사이드 메뉴 서비스 통합 테스트**: 전체/사용가능 사이드메뉴 조회
- ✅ **데이터베이스 연결 테스트**: DB 연결 상태 및 기본 데이터 확인
- ✅ **메뉴 CRUD 테스트**: 메뉴 등록/조회/수정/삭제 테스트

### AiDbServiceTests.java
- ✅ **AI 주문 처리 테스트**: 다양한 주문 패턴 테스트
- ✅ **잘못된 주문 테스트**: 존재하지 않는 메뉴 주문 처리
- ✅ **복잡한 주문 테스트**: 여러 메뉴가 포함된 주문 처리
- ✅ **성능 테스트**: AI 서비스 응답 시간 측정

### AiDbControllerTests.java
- ✅ **주문 API 테스트**: POST /ai/db/order 엔드포인트 테스트
- ✅ **메뉴 조회 API 테스트**: GET /ai/db/menus 엔드포인트 테스트
- ✅ **토핑 조회 API 테스트**: GET /ai/db/toppings 엔드포인트 테스트
- ✅ **사이드메뉴 조회 API 테스트**: GET /ai/db/side-dishes 엔드포인트 테스트
- ✅ **메뉴 추가 API 테스트**: POST /ai/db/menus 엔드포인트 테스트
- ✅ **카테고리별 조회 API 테스트**: GET /ai/db/menus/category/{category} 테스트

## 🔍 테스트 전 확인사항

### 1. 데이터베이스 연결 확인
- PostgreSQL 서버가 실행 중인지 확인
- `application-dev.yml`의 데이터베이스 설정 확인
- 테스트용 데이터가 삽입되어 있는지 확인

### 2. AI API 설정 확인
- OpenAI API 키가 설정되어 있는지 확인
- 인터넷 연결 상태 확인 (AI API 호출 필요)

### 3. 애플리케이션 설정 확인
```bash
# 프로필 확인
grep -r "active" src/main/resources/application.yml

# 데이터베이스 설정 확인
grep -A 5 "datasource" src/main/resources/application-dev.yml
```

## 📊 테스트 결과 예시

### 성공적인 테스트 실행 결과
```
BUILD SUCCESSFUL in 45s
12 actionable tasks: 12 executed

> Task :test
2025-01-XX INFO  --- MenuTests : === 데이터베이스 연결 테스트 시작 ===
2025-01-XX INFO  --- MenuTests : ✅ 메뉴 테이블 연결 성공: 4 개 레코드
2025-01-XX INFO  --- MenuTests : ✅ 토핑 테이블 연결 성공: 2 개 레코드
2025-01-XX INFO  --- MenuTests : ✅ 사이드메뉴 테이블 연결 성공: 1 개 레코드
2025-01-XX INFO  --- MenuTests : === 데이터베이스 연결 테스트 완료 ===
```

### 실패 시 확인사항
1. **데이터베이스 연결 오류**: PostgreSQL 서비스 상태 확인
2. **AI API 오류**: API 키 설정 및 인터넷 연결 확인
3. **테이블 없음 오류**: SQL 스크립트 실행 확인
4. **빌드 오류**: 의존성 및 설정 파일 확인

## 🛠️ 문제 해결

### 일반적인 문제들

1. **테스트 실패: 데이터베이스 연결 불가**
   ```bash
   # PostgreSQL 서비스 상태 확인
   sudo systemctl status postgresql
   
   # 데이터베이스 연결 테스트
   psql -h localhost -U postgres -d postgres
   ```

2. **테스트 실패: AI API 오류**
   ```bash
   # API 키 확인
   echo $OPENAI_API_KEY
   
   # 네트워크 연결 확인
   ping api.openai.com
   ```

3. **테스트 실패: 테이블 없음**
   ```bash
   # SQL 스크립트 수동 실행
   psql -h localhost -U postgres -d postgres -f src/main/resources/sql/menu_schema.sql
   ```

## 📈 테스트 커버리지 확인

```bash
# 테스트 커버리지 리포트 생성
./gradlew jacocoTestReport

# 커버리지 리포트 확인
open build/reports/jacoco/test/html/index.html
```

이제 모든 DB 연동 테스트가 준비되었습니다! 🎉
