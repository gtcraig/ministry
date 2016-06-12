# -*- coding: utf-8 -*-

import sys
import codecs
import os

def findCharacters(authCode, volumeNumber):
    #print('\tVolume: ' + str(volumeNumber))
    with open('ministry/%s/%s%d.txt' % (authCode, authCode, volumeNumber), 'r+') as f:
        content = f.read()
        content = content.replace('¬',"'")
        content = content.replace('¦','^')
        content = content.replace(str(chr(145)),"'")
        content = content.replace(str(chr(146)),"'")
        content = content.replace(str(chr(147)),'"')
        content = content.replace(str(chr(148)),'"')
        content = content.replace(str(chr(149)),'.')
        content = content.replace(str(chr(133)),'...')
        content = content.replace(str(chr(150)),'-')
        content = content.replace(str(chr(151)),'-')
        content = content.replace(str(chr(180)),"'") # ´
        content = content.replace(str(chr(183)),".") # ·
        content = content.replace(str(chr(226)),"'")
        lines = content.split('\n')
        printNonAsciiChars(authCode, volumeNumber, content, lines)
        writeNewSource(authCode, volumeNumber, content)

def printNonAsciiChars(authCode, volumeNumber, s, lines):
    lineNumber = 0
    colNumber = 0
    for c in s:
        colNumber += 1
        if c == '\n':
            lineNumber += 1
            colNumber = 0
        if ord(c) > 128:
            if not ((c in 'ÂàäÉéèÏïîÔôâöòóêëÚüûç£§°½†') or (ord(c) == 134) or (ord(c) == 136)): # 134 is † 136 is ^ variant
                print(authCode + ' ' + str(volumeNumber) + ' ' + str(lineNumber+1) + ':' + str(colNumber) + ' - ' + c + ': ' + str(ord(c)))
                #print(lines[lineNumber] + '\n')

def writeNewSource(authCode, volumeNumber, content):
    directory = 'new/%s' % (authCode)
    if not os.path.exists(directory):
        os.makedirs(directory)
    with open(directory + '/%s%d.txt' % (authCode, volumeNumber), 'w') as f:
        f.write(content)

def procressAllAuthors(authors):
    for author in authors:
        processSingleAuthor(author)

def processSingleAuthor(author):
    print('Processing: ' + author.code)
    for i in range(1,author.numBooks + 1):
       findCharacters(author.code, i)


class Author:
    def __init__(self, code, numBooks):
        self.code = code
        self.numBooks = numBooks

authors = [Author("cac", 37),
           Author('fer', 21),
           Author('jbs', 17),
           Author('jnd', 52),
           Author('jt', 103)]

#processSingleAuthor(authors[7])

procressAllAuthors(authors)


