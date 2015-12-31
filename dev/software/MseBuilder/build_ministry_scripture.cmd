
cd c:\tmp\epub

rmdir /s/q gtscripture

xcopy /E /I epub gtscripture

zip -9 -r epub_gtscripture.zip gtscripture

move epub_gtscripture.zip C:\Users\Craig.FB\Dropbox\GoodTeaching

rmdir /s/q gtscripture



mkdir gtscripture

xcopy /E /I mobi gtscripture

zip -9 -r mobi_gtscripture.zip gtscripture

move mobi_gtscripture.zip C:\Users\Craig.FB\Dropbox\GoodTeaching

rmdir /s/q gtscripture
