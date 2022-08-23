# Minstry Textfile Markdown Guide
## Lines Beginning...
* **{1} {2}** - Page Numbers.  These appear at the start of the page (the line before the first line of the page) unlike the printed volume where they appear at the end.
	* Note, some volumes begin at page 0 and include a PREFATORY NOTE
* **{#** - Volume Title, where it appears.  E.g. *cac1.txt*:
	* {#Volume 1 - An Outline of Genesis}
* **$** - Article Groups
	* To reflect the fact that often articles are grouped together (such as those relating to a three day meeting), Article Groups have been added to the text.  
	* See *feb8.txt* as an example.
	* An Article Group contains three fixed lines, beginning with a line with $
		* **$**ARTICLE GROUP NAME
			* e.g. *$THE SERVICE OF GRACE AND ITS RESULTS IN THE SAINTS*
		* **|** City **|** Date - this line begins | and often simply has "||" as the text has not yet been enriched with the information which is contained in the contents page of the printed volumes.
			* e.g. *| New York | July 1939*
		* Summary line - no specific beginning but if there is no summary (again found in the contents of the printed volume) the text will contain a blank line. 
* **¦** or **\<sup\>** - These lines are Footnotes (depending on the source text), Mr Darby is typically **\<sup\>** as this was how the text was received, all the other ministries are **¦**.
## Lines Ending...
See the Abstract.Paragraph.EndsAbruptly() for what is deemed to be an 'abrupt' end to a paragraph, in other words for the flow, it should continue onto the new page.  On the goodteaching.org the next page number is discretely added to the between old and new pages.
## Article Titles
See Abstract.Paragraph.IsTitle()
* Article Titles are as a rule all in uppercase
* The specific rule is that there must be more than 70% uppercase versus other characters (lower and periods)
* **PREFATORY NOTE** and **\*NOTE\*** are excluded from the list of Article Titles. 
### Article Scriptures
The line immediately following an Article Title is considered to contain the Scriptures read, see Bible references for more clarification on these.  If more than one scripture has been read, Bible references will be separated by semi-colons (;)

Article Scriptures are differentiated in goodteaching.org to allow searching on "Scriptures read at the beginning of the meeting", in other words to locate articles that are likely to be on the subject of that Scripture. 
## Initials
See MseParser.GetInitials().  Initials are determined by the following rules, which were derived by trial and error based on all the ministries, and looking at exceptions!
* Ignoring lines of length less than 3 (typically page numbers)
* Skipping past a period if it is the first character
* Matching against a set of constants (Rem., Quest. and the bold equivalents)
	* If these match, they are used as the initials, and the rest of the line is considered "the text".
* If the line has not been ignored or matched, then
	* Consider the first **11** characters of the line as the "window"
	* Count the number of dots until a space is found
	* If there is at least one dot, the first part is accepted as initials (sometimes there are single character "initials")
		* Except if the line begins with "an ellispsis" (i.e. three consecutive dots, not the single ellipsis character which is not used).
## General Formatting
* Asterisk (**\***) around a word or phrase for italics
* At-sign (**@**) Bible references begin with @ followed by the Book and Chapter (mandatory, except for single-chapter books), and they further be followed by 
	* verse information if a colon immediately follows the chapter number 
	* or for single-chapter books, it must be a number that follows the book name
	* after the first verse there may be either a hypen (-) or comma (,) indicating a range or pair of verses respectively.
	* Bible references may appear on any line, including the line after an Article Title.
* Tilde (**~**) and NOT (**¬**) are used for a possessive apostrophe.  Some of the text contains ordinary apostrophes as possessives (ASCII 39)
* Left single quote (**`**) is used to indicate a Hymn number reference
