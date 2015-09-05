SELECT br.bookid, bb.bookname, br.chapter, br.author, br.vol, br.page, a.article, a.scriptures
FROM mse_bible_ref br, mse_bible_book bb, mse_article a
WHERE bb.bookid = br.bookid
AND a.author = br.author
AND a.vol = br.vol
AND a.page = br.article_page
AND br.article_primary=1
GROUP BY br.bookid, bb.bookname, br.chapter, br.author, br.vol, br.page, a.article, a.scriptures
ORDER BY 1,3,4,5,6;


SELECT bookid, MAX(bookname), chapter, COUNT(*) articles
FROM (
	SELECT br.bookid, bb.bookname, br.chapter, br.author, br.vol, br.page
	FROM mse_bible_ref br, mse_bible_book bb, mse_article a
	WHERE bb.bookid = br.bookid
	AND a.author = br.author
	AND a.vol = br.vol
	AND a.page = br.article_page
	AND br.article_primary=1
	GROUP BY br.bookid, bb.bookname, br.chapter, br.author, br.vol, br.page
) r
GROUP BY bookid, chapter
ORDER BY 1,3;


