# -*- coding: utf-8 -*-

import sys
import nltk
import re
import pprint 	
import time
from enum import Enum
from nltk import word_tokenize
from nltk.corpus import stopwords
from os import system
from nltk.tokenize import *

class ProcessText:
	tokens=None
	text=None
	stop_words = stopwords.words("spanish")
	def __init__(self):
		print ("ProcessText")
	def addStopWord(self,pWord):
		self.stop_words.append(pWord)
	def setText(self,pText):
		self.text=pText;	
	def getText(self):
		return self.text
	def get_word_tokenize(self):
		return nltk.word_tokenize(self.text);
	def get_RegexpTokenizer(self):	
		tokenizer = RegexpTokenizer('\w+|\$[\d\.]+|\S+')
		return tokenizer.tokenize(self.text)
	def getLine_Tokens(self):
		if self.line_tokens  is None:
			self.line_tokens  = LineTokenizer(blanklines='discard').tokenize(self.raw)
		return self.line_tokens		
	def getTokenText(self):
		if self.text is None:
			self.text=nltk.Text(self.getTokens())
		return self.text 
	def getCleanText(self):	
		text=self.get_RegexpTokenizer()
		lower_text = [word.lower () for word in text]
		#print("------------------- lower_text --------------------------")
		#print(lower_text)
		#print("------------------- tmp_text --------------------------")	
		#print(tmp_text)
		

		tmp_text = ["".join(re.split("[(:\".,\´! ')’\¿¡?”“;%&–$-]", word)) for word in lower_text]
		#tmp_text = ["".join(re.split("[(:\".,\´! )\¿?”;“%&-]", word)) for word in lower_text]
		for tmp in tmp_text:
			if(tmp==""):
				tmp_text.remove("")

		self.clean_text = [word for word in tmp_text if word.lower () not in self.stop_words]
		#print("------------------- self.clean_text  --------------------------")	
		#print(self.clean_text )
		return self.clean_text
	def getFdist(self,text):	
		self.fdist=nltk.FreqDist(text)
		return self.fdist

		