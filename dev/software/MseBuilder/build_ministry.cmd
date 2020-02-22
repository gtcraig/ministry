
cd c:\tmp\epub

rmdir /s/q ministry

xcopy /E /I epub ministry

zip -9 -r epub_ministry.zip ministry

move epub_ministry.zip C:\Users\Craig\Dropbox\GoodTeaching

rmdir /s/q ministry



mkdir ministry

xcopy /E /I mobi\cac* ministry\cac
xcopy /E /I mobi\fer* ministry\fer
xcopy /E /I mobi\jbs* ministry\jbs
xcopy /E /I mobi\jnd* ministry\jnd
xcopy /E /I mobi\jt* ministry\jt
xcopy /E /I mobi\ajg* ministry\ajg
xcopy /E /I mobi\chm* ministry\chm
xcopy /E /I mobi\smc* ministry\smc
xcopy /E /I mobi\jgb* ministry\jgb

zip -9 -r mobi_ministry.zip ministry

move mobi_ministry.zip C:\Users\Craig\Dropbox\GoodTeaching

rmdir /s/q ministry
