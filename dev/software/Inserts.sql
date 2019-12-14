SET @rank=5;
insert into mse_collection_article(collectionid, groupno, articleno, author, vol, page, series, article)
select 1,3, @rank:=@rank+1 as articleno, a.author, a.vol, a.page,
'Man of Faith', a.article from mse_article a
where author='FER' and vol=1 and page between 232 and 289;





SET @rank=96;
insert into mse_collection_article(collectionid, groupno, articleno, author, vol, page, series, article)
select 1,3, @rank:=@rank+1 as articleno, a.author, a.vol, a.page,
'Readings and Addresses in the USA and Canada 1902', a.article from mse_article a
where author='FER' and vol=17 ;



SET @rank=32;
insert into mse_collection_article(collectionid, groupno, articleno, author, vol, page, series, article)
select 1,3, @rank:=@rank+1 as articleno, a.author, a.vol, a.page,
null, a.article from mse_article a
where author='FER' and vol=14 and page = 185 ;

