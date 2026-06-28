@echo off
set JAVA_HOME=C:\Program Files\Java\jdk-17
echo ================================
echo   民宿预约管理系统 - 后端启动
echo ================================
echo JAVA_HOME: %JAVA_HOME%
echo 首次启动会下载 Maven 及依赖，请耐心等待...
echo.
call .\mvnw.cmd spring-boot:run
pause
