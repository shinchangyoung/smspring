@echo off
echo ========================================
echo    DB 연동 테스트 실행 스크립트
echo ========================================
echo.

echo [1/4] 프로젝트 빌드 확인...
call gradlew build -x test
if %errorlevel% neq 0 (
    echo ❌ 빌드 실패! 테스트를 중단합니다.
    pause
    exit /b 1
)
echo ✅ 빌드 성공!
echo.

echo [2/4] 데이터베이스 연결 테스트 실행...
call gradlew test --tests MenuTests.testDatabaseConnection
if %errorlevel% neq 0 (
    echo ❌ 데이터베이스 연결 테스트 실패!
    echo    - PostgreSQL 서버가 실행 중인지 확인하세요
    echo    - application-dev.yml 설정을 확인하세요
    pause
    exit /b 1
)
echo ✅ 데이터베이스 연결 테스트 성공!
echo.

echo [3/4] 메뉴 서비스 통합 테스트 실행...
call gradlew test --tests MenuTests
if %errorlevel% neq 0 (
    echo ❌ 메뉴 서비스 테스트 실패!
    pause
    exit /b 1
)
echo ✅ 메뉴 서비스 테스트 성공!
echo.

echo [4/4] AI DB 서비스 테스트 실행...
echo    (AI API 호출이 포함되므로 시간이 걸릴 수 있습니다...)
call gradlew test --tests AiDbServiceTests
if %errorlevel% neq 0 (
    echo ❌ AI DB 서비스 테스트 실패!
    echo    - OpenAI API 키 설정을 확인하세요
    echo    - 인터넷 연결을 확인하세요
    pause
    exit /b 1
)
echo ✅ AI DB 서비스 테스트 성공!
echo.

echo ========================================
echo    🎉 모든 테스트가 성공적으로 완료되었습니다!
echo ========================================
echo.
echo 테스트 결과 리포트를 확인하려면:
echo   build/reports/tests/test/index.html
echo.
pause
