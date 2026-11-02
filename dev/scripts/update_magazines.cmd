@echo off
rem Build any missing AWIIS / NOM magazine JSON on the "magazine" branch and commit it.
rem Options are passed through, e.g.  update_magazines --push   or   update_magazines --changed
python "%~dp0update_magazines.py" %* & exit /b %errorlevel%
