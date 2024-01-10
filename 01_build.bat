@echo off

pushd "%~dp0docs"

::--------------------------------------------------------------------
:: 1. Run `docfx build`
::--------------------------------------------------------------------
docfx build
SET LastExitCode=%ERRORLEVEL%
if %LastExitCode% neq 0 (
  echo Failed to execute command with ExitCode=%LastExitCode% ...
  goto on_error
)

::--------------------------------------------------------------------
:: 2. Create search index.
::--------------------------------------------------------------------
call npx.cmd pagefind --site _site
SET LastExitCode=%ERRORLEVEL%
if %LastExitCode% neq 0 (
  echo Failed to execute command with ExitCode=%LastExitCode% ...
  goto on_error
)

::--------------------------------------------------------------------
:: 3. Serve documentation site.
::--------------------------------------------------------------------
docfx serve _site --open-browser
SET LastExitCode=%ERRORLEVEL%
if %LastExitCode% neq 0 (
  echo Failed to execute command with ExitCode=%LastExitCode% ...
  goto on_error
)


:on_success
popd
exit /b 0

:on_error
popd
pause
exit /b %LastExitCode%